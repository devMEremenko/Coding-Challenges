//
//  ValidateBST_4_5.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 10/12/2018.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class ValidateBST: XCTestCase {
    
    /// Implement a function to check if a binary tree is a binary search tree.
    
    func test_validateBST_whenTreeIsValid_isTrue() {
        
        let tree = createValidBST()
        
        XCTAssertTrue(validateBST(tree))
    }
    
    func test_validateBST_whenTreeInvalid_isFalse() {
        
        let tree = createNotValidBST()
        
        XCTAssertFalse(validateBST(tree))
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

extension ValidateBST {
    
    /// Time: O(n)
    /// Space O(h)
    
    private func validateBST<Value: Comparable>(_ node: Node<Value>) -> Bool {
        return validateBSTHelper(node)
    }
    
    private func validateBSTHelper<Value: Comparable>(
        _ node: Node<Value>?,
        _ leftRange: Value? = nil,
        _ rightRange: Value? = nil
    ) -> Bool {
        
        guard let node = node else { return true }
        
        if let leftValue = node.left?.value {
            guard leftValue <= node.value else { return false }
        }
        
        if let rightValue = node.right?.value {
            guard rightValue > node.value else { return false }
        }
        
        if let leftRange = leftRange {
            guard node.value >= leftRange else { return false }
        }
        
        if let rightRange = rightRange {
            guard node.value <= rightRange else { return false }
        }
        
        return validateBSTHelper(node.left, leftRange, node.value)
            && validateBSTHelper(node.right, node.value, rightRange)
    }
}

extension ValidateBST {
    
    private func createValidBST() -> Node<Int> {
        
        ///        7
        ///      6   9
        ///    3    8  11
        //   2  4     10  12
        
        let node = Node(7)
        node.left = Node(6)
        node.left?.left = Node(3)
        node.left?.left?.left = Node(2)
        node.left?.left?.right = Node(4)
        
        node.right = Node(9)
        node.right?.left = Node(8)
        node.right?.right = Node(11)
        node.right?.right?.left = Node(10)
        node.right?.right?.right = Node(12)
        
        return node
    }
    
    private func createNotValidBST() -> Node<Int> {
        
        ///        7
        ///      6   9
        ///    3    8  11
        //   2  4     10  12
        //           8
        
        let node = Node(7)
        node.left = Node(6)
        node.left?.left = Node(3)
        node.left?.left?.left = Node(2)
        node.left?.left?.right = Node(4)
        
        node.right = Node(9)
        node.right?.left = Node(8)
        node.right?.right = Node(11)
        node.right?.right?.left = Node(10)
        node.right?.right?.left?.left = Node(8)
        node.right?.right?.right = Node(12)
        
        return node
    }
}
