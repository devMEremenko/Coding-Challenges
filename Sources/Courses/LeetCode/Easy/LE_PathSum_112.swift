//
//  LE_PathSum_112.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 04/07/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class LE_PathSum_112: XCTestCase {
    
    /// Given a binary tree and a sum, determine if the tree has a root-to-leaf path
    /// such that adding up all the values along the path equals the given sum.
    /// https://leetcode.com/problems/path-sum/
    
    func test1() {
        let root = TreeNode(5)
        root.left = TreeNode(4)
        root.left?.left = TreeNode(11)
        root.left?.left?.left = TreeNode(7)
        root.left?.left?.right = TreeNode(2)
        root.right = TreeNode(8)
        root.right?.left = TreeNode(13)
        root.right?.right = TreeNode(4)
        root.right?.right?.right = TreeNode(1)
        
        XCTAssertTrue(hasPathSum(root, 22))
        XCTAssertTrue(hasPathSum(root, 26))
        XCTAssertTrue(hasPathSum(root, 18))
        
        XCTAssertFalse(hasPathSum(root, 19))
        XCTAssertFalse(hasPathSum(root, 1))
        XCTAssertFalse(hasPathSum(root, 0))
    }
}

extension LE_PathSum_112 {
    
    // Time: O(n) Traversing all values in the worst case
    // Space: O(n) Tree may look like a linked list
    
    func hasPathSum(_ root: TreeNode?, _ target: Int) -> Bool {
        guard let root = root else { return false }
        return traverse(root, 0, target)
    }
    
    private func traverse(_ node: TreeNode, _ current: Int, _ target: Int) -> Bool {
        if isLeaf(node) {
            return current + node.val == target
        }
        
        if let left = node.left, traverse(left, current + node.val, target) {
            return true
        }
        
        if let right = node.right, traverse(right, current + node.val, target) {
            return true
        }
        return false
    }
    
    private func isLeaf(_ node: TreeNode) -> Bool {
        return node.left == nil && node.right == nil
    }
}

extension LE_PathSum_112 {
    
    class TreeNode {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?
        init(_ val: Int) {
            self.val = val
        }
    }
}
