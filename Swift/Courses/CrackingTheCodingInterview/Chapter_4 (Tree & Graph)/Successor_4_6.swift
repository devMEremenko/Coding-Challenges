//
//  Successor_4_6.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 20/12/2018.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class Successor_4_6: XCTestCase {
    
    /// Write an algorithm to find the "next" node (i.e., in-order successor)
    /// of a given node in a binary search tree.
    ///
    /// You may assume that each node has a link to its parent.
    
    func test_findSuccessor_1() {
        
        let bst = createBST()
        
        let result = findSuccessor(of: bst.left?.left)
        
        XCTAssertEqual(result, 4)
    }
    
    func test_findSuccessor_2() {
        
        let bst = createBST()
        
        let result = findSuccessor(of: bst.left)
        
        XCTAssertEqual(result, 6.5)
    }
    
    func test_findSuccessor_3() {
        
        let bst = createBST()
        
        let result = findSuccessor(of: bst.right)
        
        XCTAssertEqual(result, 10)
    }
    
    func test_findSuccessor_4() {
        
        let bst = createBST()
        
        let result = findSuccessor(of: bst.right?.right?.right)
        
        XCTAssertEqual(result, nil)
    }
    
    func test_findSuccessor_5() {
        
        let bst = createBST()
        
        let result = findSuccessor(of: bst.right?.right?.left)
        
        XCTAssertEqual(result, 11)
    }
    
    func test_findSuccessor_6() {
        
        let bst = createBST()
        
        let result = findSuccessor(of: bst.right?.left?.left)
        
        XCTAssertEqual(result, 9)
    }
    
    func test_findSuccessor_7() {
        
        let bst = createBST()
        
        let result = findSuccessor(of: bst.left?.right)
        
        XCTAssertEqual(result, 7)
    }
}

extension Successor_4_6 {
    
    private class Node<Value> {
        var value: Value
        var left: Node<Value>?
        var right: Node<Value>?
        weak var parent: Node<Value>?
        
        init(_ value: Value, _ parent: Node<Value>? = nil) {
            self.value = value
            self.parent = parent
        }
    }
}

extension Successor_4_6 {
    
    /// Time: O(height)
    /// Space: O(1)
    
    private func findSuccessor<Value: Comparable>(of node: Node<Value>?) -> Value? {
        guard let node = node else { return nil }
        
        guard let result = searchRight(node.right) else {
            return searchParent(node)
        }
        return result
    }
    
    private func searchRight<Value: Comparable>(_ right: Node<Value>?) -> Value? {
        guard var right = right else { return nil }
        while let left = right.left {
            right = left
        }
        return right.value
    }
    
    private func searchParent<Value: Comparable>(_ node: Node<Value>?) -> Value? {
        guard var node = node else { return nil }
        let sourceValue = node.value
        
        while let parent = node.parent {
            if parent.value > sourceValue {
                return parent.value
            }
            node = parent
        }
        return nil
    }
}

extension Successor_4_6 {
    
    private func createBST() -> Node<Double> {
        
        ///           7
        ///      6         9
        ///    3  6.5    8    11
        //   2  4      8     10 12
        
        let bst = Node(7.0)
        bst.left = Node(6, bst)
        bst.left?.left = Node(3, bst.left)
        bst.left?.right = Node(6.5, bst.left)
        bst.left?.left?.left = Node(2, bst.left?.left)
        bst.left?.left?.right = Node(4, bst.left?.left)
        
        bst.right = Node(9, bst)
        bst.right?.left = Node(8, bst.right)
        bst.right?.left?.left = Node(8, bst.right?.left)
        bst.right?.right = Node(11, bst.right)
        bst.right?.right?.left = Node(10, bst.right?.right)
        bst.right?.right?.right = Node(12, bst.right?.right)
        
        return bst
    }
}
