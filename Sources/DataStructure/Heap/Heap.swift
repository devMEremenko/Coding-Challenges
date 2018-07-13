//
//  Heap.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/12/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class HeapTest: XCTestCase {
    
}

extension HeapTest {
    
    //MARK: Min Heap Tests
    
    func testMinAddition() {
        
        let heap = Heap<Int>(sort: <)
        
        heap.add(7)
        XCTAssert(heap.peek == 7)
        
        heap.add(4)
        XCTAssert(heap.peek == 4)
        
        heap.add(3)
        XCTAssert(heap.peek == 3)
        
        heap.add(1)
        XCTAssert(heap.peek == 1)
        
        heap.add(9)
        XCTAssert(heap.peek == 1)
    }
    
    func testMinPoll() {
        
        let heap = Heap<Int>(sort: <)
        
        heap.add([4, 3, 1, 2, 5])
        
        for expectedItem in 1...5 {
            XCTAssert(heap.poll() == expectedItem)
        }
    }
    
    func testMinCombined() {
        
        let heap = Heap<Int>(sort: <)
        
        heap.add([5, 4, 3, 2, 1])
        
        heap.poll() /// [2, 3, 4, 5]
        heap.poll() /// [3, 4, 5]
        
        heap.add([7, 1, 6]) /// [1, 3, 4, 5, 6, 7]
        heap.add([2, 8]) /// [1, 2, 3, 4, 5, 6, 7, 8]
        
        for expectedItem in 1...8 {
            XCTAssert(heap.poll() == expectedItem)
        }
    }
    
    func testMinRepeatedItems() {
        let heap = Heap<Int>(sort: <)
        
        heap.add([1, 5, 2, 5, 4, 3, 4, 2, 3, 2, 1, 3, 4, 5, 1])
        
        for expectedItem in 1...5 {
            for _ in 1...3 {
                XCTAssert(heap.poll() == expectedItem)
            }
        }
        
        XCTAssert(heap.items.isEmpty)
    }
    
    func testMinCreationFromArray() {
        let heap = Heap<Int>(sort: <, array: [1, 5, 2, 5, 4, 3, 4, 2, 3, 2, 1, 3, 4, 5, 1])
        
        for expectedItem in 1...5 {
            for _ in 1...3 {
                XCTAssert(heap.poll() == expectedItem)
            }
        }
        
        XCTAssert(heap.items.isEmpty)
    }
}

extension HeapTest {
    
    //MARK: Max Heap Tests
    
    func testMaxAddition() {
        
        let heap = Heap<Int>(sort: >)
        
        heap.add(1)
        XCTAssert(heap.peek == 1)
        
        heap.add(3)
        XCTAssert(heap.peek == 3)
        
        heap.add(4)
        XCTAssert(heap.peek == 4)
        
        heap.add(9)
        XCTAssert(heap.peek == 9)
        
        heap.add(7)
        XCTAssert(heap.peek == 9)
    }
    
    func testMaxPoll() {
        
        let heap = Heap<Int>(sort: >)
        
        heap.add([4, 3, 1, 2, 5])
        
        for expectedItem in stride(from: 5, through: 1, by: -1) {
            XCTAssert(heap.poll() == expectedItem)
        }
    }
    
    func testMaxCombined() {
        
        let heap = Heap<Int>(sort: >)
        
        heap.add([5, 4, 3, 2, 1])
        
        heap.poll()
        heap.poll()
        
        heap.add([8, 4])
        heap.add([5, 6, 7])
        
        for expectedItem in stride(from: 8, through: 1, by: -1) {
            XCTAssert(heap.poll() == expectedItem)
        }
    }
    
    func testMaxRepeatedItems() {
        let heap = Heap<Int>(sort: >)
        
        heap.add([1, 5, 2, 5, 4, 3, 4, 2, 3, 2, 1, 3, 4, 5, 1])
        
        for expectedItem in stride(from: 5, through: 1, by: -1) {
            for _ in 1...3 {
                XCTAssert(heap.poll() == expectedItem)
            }
        }
        
        XCTAssert(heap.items.isEmpty)
    }
    
    func testMaxCreationFromArray() {
        let heap = Heap<Int>(sort: >, array: [1, 5, 2, 5, 4, 3, 4, 2, 3, 2, 1, 3, 4, 5, 1])
        
        for expectedItem in stride(from: 5, through: 1, by: -1) {
            for _ in 1...3 {
                XCTAssert(heap.poll() == expectedItem)
            }
        }
        
        XCTAssert(heap.items.isEmpty)
    }
}

class Heap<T> {
    
