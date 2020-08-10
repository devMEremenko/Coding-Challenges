# https://leetcode.com/problems/sum-of-left-leaves/

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    
    def solution1(self, node):
        if not node:
            return 0
        
        def is_leaf(node):
            return node and node.right is None and node.left is None
        
        if is_leaf(node.left):
            return node.left.val + self.solution1(node.right)
        else:
            return self.solution1(node.left) + self.solution1(node.right)

    def solution2(self, node, is_left):
        if not node:
            return 0
        if node.left is None and node.right is None:
            if is_left:
                return node.val
            else:
                return 0
        r1 = self.solution2(node.left, True) 
        r2 = self.solution2(node.right, False)
        return r1 + r2     
    
    def sumOfLeftLeaves(self, root: TreeNode) -> int:
        # return self.solution1(root)
        return self.solution2(root, False)

    