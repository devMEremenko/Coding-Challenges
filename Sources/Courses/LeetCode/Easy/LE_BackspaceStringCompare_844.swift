//
//  LE_BackspaceStringCompare_844.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 05/07/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class LE_BackspaceStringCompare_844: XCTestCase {
    
    /// Given two strings S and T, return if they are equal
    /// when both are typed into empty text editors.
    /// # means a backspace character.
    ///
    /// https://leetcode.com/problems/backspace-string-compare/
    
    func test1() {
        XCTAssertTrue(backspaceCompare("ab#c", "ad#c"))
    }
    
    func test2() {
        XCTAssertTrue(backspaceCompare("a##c", "#a#c"))
    }
    
    func test3() {
        XCTAssertTrue(backspaceCompare("#c", "b#c"))
    }
    
    func test4() {
        XCTAssertTrue(backspaceCompare("ab##", "c#d#"))
    }
    
    func test5() {
        XCTAssertFalse(backspaceCompare("a#c", "b"))
    }
    
    func test6() {
        XCTAssertFalse(backspaceCompare("bbbextm", "bbb#extm"))
    }
}

extension LE_BackspaceStringCompare_844 {
    
    func backspaceCompare(_ s1: String, _ s2: String) -> Bool {
        var left = s1.count - 1
        var right = s2.count - 1
        
        let indices1 = Array(s1.indices)
        let indices2 = Array(s2.indices)
        
        while true {
            s1.makeIndex(&left, indices1)
            s2.makeIndex(&right, indices2)
            
            if left < 0 && right < 0 {
                return true /// All characters are compared => strings are equal
            }
            
            if left < 0 || right < 0 {
                return false
            }
            
            if s1[indices1[left]] != s2[indices2[right]] {
                return false
            }
            left -= 1
            right -= 1
        }
    }
}

private extension String {
    
    func makeIndex(_ index: inout Int, _ indices: [String.Index]) {
        var skip = 0
        while index >= 0 {
            if self[indices[index]] == "#" {
                skip += 1
                index -= 1
                continue
            }
            if skip > 0 { /// skip items before '#'
                skip -= 1
                index -= 1
                continue
            }
            break /// character to compare is found
        }
    }
}
