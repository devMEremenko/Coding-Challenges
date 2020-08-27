# https://leetcode.com/problems/reverse-linked-list/

# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        if not head:
            return head
        
        p = None # previous
        c = head # current
        # n - next
        
        while c:
            n = c.next
            c.next = p
            p = c
            c = n
        return p
