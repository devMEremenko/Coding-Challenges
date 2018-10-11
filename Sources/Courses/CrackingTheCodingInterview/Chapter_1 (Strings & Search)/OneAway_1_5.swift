//
//  OneAway_1_5.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class OneAwayTests: XCTestCase {
    
    /// One Away: There are three types of edits that can be performed on strings:
    /// insert a character, remove a character, or replace a character.
    /// Given two strings, write a function to check if they are
    /// one edit (or zero edits) away.
    
    func test() {
        
        XCTAssert(isOneAway("max", "max"))
        XCTAssert(isOneAway("max", "ma"))
        XCTAssert(isOneAway("ax", "max"))

        XCTAssert(isOneAway("max", "maxim") == false)
        XCTAssert(isOneAway("max", "mall") == false)
        XCTAssert(isOneAway("max", "mmm") == false)
        XCTAssert(isOneAway("maxm", "mmx") == false)
        XCTAssert(isOneAway("maxm", "mx") == false)
    }
}

extension OneAwayTests {
    
    /// Time: O(n)
    /// Space: O(1)
    
    func isOneAway(_ s1: String, _ s2: String) -> Bool {
        
        if abs(s1.count - s2.count) < 2 {
            return checkIsOneAway(s1, s2)
        }
        return false /// Length diff > 1
    }
    
    /// There 2 options:
    ///
    /// 1) Length is equal. Only one pair of characters should be different.
    ///
    /// 2) Length is different by 1 character.
    ///    In that case, when we catch a pair of different characters
    ///    the index of the max string should be increased and remaining
    ///    characters should be the same.
    
    private func checkIsOneAway(_ s1: String, _ s2: String) -> Bool {
        
        let minString = s1.count < s2.count ? s1 : s2
        let maxString = s1.count < s2.count ? s2 : s1
        
        var foundDiff = false
        var minIdx = 0
        var maxIdx = 0
        
        while minIdx < minString.count {
            
            if minString[minIdx] != maxString[maxIdx] {
                
                if foundDiff {
                    return false
                }
                foundDiff = true
                
                if minString.count != maxString.count {
                    maxIdx += 1
                    continue
                }
            }
            
            minIdx += 1
            maxIdx += 1
        }
        
        return true
    }
}
