//
//  RomanToInteger_13.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/16/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class RomanToInteger_13: XCTestCase {
    
    /*
     https://leetcode.com/problems/roman-to-integer/description/
     
     Given a roman numeral, convert it to an integer.
     Input is guaranteed to be within the range from 1 to 3999.
     
     ---------Example---------
     Input: "III"
     Output: 3
     
     Input: "LVIII"
     Output: 58
     Explanation: C = 100, L = 50, XXX = 30 and III = 3.
     
     Input: "MCMXCIV"
     Output: 1994
     Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
     
     ---------Solution---------
     1) Enumerate an input string from the end.
     2) Subtract the current value from the sum if it's less than previous.
        Otherwise, add current value to the sum and change previous.
     */
    
    func testRomanToInt() {
        
        XCTAssert(romanToInt("XIIV") == 13)
        XCTAssert(romanToInt("XIV") == 14)
        XCTAssert(romanToInt("XV") == 15)
        XCTAssert(romanToInt("XVI") == 16)
        XCTAssert(romanToInt("XVII") == 17)
        XCTAssert(romanToInt("CXVII") == 117)
        XCTAssert(romanToInt("ICXVII") == 116)
        XCTAssert(romanToInt("ICXVIII") == 117)
        XCTAssert(romanToInt("ICXVIII") == 117)
        XCTAssert(romanToInt("MDCCCLXXXIV") == 1884)
    }
    
    func romanToInt(_ s: String) -> Int {
        
        var sum = 0
        var prev = 0
        
        var i = s.count - 1
        while i >= 0 {
            
            let current = s[i].number
            if current < prev {
                sum -= current
            } else {
                sum += current
                prev = current
            }
            i -= 1
        }
        
        return sum
    }
}

extension String {
    
    subscript (idx: Int) -> Character {
        return self[index(startIndex, offsetBy: idx)]
    }
}

extension Character {
    
    var number: Int {
        switch self {
        case "I":
            return 1
        case "V":
            return 5
        case "X":
            return 10
        case "L":
            return 50
        case "C":
            return 100
        case "D":
            return 500
        case "M":
            return 1000
        default: return 0
        }
    }
}
