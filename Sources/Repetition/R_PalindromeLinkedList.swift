//
//  R_PalindromeLinkedList.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 04/07/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class R_PalindromeLinkedList: XCTestCase {
    
    /// https://leetcode.com/problems/palindrome-linked-list/
    
    func test1() {
        let value = ListNode(1)
        value.next = ListNode(0)
        value.next?.next = ListNode(3)
        value.next?.next?.next = ListNode(4)
        value.next?.next?.next?.next = ListNode(0)
        value.next?.next?.next?.next?.next = ListNode(1)
        XCTAssertFalse(isPalindrome(value))
    }
    
    func test2() {
        let value = ListNode(0)
        value.next = ListNode(0)
        XCTAssertTrue(isPalindrome(value))
    }
}

extension R_PalindromeLinkedList {
    
    func isPalindrome(_ head: ListNode?) -> Bool {
        if let head = head {
            return compare(head, reverse(findMid(head)))
        }
        return true
    }
    
    private func findMid(_ head: ListNode) -> ListNode {
        var fast: ListNode? = head
        var slow: ListNode? = head
        
        if slow?.next != nil {
            /// 1 2 3 4   slow stops at 3
            /// 1 2 3 4 5 slow stops at 4 (middle + 1)
            slow = slow?.next
        }
        while fast?.next?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        
        return slow!
    }
    
    private func reverse(_ node: ListNode) -> ListNode {
        /// 1) Creates a new head node
        /// -----------loop-----------
        /// 2) Stores pointer to the next node (curr.next)
        /// 3) Points curr.next to the new node
        /// 4) Sets new head to the current node
        /// 5) Sets current node to the next (previously stored)
        var newHead: ListNode? = nil
        var curr: ListNode? = node
        
        while curr != nil {
            let next = curr?.next
            curr?.next = newHead
            newHead = curr
            curr = next
        }
        
        return newHead! // The new head is never nil.
    }
    
    private func compare(_ head: ListNode, _ reversed: ListNode) -> Bool {
        var first: ListNode? = head
        var second: ListNode? = reversed
        while second != nil {
            if first?.val != second?.val {
                return false
            }
            first = first?.next
            second = second?.next
        }
        return true
    }
}

extension R_PalindromeLinkedList {
    
    class ListNode {
        
        var val: Int
        var next: ListNode?
        
        init(_ value: Int) {
            self.val = value
        }
    }
}
