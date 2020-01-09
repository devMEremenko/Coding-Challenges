# https://leetcode.com/problems/invert-binary-tree/

from collections import deque

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    
    # Solution 1: 
    # 1. Move values to the array
    # 2. Create a BST from the array
    # Note: Tree may look diffrent than the original one
    
    #      1               1
    #    /   \           /   \
    #   2     3    ->   3     2
    #  / \   / \       / \   / \
    # 4   5 6   7     7   6 5   4
    
    # BFS TopDown Solution
    # Time O(n), Space O(n)
    def solveBFS(self, root: TreeNode) -> TreeNode:
        q = deque()
        q.append(root)
        while q:
            node = q.popleft()
            if node: 
                node.left, node.right = node.right, node.left
                q.append(node.left)
                q.append(node.right)
                
        return root
    
    # DFS TopDown Solution
    # Time O(n), Space O(n)
    def solveDFS(self, root: TreeNode) -> TreeNode:
        q = deque()
        q.append(root)
        while q:
            node = q.pop()
            if node: 
                node.left, node.right = node.right, node.left
                q.append(node.right)
                q.append(node.left)
                
        return root
    
    # BottomUp Solution.
    # Time O(n), Space O(n)
    def solveRecursively(self, root: TreeNode) -> TreeNode:
        left = self.invertTree(root.left)
        right = self.invertTree(root.right)
        
        (root.left, root.right) = (right, left)
        
        return root
        
    def invertTree(self, root: TreeNode) -> TreeNode:
        if not root: 
            return
        
        # return self.solveDFS(root)
        # return self.solveBFS(root)
        return self.solveRecursively(root)
