//
//  Runner_2_0.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 9/10/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class RunnerTests: XCTestCase {
    
    /// Suppose you have a linked list:
    ///
    /// a1 -> a2 -> ... -> aN -> b1 -> b2 -> ... -> bN
    ///
    /// and you want to rearrange it into:
    ///
    /// a1 -> b1 -> a2 -> b2 -> ... -> aN -> bN
    ///
    /// You do not know the length of the linked list,
    /// but you do know that the length is an even number.
    
    func test() {
        
        let result = createList()
        
        rearrange(result.head)
        
        var node: ListNode<Int>? = result.head
        
        for item in result.expected {
            XCTAssert(node?.value == item)
            node = node?.next
        }
    }
}

extension RunnerTests {
    
    private func rearrange<Value>(_ head: ListNode<Value>) {
        
        var slow: ListNode<Value>? = head
        var fast = head.next
        
        while let item = fast?.next?.next {
            slow = slow?.next
            fast = item
        }
        
        fast = head
        slow = slow?.next
        
        while slow != nil {
            let tempFast = fast?.next
            let tempSlow = slow?.next
            
            fast?.next = slow
            slow?.next = tempFast
            
            slow = tempSlow
            fast = tempFast
        }
    }
}

extension RunnerTests {
    
    /// Test data
    
    private func createList() -> (head: ListNode<Int>, expected: [Int]) {
        
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)
        head.next?.next?.next?.next = ListNode(5)
        head.next?.next?.next?.next?.next = ListNode(6)
        
        let expected = [1, 4, 2, 5, 3, 6]
        
        return (head, expected)
    }
}

private class ListNode<Value> {
    
    var value: Value
    var next: ListNode<Value>?
    
    init(_ value: Value) {
        self.value = value
    }
}
