# https://leetcode.com/problems/merge-two-sorted-lists/

# Definition for singly-linked list.
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None

class Solution:

    # Input: 
        #       1->2->4
        #       1->3->4
        # Output: 
        #       1->1->2->3->4->4
        
        # Input: 
        #       1->2->4
        #       1->3
        # Output: 
        #       1->1->2->3->4
        
        # fake -> 1 -> 1 -> 2 ..

    def mergeTwoLists(self, l1: ListNode, l2: ListNode) -> ListNode:
        head = ListNode(0)
        it = head
        
        while l1 and l2:
            if l1.val <= l2.val:
                it.next = l1
                l1 = l1.next
            else:
                it.next = l2
                l2 = l2.next
            it = it.next
            
        it.next = l1 or l2
        
        return head.next
