//
//  AddTwoNumbers_2.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/12/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class AddTwoNumbers_2: XCTestCase {
    
    /*
     https://leetcode.com/problems/add-two-numbers/description/
     
     //////////////////////////////////////////
     Solution
     
        Time complexity: O(n)
        Space complexity: O(n) (Memory is used only for the resultant linked list)
     
     
        The idea is pretty simple:
     
        Enumerate linked lists and sum up two values at a time.
        If a result overflows then add an extra value in the next iteration.
     */
    
    //MARK: Tests
    
    func testAddTwoNumbers() {
        
        addTwoNumbers(first: 0, second: 123)
        addTwoNumbers(first: 6523464, second: 0)
        addTwoNumbers(first: 76203, second: 4451)
        addTwoNumbers(first: 2346, second: 75)
        addTwoNumbers(first: 12, second: 34)
        addTwoNumbers(first: 0000012, second: 000034)
        addTwoNumbers(first: 999999999999999999, second: 999999999999999999)
    }
    
    func addTwoNumbers(first: Int, second: Int) {
        
        let firstList = _listForNumber(first)
        let secondList = _listForNumber(second)
        
        var list = addTwoNumbers(firstList, secondList)
        
        var result = 0
        
        while list != nil {
            result = result * 10 + (list?.val ?? 0)
            list = list?.next
        }
        
        XCTAssert(result == _reverse(_reverse(first) + _reverse(second)))
    }

    
    //MARK: Solution
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var over = 0
        let head = ListNode(-1)
        var current: ListNode? = head
        
        var l1 = l1
        var l2 = l2
        
        while l1 != nil || l2 != nil || over > 0 {
            
            let v1 = l1?.val ?? 0
            let v2 = l2?.val ?? 0
            let v = (v1 + v2 + over) % 10
            current?.next = ListNode(v)
            current = current?.next
            over = v1 + v2 + over > 9 ? 1 : 0
            
            l1 = l1?.next
            l2 = l2?.next
        }
        
        return head.next
    }
    
    class ListNode {
        var val: Int
        var next: ListNode?
        
        init(_ value: Int, next: ListNode? = nil) {
            self.val = value
            self.next = next
        }
    }
    
    
    //MARK: Helpers
    
    func _reverse(_ source: Int) -> Int {
        
        var source = source
        var result = 0
        
        while source != 0 {
            
            let digit = source % 10
            result = result * 10 + digit
            source = source / 10
        }
        
        guard result < Int.max && result > Int.min else { return 0 }
        
        return result
    }
    
    func _listForNumber(_ number: Int) -> ListNode? {
        
        var head: ListNode?
        var number = number
        
        while number != 0 {
            
            let digit = number % 10
            number = number / 10
            
            let node = ListNode(digit)
            node.next = head
            head = node
        }
        
        return head
    }
}
