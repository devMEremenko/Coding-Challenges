//
//  KMP_Algorithm.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/18/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class KMP_Algorithm: XCTestCase {
    
    func testKMP() {
        
    }
    
    func testLSP() {
        
        XCTAssert(longestProperPrefix("AAAA") == [0, 1, 2, 3])
        XCTAssert(longestProperPrefix("ABCDE") == [0, 0, 0, 0, 0])
        XCTAssert(longestProperPrefix("AABAACAABAA") == [0, 1, 0, 1, 2, 0, 1, 2, 3, 4, 5])
        XCTAssert(longestProperPrefix("AAACAAAAAC") == [0, 1, 2, 0, 1, 2, 3, 3, 3, 4])
        XCTAssert(longestProperPrefix("AAABAAA") == [0, 1, 2, 0, 1, 2, 3])
    }

    func findSubstringsUsingKMP(in str: String, pattern: String) -> [String] {
        
        return []
    }
        
    func longestProperPrefix(_ pattern: String) -> [Int] {
        let pattern = ArraySlice(pattern)
        /// Preprocessing
        ///
        /// KMP algorithm preprocesses `pattern` and constructs an auxiliary lps[]
        /// of pattern.count which is used to skip characters while matching
        
        /// lps means "longest proper prefix which is also suffix"
        var lps = Array(repeating: 0, count: pattern.count)
        
        var left = 0
        var right = 1
        
        while right < pattern.count {
            
            if pattern[left] == pattern[right] {
                left += 1
                lps[right] = left
                right += 1
            } else {
                if left == 0 {
                    lps[right] = 0
                    right += 1
                } else {
                    left = lps[left - 1]
                }
            }
        }
        
        return lps
    }
}
