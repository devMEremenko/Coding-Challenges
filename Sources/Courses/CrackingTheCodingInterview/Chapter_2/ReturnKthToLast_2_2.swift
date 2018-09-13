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
    
    private typealias Value = Equatable
    
    func testFindKthEnd() {
        
        let data = createListToFindEnd()
        
        XCTAssert(findKth(data.source, data.k) == data.expected)
    }
    
    func testFindKthMid() {
        
        let data = createListToFindMid()
        
        XCTAssert(findKth(data.source, data.k) == data.expected)
    }
    
    func testFindKthNil() {
        
        let data = createListToFindNil()
        
        XCTAssert(findKth(data.source, data.k) == data.expected)
    }
    
    func testFindKthRecursivelyEnd() {
        
        let data = createListToFindEnd()
        
        XCTAssert(findKthRecursively(data.source, data.k) == data.expected)
    }
    
    func testFindKthRecursivelyMid() {
        
        let data = createListToFindMid()
        
        XCTAssert(findKthRecursively(data.source, data.k) == data.expected)
    }
    
    func testFindKthRecursivelyNil() {
        
        let data = createListToFindNil()
        
        XCTAssert(findKthRecursively(data.source, data.k) == data.expected)
    }
}

extension ReturnKthToLastTests {
    
    /// Time: O(n)
    /// Space: O(1)
    
    private func findKth<Value>(_ head: ListNode<Value>, _ k: Int) -> Value? {
        
        guard k >= 0 else { return nil }
        
        if let runner = findRunner(head, k) {
            return findValue(head, runner)
        }
        
        return nil
    }
    
    private func findRunner<Value>(_ head: ListNode<Value>, _ k: Int) -> ListNode<Value>? {
        
        var runner: ListNode<Value>? = head
        
        /// In some situations, it's better to check if runner != nil
        for _ in stride(from: k, through: 1, by: -1) {
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
    
    /// Time: O(n)
    /// Space: O(n)
    
    private func findKthRecursively<Value>(_ head: ListNode<Value>, _ k: Int) -> Value? {
        return __findKthRecursively(head, k).value
    }
    
    private func __findKthRecursively<Value>
        (_ head: ListNode<Value>?, _ k: Int) -> (value: Value?, level: Int) {
        
        guard let node = head else { return (nil, 0) }
        
        let result = __findKthRecursively(node.next, k)
        
        if let value = result.value {
            return (value, result.level) /// value has been already found, just return it
        }
        
        let level = result.level
        
        if k - level == 0 { /// check if it's a right level
            return (node.value, result.level)
        }
        
        return (nil, level + 1) /// get back to a previous level
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
        
        return (head, 3, 1)
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
