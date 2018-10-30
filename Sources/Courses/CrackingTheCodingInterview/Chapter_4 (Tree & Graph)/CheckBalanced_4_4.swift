//
//  CheckBalanced_4_4.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 10/12/2018.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class CheckBalancedTests: XCTestCase {
    
    /// Check Balanced
    ///
    /// Implement a function to check if a binary tree is balanced.
    /// For the purposes of this question, a balanced tree is defined
    /// to be a tree such that the heights of the two subtrees of any node
    /// never differ by more than one.
    
    func test_checkBalanced_whenTreeIsBalanced_isTrue() {
        
        let tree = createBalancedTree()
        
        XCTAssertTrue(checkBalanced(tree))
    }
    
    func test_checkBalanced_whenTreeUnbalanced_isFalse() {
        
        let tree = createUnbalancedTree()
        
        XCTAssertFalse(checkBalanced(tree))
    }
    
    func test_checkBalanced_whenTreeIsLinkedList_isFalse() {
        
        let tree = createTreeAsLinkedList()
        
        XCTAssertFalse(checkBalanced(tree))
    }
    
    private class Node<Value> {
        var value: Value
        var left: Node<Value>?
        var right: Node<Value>?
        
        init(_ value: Value) {
            self.value = value
        }
    }
}

extension CheckBalancedTests {
    
    private enum Constants {
        static let notBalanced = -1
    }
    
    private func checkBalanced<Value>(_ node: Node<Value>) -> Bool {
        return checkHeight(node) != Constants.notBalanced
    }
    
    private func checkHeight<Value>(_ node: Node<Value>?) -> Int {
        guard let node = node else { return 0 }
        
        let left = checkHeight(node.left)
        let right = checkHeight(node.right)
        
        guard left != Constants.notBalanced, right != Constants.notBalanced else {
            return Constants.notBalanced
        }
        
        return abs(left - right) > 1 ? Constants.notBalanced : max(left, right) + 1
    }
}

extension CheckBalancedTests {
    
    /// Time: O(n)
    /// Space: O(h)
    
    private func createBalancedTree() -> Node<Int> {
        
        ///       5
        ///    3     7
        //   2  4  6
        // 1
        
        let node = Node(5)
        node.left = Node(3)
        node.left?.left = Node(2)
        node.left?.right = Node(4)
        node.left?.left?.left = Node(1)
        
        node.right = Node(7)
        node.right?.left = Node(6)
        
        return node
    }
    
    private func createUnbalancedTree() -> Node<Int> {
        
        ///       5
        ///    3     7
        //   2  4
        // 1
        
        let node = Node(5)
        node.left = Node(3)
        node.left?.left = Node(2)
        node.left?.right = Node(4)
        node.left?.left?.left = Node(1)
        
        node.right = Node(7)
        
        return node
    }
    
    private func createTreeAsLinkedList() -> Node<Int> {
        
        ///      5
        ///    3
        //   2
        
        let node = Node(5)
        node.left = Node(3)
        node.left?.left = Node(2)
        
        return node
    }
}
