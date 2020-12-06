# https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def sortedArrayToBST(self, nums: [int]) -> TreeNode:
        return self.iterate(nums, 0, len(nums) - 1)
        
    # Time O(n), Space O(n) for a tree. 
    def iterate(self, nums, l, r):
        if l > r:
            return None
        
        m = l + (r - l) // 2
        
        left = self.iterate(nums, l, m - 1)
        right = self.iterate(nums, m + 1, r)
        
        return TreeNode(nums[m], left, right)
        