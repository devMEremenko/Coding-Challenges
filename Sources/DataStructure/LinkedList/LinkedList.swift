//
//  LinkedList.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 8/30/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

// MARK: - Linked List tests

private class LinkedListExample: XCTestCase {}

extension LinkedListExample {
    
    func testCreation() {
        
        let list = List<Int>()
        XCTAssert(list.first == nil)
        XCTAssert(list.last == nil)
        XCTAssert(list.isEmpty == true)
    }
    
    func testAddToStart() {
        
        var list = List<Int>()
        list.addTo(start: 1)
        list.addTo(start: 2)
        list.addTo(start: 3)
        
        XCTAssert(list.items == [3, 2, 1])
        XCTAssert(list.firstNode?.value == 3)
        XCTAssert(list.lastNode?.value == 1)
        XCTAssert(list.isEmpty == false)
    }
    
    func testAddToEnd() {
        
        var list = List<Int>()
        list.addTo(end: 1)
        list.addTo(end: 2)
        list.addTo(end: 3)
        
        XCTAssert(list.items == [1, 2, 3])
        XCTAssert(list.firstNode?.value == 1)
        XCTAssert(list.lastNode?.value == 3)
        XCTAssert(list.isEmpty == false)
    }
}

extension LinkedListExample {
    
    func testRemoveFirst() {
        
        var list = List<Int>()
        list.addTo(end: 1)
        list.addTo(end: 2)
        list.addTo(end: 3)
        
        XCTAssert(list.removeFirst() == 1)
        XCTAssert(list.items == [2, 3])
        XCTAssert(list.firstNode?.value == 2)
        XCTAssert(list.lastNode?.value == 3)
        XCTAssert(list.isEmpty == false)
        
        XCTAssert(list.removeFirst() == 2)
        XCTAssert(list.items == [3])
        XCTAssert(list.firstNode?.value == 3)
        XCTAssert(list.lastNode?.value == 3)
        XCTAssert(list.isEmpty == false)
        
        XCTAssert(list.removeFirst() == 3)
        XCTAssert(list.items == [])
        XCTAssert(list.firstNode?.value == nil)
        XCTAssert(list.lastNode?.value == nil)
        XCTAssert(list.isEmpty == true)
    }
    
    func testRemoveLast() {
        
        var list = List<Int>()
        list.addTo(end: 1)
        list.addTo(end: 2)
        list.addTo(end: 3)
        
        XCTAssert(list.removeLast() == 3)
        XCTAssert(list.items == [1, 2])
        XCTAssert(list.firstNode?.value == 1)
        XCTAssert(list.lastNode?.value == 2)
        XCTAssert(list.isEmpty == false)
        
        XCTAssert(list.removeLast() == 2)
        XCTAssert(list.items == [1])
        XCTAssert(list.firstNode?.value == 1)
        XCTAssert(list.lastNode?.value == 1)
        XCTAssert(list.isEmpty == false)
        
        XCTAssert(list.removeLast() == 1)
        XCTAssert(list.items == [])
        XCTAssert(list.firstNode?.value == nil)
        XCTAssert(list.lastNode?.value == nil)
        XCTAssert(list.isEmpty == true)
    }
}

extension LinkedListExample {
    
    func testTraverseFromStart() {
        
        var list = List<Int>()
        list.addTo(start: 1)
        list.addTo(end: 2)
        list.addTo(end: 3)
        list.addTo(start: 4)
        
        var items = [Int]()
        var firstNode = list.firstNode
        
        while let first = firstNode {
            items.append(first.value)
            firstNode = firstNode?.next
        }
        
        XCTAssert(items == [4, 1, 2, 3])
    }
    
    func testTraverseFromEnd() {
        
        var list = List<Int>()
        list.addTo(start: 1)
        list.addTo(end: 2)
        list.addTo(end: 3)
        list.addTo(start: 4)
        
        var items = [Int]()
        var lastNode = list.lastNode
        
        while let last = lastNode {
            items.append(last.value)
            lastNode = lastNode?.previous
        }
        
        XCTAssert(items == [3, 2, 1, 4])
    }
}

extension LinkedListExample {
    
    func testContains() {
        
        var list = List<Int>()
        list.addTo(start: 1)
        list.addTo(end: 2)
        list.addTo(end: 3)
        list.addTo(start: 4)
        
        XCTAssert(list.contains({ $0 == 0 }) == false)
        XCTAssert(list.contains({ $0 == 3 }))
        XCTAssert(list.contains({ $0 == 2 }))
        XCTAssert(list.contains({ $0 == 4 }))
        XCTAssert(list.contains({ $0 == 1 }))
        XCTAssert(list.contains({ $0 == 5 }) == false)
    }
    
