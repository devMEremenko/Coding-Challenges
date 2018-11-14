//
//  Stack+BasedOnArray.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 6/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

private class ArrayStackTests: XCTestCase {
    
    func testArrayStack() {
        
        var stack = ArrayStack<Int>()
        stack.push(2)
        stack.push(3)
        stack.push(4)
        XCTAssert(stack.top == 4)
        
        for expected in stride(from: 4, to: 2, by: -1) {
            XCTAssert(stack.pop() == expected)
        }
    }
    
    func testExtendedArray() {
        
        var arrStack = Array<Int>()
        arrStack.push(2)
        arrStack.push(3)
        arrStack.push(4)
        XCTAssert(arrStack.top == 4)
    }
}

private struct ArrayStack<T> {
    
    /// Array based implementation using a class
    private var items: Array<T>
    
    init(_ capacity: Int = 1) {
        items = Array()
        items.reserveCapacity(capacity)
    }
    
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    @discardableResult
    mutating func pop() -> T? {
        return items.popLast()
    }
    
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    var top: T? {
        return items.last
    }
}

private extension Array {
    
    /// Array based implementation using extensions
    
    mutating func push(_ item: Element) {
        self.append(item)
    }
    
    mutating func pop(_ item: Element) {
        self.removeLast()
    }
    
    var top: Element? {
        return self.last
    }
}
