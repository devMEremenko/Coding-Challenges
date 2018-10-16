//
//  LSK_BST.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 10/17/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class LSK_BSTTests: XCTestCase {
    
    /// Largest Smaller BST Key
    ///
    /// Given a root of a Binary Search Tree (BST) and a number `num`,
    /// implement an efficient function findLargestSmallerKey() that finds
    /// the largest key in the tree that is smaller than `num`. If such a number
    /// doesn’t exist, return -1. Assume that all keys in the tree are nonnegative.
    ///
    /// Analyze the time and space complexities of your solution.
}

extension LSK_BSTTests {
    
    ///            20
    ///         9     25
    ///       5   12
    ///          11 14
    
    func testRecursionSolution() {
        
        let tree = Node(array: [20, 9, 25, 5, 12, 11, 14])
        let key = findLargestSmallerKeyRecursively(tree, 17)
        XCTAssert(key == 14)
    }
    
    func testRecursionSolutionNegative() {
        
        let tree = Node(array: [20, 9, 25, 5, 12, 11, 14])
        let key = findLargestSmallerKeyRecursively(tree, 5)
        XCTAssert(key == -1)
    }
    
    func testIterativeSolution() {
        
        let tree = Node(array: [20, 9, 25, 5, 12, 11, 14])
        let key = findLargestSmallerKeyIteratively(tree, 17)
        XCTAssert(key == 14)
    }
    
    func testIterativeSolutionNegative() {
        
        let tree = Node(array: [20, 9, 25, 5, 12, 11, 14])
        let key = findLargestSmallerKeyIteratively(tree, 5)
        XCTAssert(key == -1)
    }
}

extension LSK_BSTTests {
    
    /// Time: O(n) - if BST is not balanced
    /// Space: O(1)
    
    private func findLargestSmallerKeyIteratively(_ rootNode: Node, _ num: Int) -> Int {
        
        var rn: Node? = rootNode
        var result = -1
        
        while rn != nil {
            if rn!.value < num {
                result = rn!.value
                rn = rn?.right
            } else {
                rn = rn?.left
            }
        }
        return result
    }
}

extension LSK_BSTTests {
    
    /// Time: O(n) - if BST is not balanced
    /// Space: O(n) - for the recursion stack
    
    private func findLargestSmallerKeyRecursively(_ rootNode: Node, _ num: Int) -> Int {
        
        let rn = rootNode
        
        if num > rn.value {
            if let rightNode = rn.right {
                let value = findLargestSmallerKeyRecursively(rightNode, num)
                return value == -1 ? rn.value : value
            }
            return rn.value
        } else {
            if let leftNode = rn.left {
                return findLargestSmallerKeyRecursively(leftNode, num)
            }
            return -1
        }
    }
}

private class Node {
    
    private(set) public var value: Int
    private(set) public var parent: Node?
    private(set) public var left: Node?
    private(set) public var right: Node?
    
    init(_ value: Int) {
        self.value = value
    }
    
    func insert(_ value: Int) {
        if value < self.value {
            if let left = left {
                left.insert(value)
            } else {
                left = Node(value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value)
            } else {
                right = Node(value)
                right?.parent = self
            }
        }
    }
    
    convenience init(array: [Int]) {
        precondition(array.count > 0)
        self.init(array.first!)
        for v in array.dropFirst() {
            insert(v)
        }
    }
}
