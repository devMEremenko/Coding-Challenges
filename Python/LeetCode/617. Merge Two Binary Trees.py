# https://leetcode.com/problems/merge-two-binary-trees/

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

from collections import deque

class Solution:
    
    def solve_recursively_new_tree(self, t1: TreeNode, t2: TreeNode) -> TreeNode:
        if t1 and t2:
            root = TreeNode(t1.val + t2.val)
            root.left = self.solve_recursively_new_tree(t1.left, t2.left)
            root.right = self.solve_recursively_new_tree(t1.right, t2.right)
            return root
        else:
            return t1 or t2
    
    def solve_iteratively(self, t1: TreeNode, t2: TreeNode) -> TreeNode:
        if not t1 or not t2: return t1 or t2

        q = deque()
        q.append((t1, t2))
        while q:
            v1, v2 = q.popleft()
            v1.val = v1.val + v2.val
            
            if v1.left and v2.left: q.append([v1.left, v2.left])
            elif v2.left: v1.left = v2.left #t1.left is None
                
            if v1.right and v2.right: q.append([v1.right, v2.right])
            elif v2.right: v1.right = v2.right #t1.right is None
        return t1
    
    def mergeTrees(self, t1: TreeNode, t2: TreeNode) -> TreeNode:
        # return self.solve_recursively_new_tree(t1, t2)
        return self.solve_iteratively(t1, t2)
        