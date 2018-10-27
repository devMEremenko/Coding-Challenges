//
//  MinimalTree_4_2.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 14/11/2018.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class MinimalTreeTests: XCTestCase {
    
    /// Minimal Tree
    /// Given a sorted (increasing order) array with unique integer elements,
    /// write an algorithm to create a binary search tree with a minimal height.
    
    func test_1() {
        
        let source = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        let node = createBST(source)
        
        verify(source, node)
    }
    
    func test_2() {
        
        let source = [0, 2, 5, 8, 9, 10, 12, 44, 90, 91, 92]
        
        let node = createBST(source)
        
        verify(source, node)
    }
    
    private func verify(_ source: [Int], _ node: BSTNode<Int>?) {
        
        var result = [Int]()
        node?.traverseInOrder({ result.append($0) })
        
        XCTAssert(result == result)
    }
}

extension MinimalTreeTests {
    
    /// Time: O(n)
    /// Space: O(log n)
    
    private func createBST(_ source: [Int]) -> BSTNode<Int>? {
        guard !source.isEmpty else { return nil }
        return createBST(source, 0, source.count - 1)
    }
    
    private func createBST(_ source: [Int], _ left: Int, _ right: Int) -> BSTNode<Int>? {
        
        guard left <= right else { return nil }
        
        let midIdx = left + (right - left) / 2
        
        let node = BSTNode(source[midIdx])
        node.left = createBST(source, left, midIdx - 1)
        node.right = createBST(source, midIdx + 1, right)
        return node
    }
}

private class BSTNode<Value> {
    
    var value: Value
    var left: BSTNode<Value>?
    var right: BSTNode<Value>?
    
    init(_ value: Value) {
        self.value = value
    }
    
    func traverseInOrder(_ block: (Value) -> Void) {
        left?.traverseInOrder(block)
        block(value)
        right?.traverseInOrder(block)
    }
}
