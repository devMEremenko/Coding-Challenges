//
//  Stack+BasedOnArray.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

private class StackTests: XCTestCase {
    
    func testStack() {
        
        let stack = ArrayStack<Int>()
        stack.push(2)
        stack.push(3)
        stack.push(4)
        XCTAssert(stack.top == 4)
        
        var arrStack = Array<Int>()
        arrStack.push(2)
        arrStack.push(3)
        arrStack.push(4)
        XCTAssert(arrStack.top == 4)
    }
}

private class ArrayStack<T> {
    
    /// Array based implementation using a class
    
    init(_ capacity: Int = 17) {
        items = Array()
        items.reserveCapacity(capacity)
    }
    
    private lazy var items = Array<T>()
    
    func push(_ item: T) {
        items.append(item)
    }
    
    func pop(_ item: T) {
        items.removeLast()
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
