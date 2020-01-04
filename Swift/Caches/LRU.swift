//
//  LRU.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 10/17/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class LRUTests: XCTestCase {
    
    func test() {
        
        let cache = LRUCache<String, Int>(capacity: 2)
        
        
        
        XCTAssert(cache.findValue("1") == nil)
        
        cache.put(1, for: "1")
        cache.put(2, for: "2")
        
        XCTAssert(cache.findValue("1") == 1)
        
        cache.put(3, for: "3")
        
        XCTAssert(cache.findValue("2") == nil)
        XCTAssert(cache.findValue("3") == 3)
        XCTAssert(cache.findValue("1") == 1)
        
        /// TODO: fix this
        /*
        cache.put(4, for: "4")
        XCTAssert(cache.findValue("4") == 4)
        
        cache.put(5, for: "5")
        XCTAssert(cache.findValue("5") == 5)
        */
    }
}

private class LRUCache<Key: Hashable, Value> {
    
    typealias Pair = (key: Key, value: Value)
    
    private var queue = LinkedList<Pair>()
    private var map = [Key: LinkedListNode<Pair>]()
    private let capacity: Int
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func findValue(_ key: Key) -> Value? {
        
        guard let listNode = map[key] else { return nil }
        queue.moveNode(back: listNode)
        return listNode.item.value
    }
    
    func put(_ value: Value, for key: Key) {
        
        let pair = Pair(key, value)
        
        if let listNode = map[key] {
            listNode.item = pair
            queue.moveNode(back: listNode)
        } else {
            let listNode = queue.append(back: pair)
            map[key] = listNode
            
            cleanUpIfNeeded()
        }
    }
    
    private func cleanUpIfNeeded() {
        
        if queue.size > capacity {
            guard let listNode = queue.removeFirst() else { return }
            map[listNode.item.key] = nil
        }
    }
}

private class LinkedListNode<Item> {
    
    var next: LinkedListNode<Item>?
    var previous: LinkedListNode<Item>?
    var item: Item
    
    init(_ value: Item) {
        self.item = value
    }
}

private class LinkedList<Item> {
    
    private var head: LinkedListNode<Item>?
    private var tail: LinkedListNode<Item>?
    private(set) var size = 0
    
    func append(back item: Item) -> LinkedListNode<Item> {
        
        increaseSize()
        
        let node = LinkedListNode(item)
        
        guard head != nil else {
            tail = node
            head = node
            return node
        }
        
        tail?.next = node
        node.previous = tail
        tail = node
        
        return node
    }
    
    // nil, 1, 2
    
    func moveNode(back node: LinkedListNode<Item>) {
        
        guard node !== tail else { return }
        
        let next = node.next
        let previous = node.previous
        
        previous?.next = next
        next?.previous = previous
        
        tail = node
        
        if node === head {
            head = head?.next
        }
    }
    
    func removeFirst() -> LinkedListNode<Item>? {
        
        decreaseSize()
        
        let removedNode = head
        head = head?.next
        
        if head == nil {
            tail = nil
        }
        
        return removedNode
    }
    
    private func decreaseSize() {
        size = size == 0 ? 0 : size - 1
    }
    
    private func increaseSize() {
        size += 1
    }
}
