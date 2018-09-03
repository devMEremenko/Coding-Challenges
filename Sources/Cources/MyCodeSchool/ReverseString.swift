//
//  ReverseString.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/20/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

private class ReverseString: XCTestCase {
    
    func test() {
        
        XCTAssert(reverse("Hello") == String("Hello".reversed()))
        XCTAssert(reverseUsingStack("Hello") == String("Hello".reversed()))
    }
    
    func reverse(_ string: String) -> String {
        
        /// Time O(n)
        /// Space O(n)
        
        guard string.count > 1 else { return string }
        
        /// Since String is a Collection, a string shares the same storage with an array
        var items = ArraySlice(string)
        
        for i in 0..<items.count / 2 {
            let j = items.count - 1 - i
            items.swapAt(i, j)
        }
        
        return String(items)
    }
    
    func reverseUsingStack(_ string: String) -> String {
        
        /// Time O(n)
        /// Space O(n)
        
        let stack = Stack<Character>()
        
        for item in string {
            stack.push(item)
        }
        
        var result = ""
        while !stack.isEmpty {
            result.append(stack.top!)
            stack.pop()
        }
        
        return result
    }
}
