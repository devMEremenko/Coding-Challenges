//
//  StackOfPlates_3_3.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class StackOfPlatesTests: XCTestCase {
    
    func testPushTopWithSingleCapacity() {
        
        var set = SetOfStacks<Int>(capacity: 1)
        
        set.push(1)
        XCTAssert(set.top == 1)
        
        set.push(2)
        XCTAssert(set.top == 2)
        
        set.push(3)
        XCTAssert(set.top == 3)
        
        XCTAssert(set.pop() == 3)
        XCTAssert(set.pop() == 2)
        XCTAssert(set.pop() == 1)
        XCTAssert(set.pop() == nil)
    }
    
    func testPushTopWithMultipleCapacity() {
        
        var set = SetOfStacks<Int>(capacity: 2)
        
        set.push(1)
        XCTAssert(set.top == 1)
        
        set.push(2)
        XCTAssert(set.top == 2)
        
        set.push(3)
        XCTAssert(set.top == 3)
        
        set.push(4)
        XCTAssert(set.top == 4)
        
        set.push(5)
        XCTAssert(set.top == 5)
        
        XCTAssert(set.pop() == 5)
        XCTAssert(set.pop() == 4)
        XCTAssert(set.pop() == 3)
        XCTAssert(set.pop() == 2)
        XCTAssert(set.pop() == 1)
        XCTAssert(set.pop() == nil)
    }
    
    func testPopAtIdxWithSingleCapacity() {
        
        var set = SetOfStacks<Int>(capacity: 1)
        set.push(1)
        set.push(2)
        set.push(3)
        
        XCTAssert(set.pop(idx: 2) == 3)
        XCTAssert(set.pop(idx: 0) == 1)
        XCTAssert(set.pop(idx: 0) == 2)
        XCTAssert(set.pop(idx: 0) == nil)
    }
    
    func testPopAtIdxWithMultipleCapacity() {
        
        var set = SetOfStacks<Int>(capacity: 2)
        set.push(1)
        set.push(2)
        set.push(3)
        set.push(4)
        set.push(5)
        
        XCTAssert(set.pop(idx: 1) == 4)
        XCTAssert(set.pop(idx: 1) == 3)
        XCTAssert(set.pop(idx: 0) == 2)
        XCTAssert(set.pop(idx: 0) == 1)
        XCTAssert(set.pop(idx: 0) == 5)
        XCTAssert(set.pop(idx: 0) == nil)
        XCTAssert(set.pop(idx: 1) == nil)
        XCTAssert(set.pop(idx: 2) == nil)
    }
    
    func testPopShiftingWithSingleCapacity() {
        
        var set = SetOfStacks<Int>(capacity: 1)
        set.push(1)
        set.push(2)
        set.push(3)
        set.push(4)
        set.push(5)
        
        XCTAssert(set.popShifting(idx: 3) == 4)
        XCTAssert(set.popShifting(idx: 0) == 1)
        XCTAssert(set.popShifting(idx: 2) == 5)
        XCTAssert(set.popShifting(idx: 0) == 2)
        XCTAssert(set.popShifting(idx: 0) == 3)
        XCTAssert(set.popShifting(idx: 0) == nil)
    }
    
    func testPopShiftingWithMultipleCapacity() {
        
        var set = SetOfStacks<Int>(capacity: 2)
        set.push(1)
        set.push(2)
        set.push(3)
        set.push(4)
        set.push(5)
        set.push(6)

        XCTAssert(set.popShifting(idx: 1) == 4)
        XCTAssert(set.popShifting(idx: 0) == 2)
        XCTAssert(set.popShifting(idx: 0) == 3)
        XCTAssert(set.popShifting(idx: 1) == 6)
        XCTAssert(set.popShifting(idx: 0) == 5)
        XCTAssert(set.popShifting(idx: 0) == 1)
        XCTAssert(set.popShifting(idx: 0) == nil)
    }
}

struct SetOfStacks<Item> {
    
    private var storage = [Stack<Item>]()
    private let capacity: Int
    
    init(capacity: Int = 15) {
        self.capacity = capacity
    }
    
    mutating func push(_ item: Item) {
        var stack = findInsertionStack()
        stack.push(item)
        updateLast(stack)
    }
    
    @discardableResult
    mutating func pop() -> Item? {
        guard var stack = storage.last, !stack.isEmpty else { return nil }
        defer {
            updateLast(stack)
        }
        return stack.pop()
    }
    
    @discardableResult
    mutating func pop(idx: Int) -> Item? {
        guard var stack = findStack(at: idx) else { return nil }
        defer {
            update(stack, at: idx)
        }
        return stack.pop()
    }
    
    @discardableResult
    mutating func popShifting(idx: Int) -> Item? {
        guard var stack = findStack(at: idx) else { return nil }
        defer {
            update(stack, at: idx)
            if !stack.isEmpty {
                shiftValues(at: idx)
            }
        }
        return stack.pop()
    }
    
    var top: Item? {
        return storage.last?.top
    }
}

extension SetOfStacks {
    
    private mutating func findStack(at idx: Int) -> Stack<Item>? {
        guard idx >= 0 && idx < storage.count else { return nil }
        return storage[idx]
    }
    
    private mutating func findInsertionStack() -> Stack<Item> {
        if let stack = storage.last, stack.size < capacity {
            return stack
        }
        
        let stack = Stack<Item>()
        storage.append(stack)
        return stack
    }
    
    private mutating func updateLast(_ stack: Stack<Item>) {
        update(stack, at: storage.count - 1)
    }
    
    private mutating func update(_ stack: Stack<Item>, at idx: Int) {
        guard idx >= 0 && idx < storage.count else { return }
        
        if stack.isEmpty {
            storage.remove(at: idx)
        } else {
            storage[idx] = stack
        }
    }
    
    private mutating func shiftValues(at stackIdx: Int) {
        
        for idx in stackIdx..<storage.count {
            
            guard var stack = findStack(at: idx) else { continue }
            guard var nextStack = findStack(at: idx + 1) else { continue }
            guard let nextValue = nextStack.popBack() else { continue }
            
            stack.push(nextValue)
            update(stack, at: idx)
            update(nextStack, at: idx + 1)
        }
    }
}
