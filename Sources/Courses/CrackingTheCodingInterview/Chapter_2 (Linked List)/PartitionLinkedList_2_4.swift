//
//  PartitionLinkedList_2_4.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/14/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class PartitionLinkedListTest: XCTestCase {
    
    /// Partition
    ///
    /// Write code to partition a linked list around a value x, such that
    /// all nodes less than x come before all nodes greater than or equal
    /// to x. If x is contained within the list, the values of x only need
    /// to be after the elements less than x (see below).
    ///
    /// The partition element x can appear anywhere in the "right partition";
    /// it does not need to appear between the left and right partitions.
    ///
    /// EXAMPLE
    /// Input: 3 -> 5 -> 8 -> 5 -> 10 -> 2 -> 1 [partition=5]
    /// Output: 3 -> 1 -> 2 -> 10 -> 5 -> 5 -> 8
    
    func testWithList1() {
        
        let data = createList1()
        
        let newHead = partition(data.source, data.partition)

        verify(newHead, data.expected)
    }
    
    func testWithList2() {
        
        let data = createList2()
        
        let newHead = partition(data.source, data.partition)
        
        verify(newHead, data.expected)
    }
    
    private func verify(_ source: Node, _ expected: Node) {
        
        /// make mutable
        var sourceCheck: Node? = source
        var expectedCheck: Node? = expected
        
        while sourceCheck != nil {
            XCTAssert(sourceCheck?.value == expectedCheck?.value)
            sourceCheck = sourceCheck?.next
            expectedCheck = expectedCheck?.next
        }
    }
}

extension PartitionLinkedListTest {
    
    /// Time: O(n)
    /// Space: O(1)
    
    /// As another solution, max and min heads can be created
    /// and joined in the end to support stability.
    
    private typealias Node = ListNode<Int>
    
    private func partition(_ node: Node, _ partition: Int) -> Node {
        
        var head: Node? = node
        var tail: Node? = node
        
        /// makes mutable
        var node: Node? = node
        
        while node != nil {
            
            let next = node?.next
            
            if node!.value < partition {
                node?.next = head
                head = node
            } else {
                tail?.next = node
                tail = node
            }
            node = next
        }
        
        tail?.next = nil
        
        return head!
    }
}

extension PartitionLinkedListTest {
    
    private typealias TestData = (source: Node, partition: Int, expected: Node)
    
    private func createList1() -> TestData {
        
        let source = ListNode(3)
        source.next = ListNode(4)
        source.next?.next = ListNode(1)
        source.next?.next?.next = ListNode(2)
        
        /// Note: 2 not less than 2, so that's why it's in the end
        let expected = ListNode(1)
        expected.next = ListNode(3)
        expected.next?.next = ListNode(4)
        expected.next?.next?.next = ListNode(2)
        
        return (source, 2, expected)
    }
    
    private func createList2() -> TestData {
        
        let source = ListNode(1)
        source.next = ListNode(3)
        source.next?.next = ListNode(2)
        source.next?.next?.next = ListNode(4)
        
        /// Note: 2 not less than 2, so that's why it's inserted after 3
        let expected = ListNode(1)
        expected.next = ListNode(3)
        expected.next?.next = ListNode(2)
        expected.next?.next?.next = ListNode(4)
        
        return (source, 2, expected)
    }
}

private class ListNode<Value: Comparable> {
    
    var value: Value
    var next: ListNode<Value>?
    
    init(_ value: Value) {
        self.value = value
    }
}
