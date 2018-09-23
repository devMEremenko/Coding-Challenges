//
//  LoopDetection_2_8.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/24/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class LoopDetectionLinkedListTests: XCTestCase {
    
    /// Loop Detection
    ///
    /// Given a circular linked list, implement an algorithm that returns
    /// the node at the beginning of the loop.
    ///
    /// Note: circular linked list: A (corrupt) linked list in which a node's next
    /// pointer points to an earlier node, so as to make a loop in the linked list.
    ///
    /// Example
    ///
    /// Input: A -> B -> C -> D -> E -> C [the same C as earlier]
    ///
    /// Output: C
    
    func test() {
        
        let data = createList()
        
        XCTAssert(detectLoopNode(data.head) === data.expected)
    }
}

extension LoopDetectionLinkedListTests {
    
    /// Time: O(n)
    /// Space: O(1)
    
    private func detectLoopNode(_ head: Node) -> Node? {
        if let slow = findSlowNode(head) {
            return findLoopNode(head, slow)
        }
        return nil
    }
    
    private func findSlowNode(_ head: Node) -> Node? {
        
        var slow: Node? = head
        var fast: Node? = head
        
        while fast != nil {
            slow = slow?.next
            fast = fast?.next?.next
            
            if slow === fast {
                return slow
            }
        }
        
        return nil
    }
    
    private func findLoopNode(_ head: Node, _ slow: Node) -> Node? {
        
        var head: Node? = head
        var slow: Node? = slow
        
        while head !== slow {
            head = head?.next
            slow = slow?.next
        }
        
        return head
    }
}

extension LoopDetectionLinkedListTests {
    
    private typealias Node = ListNode<Int>
    private typealias TestData = (head: Node, expected: Node)
    
    private func createList() -> TestData {
        
        let loopNode = ListNode(3)
        
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = loopNode
        head.next?.next?.next = ListNode(4)
        head.next?.next?.next?.next = ListNode(5)
        head.next?.next?.next?.next?.next = ListNode(6)
        head.next?.next?.next?.next?.next?.next = loopNode
        
        /// 1-2-3-4-5-6->
        ///     |       |
        ///     <-------V
        
        return (head, loopNode)
    }
}

private class ListNode<Value: Comparable> {
    
    var value: Value
    var next: ListNode<Value>?
    
    init(_ value: Value) {
        self.value = value
    }
}
