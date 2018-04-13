//
//  ReverseInteger_7.swift
//  LeetCodeTests
//
//  Created by Maxim Eremenko on 4/11/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class ReverseInteger_7: XCTestCase {
    
    /*
     
     https://leetcode.com/problems/reverse-integer/description/
     
     Solution 1. Very bad.
        Time complexity O(1)
     
        - convert Int to String
        - revert String
        - convert String to Int
     
     Solution 2.
        Time complexity O(1)
     
        - find the remainder of the given number
        - construct a result number as (result * 10 + reminder)
     */
    
    func testReverseInteger_7() {
        
        XCTAssert(reverseUsingString(123) == 321)
        XCTAssert(reverseUsingString(-538) == -835)
        XCTAssert(reverseUsingString(5352) == 2535)
        XCTAssert(reverseUsingString(1534236469) == 0)
        
        XCTAssert(reverse(123) == 321)
        XCTAssert(reverse(-538) == -835)
        XCTAssert(reverse(5352) == 2535)
        XCTAssert(reverse(1534236469) == 0)
    }
    
    
    //MARK: Solution 1
    
    func reverseUsingString(_ x: Int) -> Int {
        
        var str = String(x)
        str = String(str.reversed())
        
        if str.hasSuffix("-") {
            str.remove(at: str.index(before: str.endIndex))
            str.insert("-", at: str.startIndex)
        }
        
        let result = Int(str) ?? 0
        
        guard result < Int32.max && result > Int32.min else { return 0 }
        
        return result
    }
    
    
    //MARK: Solution 2
    
    func reverse(_ source: Int) -> Int {
        
        var source = source
        var result = 0
        
        while source != 0 {
            
            let digit = source % 10
            result = result * 10 + digit
            source = source / 10
        }
        
        guard result < Int32.max && result > Int32.min else { return 0 }
        
        return result
    }
}
