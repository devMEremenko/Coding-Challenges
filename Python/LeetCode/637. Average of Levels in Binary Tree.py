# https://leetcode.com/problems/average-of-levels-in-binary-tree/

from collections import deque

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def averageOfLevels(self, root: TreeNode) -> [float]:
        if not root: 
            return []
        
        empty_node = TreeNode(val=None)
        
        q = deque([root, empty_node])
        lvl_total = 0
        lvl_items_count = 0
        res = []
        
        while q:
            node = q.popleft()
            
            if node.val is None:                    
                res.append(lvl_total / lvl_items_count)
                lvl_total = 0
                lvl_items_count = 0
                
                if not q:
                    break
                else:
                    q.append(empty_node)
            else:
                lvl_total += node.val
                lvl_items_count += 1

                if node.left:
                    q.append(node.left)
                if node.right:
                    q.append(node.right)
                
        return res
