//
//  PalindromeLinkedList_2_6.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/15/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class PalindromeLinkedListTests: XCTestCase {
    
    /// Palindrome
    ///
    /// Implement a function to check if a linked list is a palindrome.
}

extension PalindromeLinkedListTests {
    
    // MARK: - Testing a Recursion solution
    
    func testEvenPalindromeList() {
        
        let data = createEvenPalindromeList()
        
        XCTAssert(isPalindrome(data.source) == data.expected)
    }
    
    func testOddPalindromeList() {
        
        let data = createOddPalindromeList()
        
        XCTAssert(isPalindrome(data.source) == data.expected)
    }
    
    func testEvenFakeList() {
        
        let data = createEvenFakeList()
        
        XCTAssert(isPalindrome(data.source) == data.expected)
    }
    
    func testOddFakeList() {
        
        let data = createOddFakeList()
        
        XCTAssert(isPalindrome(data.source) == data.expected)
    }
    
    func testSimpleEvenFakeList() {
        
        let data = createSimpleEvenFakeList()
        
        XCTAssert(isPalindrome(data.source) == data.expected)
    }
    
    func testSimpleOddFakeList() {
        
        let data = createSimpleOddFakeList()
        
        XCTAssert(isPalindrome(data.source) == data.expected)
    }
}

extension PalindromeLinkedListTests {
    
    // MARK: - Testing a Stack solution
    
    func testStackEvenPalindromeList() {
        
        let data = createEvenPalindromeList()
        
        XCTAssert(isPalindromeUsingStack(data.source) == data.expected)
    }
    
    func testStackOddPalindromeList() {
        
        let data = createOddPalindromeList()
        
        XCTAssert(isPalindromeUsingStack(data.source) == data.expected)
    }
    
    func testStackEvenFakeList() {
        
        let data = createEvenFakeList()
        
        XCTAssert(isPalindromeUsingStack(data.source) == data.expected)
    }
    
    func testStackOddFakeList() {
        
        let data = createOddFakeList()
        
        XCTAssert(isPalindromeUsingStack(data.source) == data.expected)
    }
    
    func testStackSimpleEvenFakeList() {
        
        let data = createSimpleEvenFakeList()
        
        XCTAssert(isPalindromeUsingStack(data.source) == data.expected)
    }
    
    func testStackSimpleOddFakeList() {
        
        let data = createSimpleOddFakeList()
        
        XCTAssert(isPalindromeUsingStack(data.source) == data.expected)
    }
}

// MARK: - Recursion Solution

extension PalindromeLinkedListTests {
    
    /// Time: O(n)
    /// Space: O(n)
    
    /// Recursively traverse a linked list.
    /// When the end pointer is at the finish, compare it with the start pointer.
    ///
    /// As an alternative, we can calculate and pass a size of a linked list
    /// as a parameter of the function and do not use a level at all.
    /// But it requires an additional traversing.
    
    typealias Result = (isPalindrome: Bool, level: Int)
    
    private func isPalindrome(_ head: Node) -> Bool {
        var head: Node? = head
        return isPalindromeHelper(&head, head, 1).isPalindrome
    }
    
    private func isPalindromeHelper(_ start: inout Node?, _ end: Node?, _ level: Int) -> Result {
        
        guard let end = end else { return (true, level / 2) }
        
        let result = isPalindromeHelper(&start, end.next, level + 1)
        
        guard result.isPalindrome && result.level > 0 else { return result }
        
        defer {
            start = start?.next
        }
        return (start?.value == end.value, level - 1)
    }
}

// MARK: - Stack Solution

extension PalindromeLinkedListTests {
    
    /// Time: O(n)
    /// Space: O(n)
    
    private func isPalindromeUsingStack(_ head: Node) -> Bool {
        
        let stack = Stack<Int>()
        
        var slower: Node? = head
        var runner: Node? = head
        
        while runner?.next != nil {
            stack.push(slower!.value)
            slower = slower?.next
            runner = runner?.next?.next
        }
        
        /// List has odd number of elements, so skip the middle element
        if runner != nil {
            slower = slower?.next
        }
        
        while slower != nil {
            guard slower?.value == stack.pop() else { return false }
            slower = slower?.next
        }
        
        return stack.isEmpty
    }
}

extension PalindromeLinkedListTests {
    
    // MARK: - Test Data
    
    private typealias Node = ListNode<Int>
    private typealias TestData = (source: Node, expected: Bool)
    
    private func createEvenPalindromeList() -> TestData {
        
        let source = ListNode(3)
        source.next = ListNode(4)
        source.next?.next = ListNode(4)
        source.next?.next?.next = ListNode(3)
        
        return (source, true)
    }
    
    private func createOddPalindromeList() -> TestData {
        
        let source = ListNode(1)
        source.next = ListNode(2)
        source.next?.next = ListNode(3)
        source.next?.next?.next = ListNode(2)
        source.next?.next?.next?.next = ListNode(1)
        
        return (source, true)
    }
    
    private func createEvenFakeList() -> TestData {
        
        let source = ListNode(1)
        source.next = ListNode(2)
        source.next?.next = ListNode(3)
        source.next?.next?.next = ListNode(2)
        source.next?.next?.next?.next = ListNode(2)
        source.next?.next?.next?.next?.next = ListNode(1)
        
        return (source, false)
    }
    
    private func createOddFakeList() -> TestData {
        
        let source = ListNode(1)
        source.next = ListNode(2)
        source.next?.next = ListNode(3)
        source.next?.next?.next = ListNode(1)
        source.next?.next?.next?.next = ListNode(1)
        
        return (source, false)
    }
    
    private func createSimpleEvenFakeList() -> TestData {
        
        let source = ListNode(1)
        source.next = ListNode(2)
        source.next?.next = ListNode(2)
        source.next?.next?.next = ListNode(0)
        
        return (source, false)
    }
    
    private func createSimpleOddFakeList() -> TestData {
        
        let source = ListNode(1)
        source.next = ListNode(2)
        source.next?.next = ListNode(3)
        source.next?.next?.next = ListNode(2)
        source.next?.next?.next?.next = ListNode(0)
        
        return (source, false)
    }
}

private class ListNode<Value: Equatable> {
    
    var value: Value
    var next: ListNode<Value>?
    
    init(_ value: Value) {
        self.value = value
    }
}
