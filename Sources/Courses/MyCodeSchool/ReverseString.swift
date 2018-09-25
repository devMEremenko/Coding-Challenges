//
//  ReverseString.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/20/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

private class ReverseString: XCTestCase {
    
    func testReverseOddCharacters() {
        
        var source = "Hello"
        
        reverse(&source)
        
        XCTAssert(source == String("Hello".reversed()))
    }
    
    func testReverseEvenCharacters() {
        
        var source = "Name is Alex"
        
        reverse(&source)
        
        XCTAssert(source == String("Name is Alex".reversed()))
    }
    
    func testReverseUsingStack() {
        
        XCTAssert(reverseUsingStack("Hello") == String("Hello".reversed()))
    }
}

extension ReverseString {
    
    /// Time O(n)
    /// Space O(1)
    
    func reverse(_ source: inout String) {
        
        guard source.count > 1 else { return }
        
        for startIdx in 0..<source.count / 2 {
            
            let endIdx = source.count - 1 - startIdx
            
            let temp = source[startIdx]
            source[startIdx] = source[endIdx]
            source[endIdx] = temp
        }
    }
}

extension ReverseString {
    
    /// Time O(n)
    /// Space O(n)
    
    func reverseUsingStack(_ source: String) -> String {
        
        var stack = Stack<Character>()
        
        for item in source {
            stack.push(item)
        }
        
        var result = ""
        result.reserveCapacity(source.count)
        
        while !stack.isEmpty {
            result.append(stack.pop()!)
        }
        
        return result
    }
}
