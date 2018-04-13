//
//  PalindromeNumber_9.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/13/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class PalindromeNumber_9: XCTestCase {
    
    /*
     https://leetcode.com/problems/palindrome-number/description/
     
     Time complexity: O(n)
     Space complexity: O(1)
     
     Solution:
     
     1) Retrieve digits of a given number and create a half of a reversed number.
     2) Divide original value by 10, and multiplied the reversed number by 10.
     3) When a reversed value is greater then original - it means, we've reached the middle.
     4) If the original and reversed values are the same - it is a palindrome.
     
     */
    
    func testIsPalindrome() {
        
        XCTAssert(isPalindrome(12321))
        XCTAssert(isPalindrome(123321))
        XCTAssert(isPalindrome(0))
        XCTAssert(isPalindrome(91989989998998919))
        XCTAssert(isPalindrome(99999999999999999))
        XCTAssert(isPalindrome(-0))
        XCTAssert(isPalindrome(-1) == false)
        XCTAssert(isPalindrome(12345) == false)
    }
    
    func isPalindrome(_ x: Int) -> Bool {
        
        guard x >= 0 else { return false }
        guard x != 0 else { return true }
        guard x % 10 != 0 else { return false }
        
        var x = x
        var reversed = 0
        
        while x > reversed {
            let digit = reversed * 10
            reversed =  digit + x % 10
            x /= 10
        }
        
        return x == reversed || (reversed / 10 == x)
    }
}
