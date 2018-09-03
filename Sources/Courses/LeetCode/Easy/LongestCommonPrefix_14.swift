//
//  LongestCommonPrefix_14.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/18/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class LongestCommonPrefix_14: XCTestCase {
    
    /*
     https://leetcode.com/problems/longest-common-prefix/description/
     
     Write a function to find the longest common prefix string amongst an array of strings.
     If there is no common prefix, return an empty string "".
     
     ---------Example---------
     Input: ["flower","flow","flight"]
     Output: "fl"
     
     Input: ["dog","racecar","car"]
     Output: ""
     Explanation: There is no common prefix among the input strings.
     
     All given inputs are in lowercase letters a-z.
     
     ---------Solution---------
     Use a first word as a template prefix and iterate through the given array.
     If a word-prefix does not match to the given template - remove one character and compare again.
    */
    
    func testLongestCommonPrefix() {
        
        XCTAssert(longestCommonPrefix(["flower","flow","flight"]) == "fl")
        XCTAssert(longestCommonPrefix(["dog","racecar","car"]) == "")
        XCTAssert(longestCommonPrefix(["flower","flow","floght"]) == "flo")
        XCTAssert(longestCommonPrefix(["","flow","floght"]) == "")
        XCTAssert(longestCommonPrefix(["flow","flow","flow"]) == "flow")
        XCTAssert(longestCommonPrefix(["aa","a"]) == "a")
        XCTAssert(longestCommonPrefix(["aacc","aa","aa","aa","aaca"]) == "aa")
    }
    
    func longestCommonPrefix(_ strs: [String]) -> String {
        
        guard strs.count > 0 else { return "" }
        
        var template = strs[0]
        
        for word in strs {
            
            while !word.hasPrefix(template) {
                template.remove(at: template.index(before: template.endIndex))
            }
            
            if template.isEmpty { break }
        }
        
        return template
    }
}
