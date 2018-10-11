//
//  QueueViaStacks_3_4.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/30/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class QueueViaStacksTests: XCTestCase {
    
    /// Implement a MyQueue class which implements a queue using two stacks.
    
    func test() {
        
        var queue = MyQueue<Int>()
        queue.enqueue(1)
        queue.enqueue(2)
        queue.enqueue(3)
        
        XCTAssert(queue.dequeue() == 1)
        XCTAssert(queue.dequeue() == 2)
        
        queue.enqueue(4)
        XCTAssert(queue.dequeue() == 3)
        
        queue.enqueue(5)
        XCTAssert(queue.dequeue() == 4)
        XCTAssert(queue.dequeue() == 5)
        XCTAssert(queue.dequeue() == nil)
    }
}

struct MyQueue<Item> {
    
    private var newestStack = Stack<Item>()
    private var oldestStack = Stack<Item>()
    
    mutating func enqueue(_ item: Item) {
        oldestStack.push(item)
    }
    
    mutating func dequeue() -> Item? {
        shiftValues()
        return newestStack.pop()
    }
    
    private mutating func shiftValues() {
        guard newestStack.isEmpty else { return }
        
        while !oldestStack.isEmpty {
            let item = oldestStack.pop()!
            newestStack.push(item)
        }
    }
}
