//
//  HastSet.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/26/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class HastSetTest: XCTestCase {
    
    /// This HashSet uses an array of linked lists to store the data.
    
    func testHashSet() {
        
        var set = HashSet<Int>()
        XCTAssert(set.contains(0) == false)
        
        set.add(0)
        set.add(5)
        set.add(10)
        set.add(15)
        set.add(5)
        set.add(0)
        
        XCTAssert(set.contains(0))
        XCTAssert(set.contains(5))
        XCTAssert(set.contains(10))
        XCTAssert(set.contains(15))
        XCTAssert(set.contains(3) == false)
        
        set.remove(10)
        XCTAssert(set.contains(10) == false)
        XCTAssert(set.contains(0))
        XCTAssert(set.contains(5))
        XCTAssert(set.contains(15))
        
        set.remove(5)
        XCTAssert(set.contains(5) == false)
        XCTAssert(set.contains(0))
        XCTAssert(set.contains(15))
        
        set.remove(0)
        set.remove(15)
        XCTAssert(set.contains(0) == false)
        XCTAssert(set.contains(15) == false)
    }
}

private struct HashSet<Value: Hashable> {
    
    private var buckets = [LinkedList<Value>?]()
    
    init(capacity: Int = 17) {
        let adjustedCapacity = capacity > 0 ? capacity : 17
        buckets = Array(repeating: nil, count: adjustedCapacity)
    }
    
    /// The number of buckets should be increased when 2/3 of the HashTable is filled.
    mutating func add(_ value: Value) {
        
        let index = _index(value)
        
        guard let bucket = buckets[index] else {
            let bucket = LinkedList<Value>()
            bucket.append(value: value)
            buckets[index] = bucket
            return
        }
        bucket.append(value: value)
    }
    
    func contains(_ value: Value) -> Bool {
        guard let bucket = buckets[_index(value)] else { return false }
        return bucket.contains(value: value)
    }
    
    func remove(_ value: Value) {
        guard let bucket = buckets[_index(value)] else { return }
        bucket.remove(value: value)
    }
}

private extension HashSet {
    
    @inline(__always) func _index(_ value: Value) -> Int {
        return abs(value.hashValue) % buckets.count
    }
}


private class LinkedList<T: Equatable> {
    
    public class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        weak var previous: LinkedListNode?
        
        public init(value: T) {
            self.value = value
        }
    }
    
    public typealias Node = LinkedListNode<T>
    
    private var head: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    public func contains(value: T) -> Bool {
        var temp = head
        while temp != nil {
            if temp?.value == value {
                return true
            }
            temp = temp?.next
        }
        return false
    }
    
    public func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public func remove(value: T) {
        
        while head?.value == value {
            head = head?.next
        }
        
        var temp = head
        var previous: Node? = nil
        
        while temp != nil {
            if temp?.value == value {
                previous?.next = temp?.next
                break
            }
            previous = temp
            temp = temp?.next
        }
    }
}
