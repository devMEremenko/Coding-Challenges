# https://leetcode.com/problems/range-sum-of-bst/solution/

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def rangeSumBST(self, root: TreeNode, low: int, high: int) -> int:
        
        def solution(root):
            if not root:
                return 0
            
            if low <= root.val <= high:
                return root.val + solution(root.left) + solution(root.right)
            elif root.val < low:
                return solution(root.right)
            elif root.val > high:
                return solution(root.left)
        
        return solution(root)
    