# https://leetcode.com/problems/range-sum-of-bst/solution/

from collections import deque

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def rangeSumBST(self, root, low, high):
        # return self.solution1(root, low, high)
        return self.solution2(root, low, high)
    
    def solution1(self, root, low, high):
        
        def solve(node):
            if not node: return 0
            
            if low <= node.val <= high:
                return node.val + solve(node.left) + solve(node.right)
            elif node.val < low:
                return solve(node.right)
            elif node.val > high:
                return solve(node.left)
        
        return solve(root)
        
    def solution2(self, root, low, high):
        if not root: return 0
        
        q = deque()
        q.append(root)
        res = 0
        
        while q:
            node = q.popleft()
            
            if low <= node.val <= high:
                res += node.val
                if node.left: q.append(node.left)
                if node.right: q.append(node.right)
            elif node.val < low and node.right:
                q.append(node.right)
            elif node.val > high and node.left:
                q.append(node.left)
                
        return res
