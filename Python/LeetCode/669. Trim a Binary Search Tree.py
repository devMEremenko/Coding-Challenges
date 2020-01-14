# https://leetcode.com/problems/trim-a-binary-search-tree/

class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    
    #           5
    #       2        8
    #     1   3    6    9
    
    def trimBST(self, root: TreeNode, L: int, R: int) -> TreeNode:
        
        def trim(node):
            if not node:
                return None
            if node.val > R:
                return trim(node.left)
            elif node.val < L:
                return trim(node.right)
            else:
                node.left = trim(node.left)
                node.right = trim(node.right)
                return node
            
        return trim(root)
            