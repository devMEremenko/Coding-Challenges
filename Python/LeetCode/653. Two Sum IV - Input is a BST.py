# https://leetcode.com/problems/two-sum-iv-input-is-a-bst/

class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    
    def to_array(self, node, arr):
        if not node:
            return
        self.to_array(node.left, arr)
        arr.append(node)
        self.to_array(node.right, arr)
    
    def findTarget(self, root: TreeNode, k: int) -> bool:
        
        arr = []
        self.to_array(root, arr)
        l = 0
        r = len(arr) - 1
        while l < r:
            if arr[l].val + arr[r].val < k:
                l += 1
            elif arr[l].val + arr[r].val > k:
                r -= 1
            else:
                return True
            
        return False
            