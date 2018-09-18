//
//  DeleteMiddleNode_2_3.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/14/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class DeleteMiddleNodeTests: XCTestCase {
    
    /// Delete Middle Node
    ///
    /// Implement an algorithm to delete a node in the middle (i. e., any node
    /// but the first and last node, not necessarily the exact middle) of a singly
    /// linked list, given only access to that node.
    ///
    /// Note: You are not given access to the head of the linked list
    ///
    /// Input: the node c from the linked list a->b->c->d->e->f
    /// Result: nothing is returned, but the new linked list looks like a->b->d->e->f
    
    func test() {
        
        let data = createList()
        
        deleteMiddle(data.toDelete)
        
        verify(data.source, data.expected)
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

extension DeleteMiddleNodeTests {
    
    /// Time(1)
    /// Space(1)
    
    private func deleteMiddle<Value: Equatable>(_ node: ListNode<Value>) {
        
        guard let next = node.next else {
            return /// Note: the last node cannot be deleted. It may become a dummy node
        }
        
        node.value = next.value
        node.next = next.next
    }
}

extension DeleteMiddleNodeTests {
    
    private typealias Node = ListNode<Int>
    private typealias TestData = (source: Node, toDelete: Node, expected: Node)
    
    private func createList() -> TestData {
        
        let toDelete = ListNode(2)
        
        let source = ListNode(1)
        source.next = toDelete
        source.next?.next = ListNode(3)
        source.next?.next?.next = ListNode(4)
        
        let expected = ListNode(1)
        expected.next = ListNode(3)
        expected.next?.next = ListNode(4)
        
        return (source, toDelete, expected)
    }
}

private class ListNode<Value: Equatable> {
    
    var value: Value
    var next: ListNode<Value>?
    
    init(_ value: Value) {
        self.value = value
    }
}
