//
//  URLify_1_3.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 9/6/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class URLifyTests: XCTestCase {
    
    /// Write a method to replace all spaces in a string with '%20'.
    ///
    /// You may assume that the string has sufficient space at the end
    /// to hold the additional characters, and that you are given the "true" length
    /// of the string.
    ///
    /// Note: Please perform this operation in place
    ///
    /// Example
    ///
    /// Input:  "Mr John Smith "
    ///
    /// Output: "Mr%20John%20Smith"
    
    func testUrlify() {
        
        var input = "Mr Max  "
        
        urlify(&input, 6)
        
        XCTAssert(input == "Mr%20Max")
    }
    
    func testUrlifyEmpty() {
        
        var input = ""
        
        urlify(&input, 0)
        
        XCTAssert(input == "")
    }
    
    func testUrlifyWithAllSpaces() {
        
        var input = "      "
        
        urlify(&input, 2)
        
        XCTAssert(input == "%20%20")
    }
    
    func urlify(_ source: inout String, _ trueLength: Int) {
        
        var lastEditIndex = source.count - 1
        
        for idx in stride(from: trueLength - 1, through: 0, by: -1) {
            
            if source[idx] != " " {
                source[lastEditIndex] = source[idx]
                lastEditIndex -= 1
            } else {
                source[lastEditIndex - 2 ..< lastEditIndex + 1] = "%20"
                lastEditIndex -= 3
            }
        }
    }
}
