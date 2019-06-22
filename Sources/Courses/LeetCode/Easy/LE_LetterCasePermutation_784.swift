//
//  LE_LetterCasePermutation_784.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 04/07/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class LE_LetterCasePermutation_784: XCTestCase {
    
    /// Given a string S, we can transform every letter individually
    /// to be lowercase or uppercase to create another string.
    /// Return a list of all possible strings we could create.
    ///
    /// Note:
    /// S will be a string with length between 1 and 12.
    /// S will consist only of letters or digits.
    ///
    /// https://leetcode.com/problems/letter-case-permutation/
}

extension LE_LetterCasePermutation_784 {
    
    func test() {
        let expected = ["a1b3k", "a1b3K", "a1B3k", "a1B3K",
                        "A1b3k", "A1b3K", "A1B3k", "A1B3K"]
        XCTAssertEqual(letterCasePermutation("a1b3K"), expected)
    }
}

extension LE_LetterCasePermutation_784 {
    
    /// Time: O(n^2)
    
    func letterCasePermutation(_ source: String) -> [String] {
        guard !source.isEmpty else { return [] }
        var set = [String]()
        
        for char in source {
            var newSet = [String]()
            for item in set {
                if char.isNumber {
                    newSet.append(item + char.uppercased())
                } else {
                    newSet.append(item + char.lowercased())
                    newSet.append(item + char.uppercased())
                }
            }
            if set.isEmpty {
                if char.isNumber {
                    newSet.append(char.uppercased())
                } else {
                    newSet.append(char.lowercased())
                    newSet.append(char.uppercased())
                }
            }
            set = newSet
        }
        return set
    }
}
