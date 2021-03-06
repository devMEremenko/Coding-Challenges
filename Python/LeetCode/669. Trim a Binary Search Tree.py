# https://leetcode.com/problems/trim-a-binary-search-tree/

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:

    def trimBST(self, root, low, high):
        return self.solution1(root, low, high)
    
    def solution1(self, root, low, high):
        
        def solve(node):
            if not node: return None
            
            if node.val < low:
                return solve(node.right)
            if node.val > high:
                return solve(node.left)
            
            node.left = solve(node.left)
            node.right = solve(node.right)
            return node
        
        return solve(root)
    