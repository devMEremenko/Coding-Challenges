# https://leetcode.com/problems/n-ary-tree-preorder-traversal/

# Definition for a Node.
class Node:
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children

from collections import deque

class Solution:
    
    def traverse_dfs_iteratively(self, node):
        result = []
        queue = [node]
        
        while queue:
            node = queue.pop()
            if node:
                result.append(node.val)
                queue.extend(reversed(node.children))
        return result

    def traverse_using_deque(self, node):
        if not node: return []
        
        nodes = deque()
        nodes.append(node.val)
        for item in node.children:
            nodes.extend(self.traverse_using_deque(item))
        return nodes
    
    def traverse_array(self, node):
        if not node: return []
        nodes = [node.val]
        for item in node.children:
            nodes += self.traverse_array(item)
        return nodes
        
    def preorder(self, root: 'Node') -> [int]:
        # return self.traverse_using_deque(root)
        # return self.traverse_array(root)
        return self.traverse_dfs_iteratively(root)