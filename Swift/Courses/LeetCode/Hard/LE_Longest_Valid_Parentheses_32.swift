//
//  LE_Longest_Valid_Parentheses_32.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 03/02/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class LE_Longest_Valid_Parentheses_32: XCTestCase {
    
    /// Given a string containing just the characters '(' and ')'.
    /// Find the length of the longest valid (well-formed) parentheses substring.
    ///
    /// https://leetcode.com/problems/longest-valid-parentheses/
    
    func test_usingStack_isCorrect() {
        XCTAssertEqual(solveUsingStack("()()((()()(()()((()"), 4)
    }
    
    func test_usingPointers_isCorrect() {
        XCTAssertEqual(solveUsingPointers("()()((()()(()()((()"), 4)
    }
}

extension LE_Longest_Valid_Parentheses_32 {
    
    /// Time: O(n)
    /// Space: O(1)
    func solveUsingPointers(_ s: String) -> Int {
        return max(findMaxRange(s, >), findMaxRange(s.reversed(), <))
    }
    
    func findMaxRange<S: Collection>(_ collection: S,_ compare: (Int, Int) -> Bool) -> Int where S.Element == Character {
        
        var maxValue = 0
        var left = 0
        var right = 0
        
        for char in collection {
            if char == "(" { left += 1 } else { right += 1 }
            
            if left == right {
                maxValue = max(maxValue, left * 2)
            } else if compare(right, left) {
                left = 0
                right = 0
            }
        }
        return maxValue
    }
}

extension LE_Longest_Valid_Parentheses_32 {
    
    /// Time: O(n)
    /// Space: O(n)
    func solveUsingStack(_ s: String) -> Int {
        var stack = [-1] // The linked list based stack should speed up the performance
        var maxValue = 0
        for (idx, char) in s.enumerated() {
            if char == "(" {
                stack.append(idx)
            } else {
                _ = stack.popLast()
                if stack.isEmpty {
                    stack.append(idx)
                } else {
                    maxValue = max(maxValue, idx - stack.last!)
                }
            }
        }
        return maxValue
    }
}
