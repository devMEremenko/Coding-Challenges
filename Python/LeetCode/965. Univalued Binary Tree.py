# https://leetcode.com/problems/univalued-binary-tree/

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
        
class Solution:
    def isUnivalTree(self, root: TreeNode) -> bool:
        return self.check_value(root, root.val)
        
    def check_value(self, root, val):
        if not root:
            return True
        
        if root.val != val:
            return False
        
        return self.check_value(root.left, val) and self.check_value(root.right, val)