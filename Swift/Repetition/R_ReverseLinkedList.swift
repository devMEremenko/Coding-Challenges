//
//  R_ReverseLinkedList.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 04/07/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class R_ReverseLinkedList: XCTestCase {
    
    func test() {
        let value = ListNode(1)
        value.next = ListNode(0)
        value.next?.next = ListNode(3)
        value.next?.next?.next = ListNode(4)
        value.next?.next?.next?.next = ListNode(0)
        value.next?.next?.next?.next?.next = ListNode(1)
        
        let traversed = reverseList(value)
        XCTAssertEqual(ListNode.values(traversed), [1, 0, 4, 3, 0, 1])
    }
}

extension R_ReverseLinkedList {
    
    func reverseList(_ head: ListNode?) -> ListNode? {
        var curr = head
        var newHead: ListNode? = nil
        
        while curr != nil {
            let next = curr?.next
            curr?.next = newHead
            newHead = curr
            curr = next
        }
        return newHead
    }
}

extension R_ReverseLinkedList {
    
    class ListNode {
        
        var val: Int
        var next: ListNode?
        
        init(_ value: Int) {
            self.val = value
        }
        
        static func values(_ node: ListNode?) -> [Int] {
            var result = [Int]()
            var node = node
            while let current = node {
                result.append(current.val)
                node = node?.next
            }
            return result
        }
    }
}
