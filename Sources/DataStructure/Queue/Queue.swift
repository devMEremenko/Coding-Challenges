//
//  Queue.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/16/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class QueueTest: XCTestCase {
    
    func test() {
        
        var values = [1, 3, 5, 1, 8, 5, 3]
        
        let queue = Queue<Int>()
        
        for item in values {
            queue.enqueue(item)
        }
        
        XCTAssert(queue.count == values.count)
        
        for idx in 0..<queue.count {
            XCTAssert(queue.dequeue() == values[idx])
        }
        
        XCTAssert(queue.isEmpty)
    }
}

class Queue<T> {
    
    private lazy var items = [T]()
    
    func enqueue(_ item: T) {
        items.append(item)
    }
    
    func dequeue() -> T? {
        return items.removeFirst()
    }
    
    var front: T? {
        return items.first
    }
    
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    var count: Int {
        return items.count
    }
}
