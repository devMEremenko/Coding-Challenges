//
//  BinaryTreeInorderTraversal_94.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 01/01/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class BinaryTreeInorderTraversal_94: XCTestCase {
    
    /// Given a binary tree, return the inorder traversal of its nodes' values.
    ///
    /// Follow up: Recursive solution is trivial, could you do it iteratively?
    
    func test_inorderTraversal_isCorrect() {
        
        let input = makeInput()
        
        let result = inorderTraversal(input.source)
        
        XCTAssertEqual(result, input.expected)
    }
}

extension BinaryTreeInorderTraversal_94 {
    
    /// Time: O(n)
    /// Space O(depth)
    
    private func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard root.notNil else { return [] }
        
        var node = root
        var results = [Int]()
        
        var stack = Stack<TreeNode>()
        
        while !stack.isEmpty || node.notNil {
            
            if node.notNil {
                stack.push(node!)
                node = node!.left
            } else {
                node = stack.pop()
                results.append(node!.val)
                node = node?.right
            }
        }
        
        return results
    }
}

extension BinaryTreeInorderTraversal_94 {
    
    private class TreeNode {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?
        
        init(_ val: Int) {
            self.val = val
        }
    }
}

extension BinaryTreeInorderTraversal_94 {

    private typealias Input = (source: TreeNode, expected: [Int])
    
    private func makeInput() -> Input {
        
        let node = TreeNode(5)
        node.left = TreeNode(3)
        node.left?.left = TreeNode(2)
        node.left?.right = TreeNode(4)
        
        node.right = TreeNode(7)
        node.right?.left = TreeNode(6)
        node.right?.right = TreeNode(8)
        
        return (node, Array(2...8))
    }
}
