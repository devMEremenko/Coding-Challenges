//
//  StackMin.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class StackMinTests: XCTestCase {
    
    func testSetup() {
        
        var stack = StackMin<Int>()
        XCTAssert(stack.isEmpty)
        XCTAssert(stack.top == nil)
        XCTAssert(stack.minItem == nil)
    }
    
    func testPushPop() {
        
        var stack = StackMin<Int>()
        
        stack.push(3)
        XCTAssert(stack.minItem == 3)
        
        stack.push(1)
        XCTAssert(stack.minItem == 1)
        
        stack.push(2)
        XCTAssert(stack.minItem == 1)
        
        stack.push(3)
        XCTAssert(stack.minItem == 1)
        
        stack.pop()
        XCTAssert(stack.minItem == 1)
        
        stack.pop()
        XCTAssert(stack.minItem == 1)
        
        stack.pop()
        XCTAssert(stack.minItem == 3)
    }
}

struct StackMin<Item: Comparable> {
    
    private lazy var storage = List<Item>()
    private lazy var minStorage = Stack<Item>()
    
    mutating func push(_ item: Item) {
        storage.addTo(start: item)
        pushMin(item)
    }
    
    @discardableResult
    mutating func pop() -> Item? {
        let item = storage.removeFirst()
        popMin(item)
        return item
    }
    
    private mutating func pushMin(_ item: Item) {
        if let top = minStorage.top {
            if item < top {
                minStorage.push(item)
            }
        } else {
            minStorage.push(item)
        }
    }
    
    private mutating func popMin(_ item: Item?) {
        if let top = minStorage.top {
            if item == top {
                minStorage.pop()
            }
        }
    }
    
    var minItem: Item? {
        mutating get { return minStorage.top }
    }
    
    var isEmpty: Bool {
        mutating get { return storage.isEmpty }
    }
    
    var top: Item? {
        mutating get { return storage.first }
    }
}
