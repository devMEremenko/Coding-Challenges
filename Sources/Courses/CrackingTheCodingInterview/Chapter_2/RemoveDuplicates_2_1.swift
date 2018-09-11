//
//  RemoveDuplicates_2_1.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/12/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class RemoveDuplicatesTests: XCTestCase {
    
    func testRemoveDuplicatesStart() {

        var data = createListStart()
        
        removeDuplicates(&data.source)
        
        verify(data.source, data.expected)
    }
    
    func testRemoveDuplicatesMid() {
        
        var data = createListMid()
        
        removeDuplicates(&data.source)
        
        verify(data.source, data.expected)
    }
    
    func testRemoveDuplicatesEnd() {
        
        var data = createListEnd()
        
        removeDuplicates(&data.source)
        
        verify(data.source, data.expected)
    }
    
    func testRemoveDuplicatesWithoutBufferStart() {
        
        var data = createListStart()
        
        removeDuplicatesWithoutBuffer(&data.source)
        
        verify(data.source, data.expected)
    }
    
    func testRemoveDuplicatesWithoutBufferMid() {
        
        var data = createListMid()
        
        removeDuplicatesWithoutBuffer(&data.source)
        
        verify(data.source, data.expected)
    }
    
    func testRemoveDuplicatesWithoutBufferEnd() {
        
        var data = createListEnd()
        
        removeDuplicatesWithoutBuffer(&data.source)
        
        verify(data.source, data.expected)
    }
}

extension RemoveDuplicatesTests {
    
    /// Time: O(N)
    /// Space: O(N)
    
    private func removeDuplicates<Value: Hashable>(_ source: inout ListNode<Value>?) {
        
        while source == source?.next {
            source = source?.next
        }
        
        var map = [Value: Bool]()
        var current = source
        
        while let value = current?.next?.value {
            
            if map[value] == nil {
                map[value] = true
                current = current?.next
            } else {
                current?.next = current?.next?.next
            }
        }
    }
}

extension RemoveDuplicatesTests {
    
    /// Time: O(N^2)
    /// Space: O(1)
    
    private func removeDuplicatesWithoutBuffer<Value>(_ source: inout ListNode<Value>?) {
        
        while source == source?.next {
            source = source?.next
        }
        
        var current = source
        
        while current != nil {
            
            var runner = current
            while runner != nil {
                
                if current == runner?.next {
                    runner?.next = runner?.next?.next
                } else {
                    runner = runner?.next
                }
            }
            
            current = current?.next
        }
    }
}

extension RemoveDuplicatesTests {
    
    /// Test data
    
    private func createListStart() -> (source: ListNode<Int>?, expected: [Int]) {
        
        let head = ListNode(1)
        head.next = ListNode(1)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)
        head.next?.next?.next?.next = ListNode(5)
        
        let expected = [1, 3, 4, 5]
        
        return (head, expected)
    }
    
    private func createListMid() -> (source: ListNode<Int>?, expected: [Int]) {
        
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(3)
        head.next?.next?.next?.next = ListNode(4)
        head.next?.next?.next?.next?.next = ListNode(4)
        
        let expected = [1, 2, 3, 4]
        
        return (head, expected)
    }
    
    private func createListEnd() -> (source: ListNode<Int>?, expected: [Int]) {
        
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)
        head.next?.next?.next?.next = ListNode(4)
        
        let expected = [1, 2, 3, 4]
        
        return (head, expected)
    }
    
    private func verify(_ source: ListNode<Int>?, _ expected: [Int]) {
        
        var node = source
        
        expected.forEach({ item in
            XCTAssert(node?.value == item)
            node = node?.next
        })
    }
}

private class ListNode<Value: Equatable> {
    var value: Value
    var next: ListNode<Value>?
    
    init(_ value: Value) {
        self.value = value
    }
}

private func ==<Value: Equatable>(left: ListNode<Value>?, right: ListNode<Value>?) -> Bool {
    return left?.value == right?.value
}
