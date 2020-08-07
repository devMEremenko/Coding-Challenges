# https://leetcode.com/problems/binary-tree-tilt/

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
        
    def findTiltHelper(self, root: TreeNode) -> (int, int):
        if root is None or root.val is None:
            return (0, 0)
        
        if root.left is None and root.right is None:
            return (root.val, 0)
        
        left_value, left_tilt = self.findTiltHelper(root.left)
        right_value, right_tilt = self.findTiltHelper(root.right)
        
        tilt = left_tilt + right_tilt + abs(left_value - right_value)
        
        return (left_value + right_value + root.val, tilt)
    
    def findTilt(self, root: TreeNode) -> int:
        return self.findTiltHelper(root)[1]

