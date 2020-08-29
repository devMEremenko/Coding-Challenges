# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
        
class Solution:
    
    def dfs(self, node, ans):
        if not node:
            return
        ans.append(str(node.val))
        if not node.left and node.right:
            ans.append("()")
        elif node.left:
            ans.append("(")
            self.dfs(node.left, ans)
            ans.append(")")
        if node.right:
            ans.append("(")
            self.dfs(node.right, ans)
            ans.append(")")
    
    # Time: O(n)
    # Space: O(n) + O(n)
    def tree2str(self, t: TreeNode) -> str:
        ans = []
        self.dfs(t, ans)
        return ''.join(ans)
    