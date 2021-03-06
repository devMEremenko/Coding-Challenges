# https://leetcode.com/problems/trim-a-binary-search-tree/

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def trimBST(self, root, low, high):
        # return self.solution1(root, low, high)
        return self.solution2(root, low, high)
    
    # Time O(n), Space O(height)
    def solution1(self, root, low, high):
        
        def solve(node):
            if not node: return node
            
            if node.val < low:
                return solve(node.right)
            if node.val > high:
                return solve(node.left)
            
            node.left = solve(node.left)
            node.right = solve(node.right)
            return node
        
        return solve(root)
    
    # Time O(hight), Space O(1)
    def solution2(self, root, low, high):
        while True:
            if not root:
                return root
            if root.val < low:
                root = root.right
            elif root.val > high:
                root = root.left
            else:
                break
        
        parent = root
        while parent.left:
            if parent.left.val >= low:
                parent = parent.left
            else:
                parent.left = parent.left.right
                
        parent = root
        while parent.right:
            if parent.right.val <= high:
                parent = parent.right
            else:
                parent.right = parent.right.left
        
        return root
