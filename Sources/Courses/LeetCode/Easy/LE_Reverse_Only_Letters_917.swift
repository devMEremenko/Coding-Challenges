//
//  LE_Reverse_Only_Letters_917.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 03/02/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class LE_Reverse_Only_Letters_917: XCTestCase {
    
    /// Given a string S, return the "reversed" string where all characters
    /// that are not a letter stay in the same place, and all letters reverse
    /// their positions.
    ///
    /// https://leetcode.com/problems/reverse-only-letters/
    
    func test() {
        XCTAssertEqual(reverseOnlyLetters_v1("tNH95P=TV"), "VTP95H=Nt")
        XCTAssertEqual(reverseOnlyLetters_v2("tNH95P=TV"), "VTP95H=Nt")
        
        XCTAssertEqual(reverseOnlyLetters_v1(""), "")
        XCTAssertEqual(reverseOnlyLetters_v2(""), "")
    }
}

extension LE_Reverse_Only_Letters_917 {
    
    /// Time: O(n)
    /// Space: (n) - because the characters swapping is not in place
    
    func reverseOnlyLetters_v1(_ s: String) -> String {
        
        let set = CharacterSet.letters
        var chars = Array(s.indices)
        var left = 0
        var right = chars.count - 1
        
        for _ in (0..<s.count) {
            guard left < right else { break }
            guard set.contains(char: s[chars[left]]) else { left += 1; continue }
            guard set.contains(char: s[chars[right]]) else { right -= 1; continue }
            
            let temp = chars[left]
            chars[left] = chars[right]
            chars[right] = temp
            
            left += 1
            right -= 1
        }
        
        return String(chars.map { s[$0] })
    }
    
    /// Time: O(n)
    /// Space: (n) - because the new result string is created
    
    func reverseOnlyLetters_v2(_ s: String) -> String {
        
        let set = CharacterSet.letters
        let indices = Array(s.indices)
        var result = ""
        result.reserveCapacity(indices.count)
        var right = indices.count - 1
        
        for left in (0..<s.count) {
            if set.contains(char: s[indices[left]]) {
                while !set.contains(char: s[indices[right]]) {
                    right -= 1
                }
                result.append(s[indices[right]])
                right -= 1
            } else {
                result.append(s[indices[left]])
            }
        }
        return result
    }
}
