# https://leetcode.com/problems/middle-of-the-linked-list/

# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
        
class Solution:
    def middleNode(self, head: ListNode) -> ListNode:
        # return self.solve_using_fast_slow_pointers(head)
        return self.solve_by_searching_for_middle(head)
        
    def solve_by_searching_for_middle(self, head):
        count = 0
        temp = head
        while temp:
            count += 1
            temp = temp.next
        
        middle = head
        for _ in range(count // 2):
            middle = middle.next
        return middle
        
    
    def solve_using_fast_slow_pointers(self, head):
        slow = head
        fast = head
        
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
            
        return slow
    