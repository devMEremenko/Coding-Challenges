//
//  WeeklyContests90.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/25/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class WeeklyContests90: XCTestCase {
    
/*
     Contest: https://leetcode.com/contest/weekly-contest-90
     Task: https://leetcode.com/contest/weekly-contest-90/problems/buddy-strings/
 
     ------Description------
     Given two strings A and B of lowercase letters,
     return true if and only if we can swap two letters in A so that the result equals B.
     
     ------Note------
     0 <= A.length <= 20000
     0 <= B.length <= 20000
     A and B consist only of lowercase letters.
 */
    
    func test() {
        
        XCTAssert(buddyStrings("ab", "ba"))
        XCTAssert(buddyStrings("aa", "aa"))
        XCTAssert(buddyStrings("aaaaaaabc", "aaaaaaacb"))
        XCTAssert(buddyStrings("aa", "aa"))
        XCTAssert(buddyStrings("ab", "ab") == false)
        XCTAssert(buddyStrings("", "aa") == false)
    }
    
    /// Time O(n)
    /// Space O(n) in a worst case
    func buddyStrings(_ a: String, _ b: String) -> Bool {
        
        guard a.count == b.count, !a.isEmpty && !b.isEmpty else { return false }
        guard a != b else {
            
            /// Handling a situation when strings are equal, but results are not
            
            /// Input: A = "aa", B = "aa"
            /// Output: true
            
            /// Input: A = "ab", B = "ab"
            // Output: false
            
            var map = [Character:Int]()
            
            for char in a {
                if map[char] != nil {
                    return true
                }
                map[char] = 1
            }
            
            return false
        }
        
        var indices = [Int]()
        indices.reserveCapacity(2)
        
        for idx in 0..<a.count {
            if a[idx] != b[idx] {
                if indices.count == 2 {
                    return false
                }
                indices.append(idx)
            }
        }
        
        guard indices.count == 2 else { return false }
        
        var arr = Array(a)
        arr.swapAt(indices[0], indices[1])
        return String(arr) == b
    }
}
