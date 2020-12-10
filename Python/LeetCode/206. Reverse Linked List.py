# https://leetcode.com/problems/reverse-linked-list/

# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    
    def reverseList(self, node: ListNode) -> ListNode:
        if not node:
            return None
        # return self.reverse_recursively(node)[1]
        return self.reverse_iteratively(node)
    
    # Time O(n), Space O(1)
    def reverse_iteratively(self, node):        
        prev = None
        curr = node
        while curr:
            n = curr.next
            curr.next = prev
            prev = curr
            curr = n
        return prev
    
    # Time O(n), Space O(n)
    def reverse_recursively(self, node):
        if not node.next:
            return (node, node)
        
        previous, tail = self.reverse_recursively(node.next)
        node.next = None
        previous.next = node
        return (node, tail)
