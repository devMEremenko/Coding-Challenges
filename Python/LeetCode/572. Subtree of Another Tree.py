# https://leetcode.com/problems/subtree-of-another-tree/

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    def isTheSame(self, s: TreeNode, t: TreeNode) -> bool:
        if not s and not t:
            return True
        if not s or not t:
            return False
        
        return s.val == t.val and self.isTheSame(s.left, t.left) and self.isTheSame(s.right, t.right)
    
    def isSubtree(self, s: TreeNode, t: TreeNode) -> bool:
        if not s or not t:
            return False
        
        return self.isTheSame(s, t) or self.isSubtree(s.left, t) or self.isSubtree(s.right, t)
        