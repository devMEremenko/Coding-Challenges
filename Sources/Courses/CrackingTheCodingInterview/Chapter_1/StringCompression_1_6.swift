//
//  StringCompression_1_6.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class StringCompressionTests: XCTestCase {
    
    /// String Compression
    ///
    /// Implement a method to perform basic string compression using
    /// the counts of repeated characters.
    ///
    /// For example, the string aabcccccaaa would become a2b1c5a3.
    ///
    /// If the "compressed" string would not become smaller than the original string,
    /// your method should return the original string.
    ///
    /// You can assume the string has only uppercase and lowercase letters (a - z).
    
    func testCompression() {
        
        XCTAssert(compression("abbccc") == "abbccc")
        XCTAssert(compression("abbcccdddd") == "a1b2c3d4")
        XCTAssert(compression("abaabcccddddd") == "a1b1a2b1c3d5")
    }
}

extension StringCompressionTests {
    
    /// Time: O(n)
    /// Space: O(n)
    
    func compression(_ source: String) -> String {
        
        guard source.count > 1 else { return source }
        
        var occurrences = 1
        var result = ""
        
        for current in 1..<source.count {
            
            if source[current - 1] == source[current] {
                occurrences += 1
            } else {
                result.append(source[current - 1])
                result.append(String(occurrences))
                occurrences = 1
            }
        }
        
        if occurrences > 1 {
            result.append(source.last!)
            result.append(String(occurrences))
        }
        
        return result.count < source.count ? result : source
    }
}