    func testRemoveWhere() {
        
        var list = List<Int>()
        list.addTo(start: 1)
        list.addTo(end: 2)
        list.addTo(end: 3)
        list.addTo(start: 4)
        
        XCTAssert(list.remove({ $0 == 0 }) == nil) /// Remove a non-existing item
        XCTAssert(list.remove({ $0 == 3 }) == 3)   /// Remove from the end
        XCTAssert(list.remove({ $0 == 1 }) == 1)   /// Remove from the middle
        XCTAssert(list.remove({ $0 == 2 }) == 2)
        XCTAssert(list.remove({ $0 == 2 }) == nil) /// Try to remove a deleted item
        XCTAssert(list.remove({ $0 == 4 }) == 4)   /// Remove from the beginning
        XCTAssert(list.remove({ $0 == 5 }) == nil) /// Remove a non-existing item
    }
}

// MARK: - Data Structure

struct List<Item> {
    
    /// This is a doubly linked list
    
    private var head: Node?
    private var tail: Node?
    
    init() {}
    
    init(_ item: Item) {
        self.head = Node(item)
        self.tail = head
    }
    
    var first: Item? {
        return head?.value
    }
    
    var last: Item? {
        return tail?.value
    }
    
    var isEmpty: Bool {
        return head == nil && tail == nil
    }
    
    fileprivate class Node {
        var value: Item
        var next: Node?
        var previous: Node?
        
        init(_ value: Item) {
            self.value = value
        }
    }
}

extension List {
    
    mutating func addTo(start item: Item) {
        let node = Node(item)
        node.next = head
        head?.previous = node
        head = node
        
        if tail == nil {
            tail = head /// List was empty
        }
    }
    
    mutating func addTo(end item: Item) {
        
        guard tail != nil else {
            /// List is empty
            tail = Node(item)
            head = tail
            return
        }
        
        let node = Node(item)
        node.previous = tail
        tail?.next = node
        tail = node
    }
}

extension List {
    
    @discardableResult
    mutating func removeFirst() -> Item? {
        
        defer {
            head = head?.next
            if head == nil {
                tail = nil
            }
        }
        
        return head?.value
    }
    
    @discardableResult
    mutating func removeLast() -> Item? {
        
        guard head != nil, tail != nil else { return nil }
        
        defer {
            let previous = tail?.previous
            previous?.next = nil /// Do not forget to nil the last value
            tail = previous
            
            if tail == nil {
                head = nil
            }
        }
        
        return tail?.value
    }
}

extension List {
    
    /// TODO: tests
    
    func contains(_ where: (Item) -> Bool) -> Bool {
        guard let node = head else { return false }
        return contains(node, `where`)
    }
    
    private func contains(_ node: Node?, _ where: (Item) -> Bool) -> Bool {
        var node = node /// makes mutable
        
        /// checks node.value
        if let value = node?.value, `where`(value) {
            return true
        }
        
        /// checks node.next values
        while let value = node?.next?.value {
            if `where`(value) {
                return true
            }
            node = node?.next
        }
        
        return false
    }
}

extension List {
    
    @discardableResult
    mutating func remove(_ where: (Item) -> Bool) -> Item? {
        guard let node = head else { return nil }
        return remove(node, `where`)
    }
    
    private mutating func remove(_ node: Node?, _ where: (Item) -> Bool) -> Item? {
        var node = node /// makes mutable
        
        /// checks node.value
        if let value = node?.value, `where`(value) {
            return removeFirst()
        }
        
        /// checks node.next values
        while let currentNode = node?.next {
            if `where`(currentNode.value) {
                let previous = currentNode.previous
                let next = currentNode.next
                
                previous?.next = next
                next?.previous = previous
                
                return currentNode.value
            }
            node = node?.next
        }
        
        return nil
    }
}

// MARK: - Debug (Private)

private extension List {
    
    var items: [Item] {
        
        var items = [Item]()
        var temp = head
        
        while let next = temp {
            items.append(next.value)
            temp = temp?.next
        }
        
        return items
    }
    
    var lastNode: Node? {
        return tail
    }
    
    var firstNode: Node? {
        return head
    }
}
