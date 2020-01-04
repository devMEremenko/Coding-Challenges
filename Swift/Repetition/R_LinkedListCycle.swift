//
//  R_LinkedListCycle.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 02.01.2020.
//  Copyright © 2020 Eremenko Maxim. All rights reserved.
//

import XCTest

class R_LinkedListCycle: XCTestCase {
    
    func test1() {
        let head = ListNode(1, ListNode(2))
        XCTAssertFalse(hasCycle(head))
    }
    
    func test2() {
        let head = ListNode(1)
        let second = ListNode(2)
        head.next = second
        second.next = head
        
        XCTAssertTrue(hasCycle(head))
    }
    
    func test3() {
        XCTAssertFalse(hasCycle(nil))
    }
}

extension R_LinkedListCycle {
    
    class ListNode {
        var val: Int
        var next: ListNode?
        
        init(_ val: Int, _ next: ListNode? = nil) {
            self.val = val
            self.next = next
        }
    }
}

extension R_LinkedListCycle {
    
    /// Time: O(n)
    /// Space: O(1)
    func hasCycle(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head

        while fast?.next?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            
            if slow === fast {
                return true
            }
        }
        return false
    }
}
