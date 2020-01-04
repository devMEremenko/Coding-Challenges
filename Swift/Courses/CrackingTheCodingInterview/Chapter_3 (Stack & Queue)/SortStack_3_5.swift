//
//  SortStack_3_5.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 9/30/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class SortStackTests: XCTestCase {
    
    /// Sort Stack
    ///
    /// Write a program to sort a stack such that the smallest items are on the top.
    /// You can use an additional temporary stack, but you may not copy the elements
    /// into any other data structure (such as an array).
    ///
    /// The stack supports the following operations: push, pop, peek, and isEmpty.
    
    func testSort1() {
        
        var data = createStacks()
        
        XCTAssert(sortSearchingMax(&data.source) == data.expected)
    }
    
    func testSort2() {
        
        var data = createStacks()
        
        XCTAssert(sortShifting(&data.source) == data.expected)
    }
}

extension SortStackTests {
    
    /// Time: O(n*n)
    /// Space: O(n)
    
    func sortShifting<Item: Comparable>(_ stack: inout Stack<Item>) -> Stack<Item> {
        
        var tempStack = Stack<Item>()
        
        while !stack.isEmpty {
            let item = stack.pop()!
            
            while let top = tempStack.top, top < item {
                stack.push(tempStack.pop()!)
            }
            
            tempStack.push(item)
        }
        
        return tempStack
    }
}

extension SortStackTests {
    
    /// Time: O(n*n)
    /// Space: O(n)
    
    func sortSearchingMax<Item: Comparable>(_ stack: inout Stack<Item>) -> Stack<Item> {
        
        guard stack.size > 1 else { return stack }

        var resultStack = Stack<Item>()
        let size = stack.size
        
        while resultStack.size != size {
            resultStack.push(findMax(&stack))
        }
        
        return resultStack
    }
    
    private func findMax<Item: Comparable>(_ stack: inout Stack<Item>) -> Item {
        
        var maxItem: Item!
        var tempStack = Stack<Item>()
        
        while !stack.isEmpty {
            
            let item = stack.pop()!
            
            if let maxItemUnwrapped = maxItem {
                if item > maxItemUnwrapped {
                    tempStack.push(maxItemUnwrapped)
                    maxItem = item
                } else {
                    tempStack.push(item)
                }
            } else {
                maxItem = item
            }
        }
        
        stack = tempStack
        return maxItem
    }
}

extension SortStackTests {
    
    private typealias TestData = (source: Stack<Int>, expected: Stack<Int>)
    
    private func createStacks() -> TestData {
        
        let source = Stack([5, 3, 1, 4])
        let expected = Stack([5, 4, 3, 1])
        
        return (source, expected)
    }
}
