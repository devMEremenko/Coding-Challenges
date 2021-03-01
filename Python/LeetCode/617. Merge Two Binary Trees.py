# https://leetcode.com/problems/merge-two-binary-trees/

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

from collections import deque

class Solution:
    
    def mergeTrees(self, t1, t2):
        # return self.solution1_recursive_inplace(t1, t2)
        # return self.solution2_iterative_inplace(t1, t2)
        return self.solution3_iterative_using_new_tree(t1, t2)
        
    # Time O(min(n, m))
    def solution1_recursive_inplace(self, t1, t2):
        if not t1 or not t2: return t1 or t2
        
        node = TreeNode(t1.val + t2.val)
        node.left = self.solution1_recursive_inplace(t1.left, t2.left)
        node.right = self.solution1_recursive_inplace(t1.right, t2.right)
        return node
    
    def solution2_iterative_inplace(self, t1, t2):
        if not t1 or not t2: return t1 or t2

        q = deque()
        q.append((t1, t2))
        while q:
            v1, v2 = q.popleft()
            v1.val = v1.val + v2.val
            
            if v1.left and v2.left: 
                q.append((v1.left, v2.left))
            elif v2.left: 
                v1.left = v2.left
                
            if v1.right and v2.right: 
                q.append((v1.right, v2.right))
            elif v2.right: 
                v1.right = v2.right
        return t1
    
    def solution3_iterative_using_new_tree(self, t1, t2):
        
        def make_tree(node):
            if not node: return None
            tree = TreeNode(node.val)
            tree.left = make_tree(node.left)
            tree.right = make_tree(node.right)
            return tree
        
        if not t1 or not t2: return make_tree(t1 or t2)
        
        res = TreeNode()
        q = deque()
        q.append((t1, t2, res))
        
        while q:
            t1, t2, t3 = q.popleft()
            t3.val = t1.val + t2.val
            
            if t1.left and t2.left:
                t3.left = TreeNode()
                q.append((t1.left, t2.left, t3.left))
            elif t1.left:
                t3.left = make_tree(t1.left)
            elif t2.left: 
                t3.left = make_tree(t2.left)
                
            if t1.right and t2.right:
                t3.right = TreeNode()
                q.append((t1.right, t2.right, t3.right))
            elif t1.right:
                t3.right = make_tree(t1.right)
            elif t2.right: 
                t3.right = make_tree(t2.right)
        
        return res
