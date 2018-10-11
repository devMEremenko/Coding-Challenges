//
//  Intersection_2_7.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/24/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class IntersectionLinkedListTests: XCTestCase {
    
    /// Intersection
    ///
    /// Given two (singly) linked lists, determine if the two lists intersect.
    /// Return the intersecting node.
    ///
    /// Note: the intersection is defined based on reference, not value.
    /// That is, if the kth node of the first linked list is the exact same
    /// node (by reference) as the jth node of the second linked list,
    /// then they are intersecting.
    
    func testIntersectionOdd() {
        
        var data = createListOdd()
        
        XCTAssert(intersectionNode(&data.first, &data.second) === data.expected)
    }
    
    func testIntersectionEven() {
        
        var data = createListEven()
        
        XCTAssert(intersectionNode(&data.first, &data.second) === data.expected)
    }
}

extension IntersectionLinkedListTests {
    
    /// Time: O(n)
    /// Space: O(1)
    
    private func intersectionNode(_ head1: inout Node, _ head2: inout Node) -> Node? {
        
        let count1 = listCount(head1)
        let count2 = listCount(head2)
        let diff = abs(count1 - count2)
        
        if count1 < count2 {
            head2 = scroll(head2, diff)
        } else if count1 > count2 {
            head1 = scroll(head1, diff)
        }
        
        return _findIntersectionNode(head1, head2)
    }
    
    private func scroll(_ head: Node, _ times: Int) -> Node {
        var newHead: Node? = head
        for _ in 0..<times {
            newHead = newHead?.next
        }
        return newHead!
    }
    
    private func _findIntersectionNode(_ head1: Node, _ head2: Node) -> Node? {
        var head1: Node? = head1
        var head2: Node? = head2
        
        while head1 != nil && head2 != nil {
            if head1 === head2 {
                return head1
            }
            head1 = head1?.next
            head2 = head2?.next
        }
        return nil
    }
    
    private func listCount(_ head: Node) -> Int {
        var head: Node? = head
        var count = 0
        
        while head != nil {
            head = head?.next
            count += 1
        }
        return count
    }
}

extension IntersectionLinkedListTests {
    
    private typealias Node = ListNode<Int>
    private typealias TestData = (first: Node, second: Node, expected: Node)
    
    private func createListOdd() -> TestData {
        
        let first = ListNode(1)
        first.next = ListNode(2)
        first.next?.next = ListNode(3)
        first.next?.next?.next = ListNode(4)
        
        let second = ListNode(1)
        second.next = ListNode(2)
        second.next?.next = first.next
        
        /// 1 2 3 4
        ///   |
        /// 1 2
        
        return (first, second, first.next!)
    }
    
    private func createListEven() -> TestData {
        
        let first = ListNode(1)
        first.next = ListNode(2)
        first.next?.next = ListNode(3)
        first.next?.next?.next = ListNode(4)
        
        let second = ListNode(1)
        second.next = first.next
        
        /// 1 2 3 4
        ///   |
        ///   1
        
        return (first, second, first.next!)
    }
}

private class ListNode<Value: Comparable> {
    
    var value: Value
    var next: ListNode<Value>?
    
    init(_ value: Value) {
        self.value = value
    }
}
