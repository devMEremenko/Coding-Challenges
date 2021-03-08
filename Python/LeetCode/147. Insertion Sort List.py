# https://leetcode.com/problems/insertion-sort-list/

# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def insertionSortList(self, head: ListNode) -> ListNode:
        # return self.solution1(head)
        return self.solution2(head)
    
    # Time: O(n log n)
    # Space: O(n) to store an array of pointers
    def solution1(self, head):
        def to_array(node):
            res = []
            prev = None
            while node:
                prev = node
                res.append(node)
                node = node.next
                prev.next = None
            return res
        
        def sort(arr):
            arr.sort(key=lambda node: node.val)
            return arr
        
        def to_linked_list(arr):
            head = None
            tail = None
            for node in arr:
                if not head:
                    head = node
                    tail = node
                else:
                    tail.next = node
                    tail = node
            return head
        
        return to_linked_list(sort(to_array(head)))
    
    # Time O(n^2), Space O(1)
    def solution2(self, head):
        fake = ListNode()
        fake.next = head
        curr = head
        prev = fake
        
        while curr:
            if curr.next and (curr.next.val < curr.val):
                # Scroll
                while prev.next and (prev.next.val < curr.next.val):
                    prev = prev.next
                
                # Sort
                temp = prev.next            # 4, 2, 1, 3
                prev.next = curr.next       # f, 2, 1, 3
                curr.next = curr.next.next  # 4, 1, 3
                prev.next.next = temp       # f, 2,  2, 1, 3
                prev = fake                 
            else:
                curr = curr.next
        
        return fake.next