    private lazy var nodes = [T]()
    
    typealias Sort = (T, T) -> Bool
    
    private var sort: Sort
    
    init(sort: @escaping Sort) {
        self.sort = sort
    }
    
    init(sort: @escaping Sort, array: [T]) {
        self.sort = sort
        
        nodes = array
        
        let middleIndex = array.count / 2 - 1
        for i in stride(from: middleIndex, through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    func add<S: Sequence>(_ collection: S) where S.Iterator.Element == T {
        for item in collection {
            add(item)
        }
    }
    
    func add(_ item: T) {
        nodes.append(item)
        shiftUp()
    }
    
    @discardableResult
    func poll() -> T? {
        guard !nodes.isEmpty else { return nil }
        guard nodes.count > 1 else { return nodes.removeLast() }
        
        let item = nodes[0]
        nodes[0] = nodes.removeLast()
        shiftDown()
        return item
    }
    
    var peek: T? {
        return nodes.first
    }
    
    var items: Array<T> {
        return nodes
    }
}

private extension Heap {
    
    func shiftDown(_ fromParentIndex: Int = 0) {
        
        var parentIndex = fromParentIndex
        
        while hasLeftChild(at: parentIndex) {
            
            var minIndex = parentIndex
            
            if sort(leftChild(parentIndex), nodes[parentIndex]) {
                minIndex = leftChildIndex(parentIndex)
            }
            
            let hasRight = hasRightChild(at: parentIndex)
            
            if hasRight && sort(rightChild(parentIndex), leftChild(parentIndex)) {
                minIndex = rightChildIndex(parentIndex)
            } else {
                minIndex = leftChildIndex(parentIndex)
            }
            
            guard sort(nodes[minIndex], nodes[parentIndex]) else {
                break
            }

            /// Solution for a single Min / Max heap
            /*
            if hasRightChild(at: parentIndex) && rightChild(parentIndex) < leftChild(parentIndex) {
                minIndex = rightChildIndex(parentIndex)
            }

            
            if hasRightChild(at: parentIndex) && rightChild(parentIndex) < leftChild(parentIndex) {
                minIndex = rightChildIndex(parentIndex)
            }
            
            guard nodes[parentIndex] >= nodes[minIndex] else {
                break
            }
            */
            
            nodes.swapAt(parentIndex, minIndex)
            parentIndex = minIndex
        }
    }
    
    func shiftUp() {
        
        var childIndex = nodes.count - 1
        
        /// Solution for a single Min / Max heap
        /// parent(childIndex) >= nodes[childIndex]
        
        while hasParent(for: childIndex) && sort(nodes[childIndex], parent(childIndex)) {
            nodes.swapAt(childIndex, parentIndex(childIndex))
            childIndex = parentIndex(childIndex)
        }
    }
}

extension Heap {
    
    @inline(__always) private func parentIndex(_ childIndex: Int) -> Int {
        guard childIndex > 0 else { return -1 }
        return (childIndex - 1) / 2
    }
    
    @inline(__always) private func leftChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }
    
    @inline(__always) private func rightChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }
}

extension Heap {
    
    @inline(__always) private func leftChild(_ parentIndex: Int) -> T {
        return nodes[leftChildIndex(parentIndex)]
    }
    
    @inline(__always) private func rightChild(_ parentIndex: Int) -> T {
        return nodes[rightChildIndex(parentIndex)]
    }
    
    @inline(__always) private func parent(_ childIndex: Int) -> T {
        return nodes[parentIndex(childIndex)]
    }
}

extension Heap {
    
    @inline(__always) private func hasParent(for childIndex: Int) -> Bool {
        return self.parentIndex(childIndex) >= 0
    }
    
    @inline(__always) private func hasLeftChild(at parentIndex: Int) -> Bool {
        return leftChildIndex(parentIndex) < nodes.count
    }
    
    @inline(__always) private func hasRightChild(at parentIndex: Int) -> Bool {
        return rightChildIndex(parentIndex) < nodes.count
    }
}

extension Heap: Sequence {
    
    //TODO: Iterate without removing items from a heap
    //Hint: Search for all max/min items
    
    func makeIterator() -> AnyIterator<T> {
        return AnyIterator<T> {
            return self.poll()
        }
    }
}

extension Heap {
    
    //TODO: Iterate without removing items from a heap
    //Hint: Search for all max/min items
    
    func map<M>(_ mapping: (T) -> (M)) -> [M] {
        
        var result = [M]()
        result.reserveCapacity(nodes.count)
        
        for item in self {
            result.append(mapping(item))
        }
        
        return result
    }
}
