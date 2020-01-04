# https://leetcode.com/problems/linked-list-cycle/

# Definition for singly-linked list.
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None

class Solution:
    
    # []
    # [1, 2]
    # [2, 2, 2]
    # [1, 2, 3, 4, 5]
    #     <---------
    
    def hasCycle(self, head: ListNode) -> bool:        
        s = head #slow
        f = head #fast
        
        while f and f.next:
            s = s.next
            f = f.next.next
            if f is s:
                return True
        return False
