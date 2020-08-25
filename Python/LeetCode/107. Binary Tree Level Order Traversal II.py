# https://leetcode.com/problems/binary-tree-level-order-traversal-ii/

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    
    def dfs(self, node, ans, lvl):
        if not node:
            return ans
        
        if lvl >= len(ans):
            ans.append([])
            
        ans[lvl].append(node.val)
        self.dfs(node.left, ans, lvl+1)
        self.dfs(node.right, ans, lvl+1)
            

    def levelOrderBottom(self, node: TreeNode) ->[[int]]:
        ans = []
        self.dfs(node, ans, 0)
        return reversed(ans)
        