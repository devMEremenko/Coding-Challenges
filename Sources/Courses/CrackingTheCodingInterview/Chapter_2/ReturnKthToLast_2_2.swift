//
//  ReturnKthToLast_2_2.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/14/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class ReturnKthToLastTests: XCTestCase {
    
    /// Implement an algorithm to find the kth to last element of a singly linked list.
    
    func testFindKthToLastEnd() {
        
        let data = createListToFindEnd()
        
        XCTAssert(findKthToLast(data.source, data.k) == data.expected)
    }
    
    func testFindKthToLastMid() {
        
        let data = createListToFindMid()
        
        XCTAssert(findKthToLast(data.source, data.k) == data.expected)
    }
    
    func testFindKthToLastNil() {
        
        let data = createListToFindNil()
        
        XCTAssert(findKthToLast(data.source, data.k) == data.expected)
    }
}

extension ReturnKthToLastTests {
    
    /// Time: O(n)
    /// Space: O(1)
    
    typealias Value = Equatable
    
    private func findKthToLast<Value>(_ head: ListNode<Value>, _ k: Int) -> Value? {
        
        guard k >= 0 else { return nil }
        
        if let runner = findRunner(head, k) {
            return findValue(head, runner)
        }
        return nil
    }
    
    private func findRunner<Value>(_ head: ListNode<Value>, _ k: Int) -> ListNode<Value>? {
        
        var runner: ListNode<Value>? = head
        
        /// In some situations, it's better to check if runner != nil
        for _ in stride(from: k - 1, through: 1, by: -1) {
            runner = runner?.next
        }
        
        return runner
    }
    
    private func findValue<Value>(_ head: ListNode<Value>, _ runner: ListNode<Value>) -> Value? {
        
        var runner: ListNode<Value>? = runner
        var result: ListNode<Value>? = head
        
        while runner?.next != nil {
            runner = runner?.next
            result = result?.next
        }
        
        return result?.value
    }
}

extension ReturnKthToLastTests {
    
    private typealias TestData = (source: ListNode<Int>, k: Int, expected: Int?)
    
    private func createListToFindEnd() -> TestData {
        
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)
        
        return (head, 0, 4)
    }
    
    private func createListToFindMid() -> TestData {
        
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)
        
        return (head, 3, 2)
    }
    
    private func createListToFindNil() -> TestData {
        
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)
        
        return (head, 5, nil)
    }
}

private class ListNode<Value: Equatable> {
    var value: Value
    var next: ListNode<Value>?
    
    init(_ value: Value) {
        self.value = value
    }
}
