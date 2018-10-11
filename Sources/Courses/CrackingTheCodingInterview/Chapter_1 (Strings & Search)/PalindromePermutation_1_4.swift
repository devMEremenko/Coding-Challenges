//
//  PalindromePermutation_1_4.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/6/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class PalindromePermutationTests: XCTestCase {
    
    /// Given a string, write a function to check if it is a permutation of a palindrome.
    /// A palindrome is a word or phrase that is the same forwards and backwards.
    /// A permutation is a rearrangement of letters.
    /// The palindrome does not need to be limited to just dictionary words.
    ///
    /// EXAMPLE
    ///
    /// Input: Tact Coa
    /// Output: True (permutations: "taco cat". "atco cta". etc.)
}

extension PalindromePermutationTests {
    
    /// Time: O(n * log n)
    /// Space: O(1)
    
    func testUsingSorting() {
        
        XCTAssert(isPalindromePermutationUsingSorting("tact coa"))
        XCTAssert(isPalindromePermutationUsingSorting("Madam Im Adam"))
        XCTAssert(isPalindromePermutationUsingSorting("2 11"))
        XCTAssert(isPalindromePermutationUsingSorting("123") == false)
        XCTAssert(isPalindromePermutationUsingSorting("3 2 1") == false)
    }
    
    func isPalindromePermutationUsingSorting(_ source: String) -> Bool {
        let sorted = filter(source).sorted()
        return searchDiff(sorted)
    }
    
    private func filter(_ source: String) -> String {
        let set = CharacterSet.alphanumerics
        return source.components(separatedBy: set.inverted).joined().lowercased()
    }
    
    private func searchDiff(_ sorted: [Character]) -> Bool {
        
        var foundDiff = false
        var idx = 0
        
        while idx < sorted.count - 1 {
            
            if sorted[idx] == sorted[idx + 1] {
                idx += 1
            } else {
                if foundDiff {
                    return false
                }
                foundDiff = true
            }
            idx += 1
        }
        
        return true
    }
}

extension PalindromePermutationTests {
    
    /// Time: O(n)
    /// Space: O(n)
    
    func testUsingHashTable() {
        
        XCTAssert(isPalindromePermutationUsingHT("tact coa"))
        XCTAssert(isPalindromePermutationUsingHT("Madam Im Adam"))
        XCTAssert(isPalindromePermutationUsingHT("2 11"))
        XCTAssert(isPalindromePermutationUsingHT("123") == false)
        XCTAssert(isPalindromePermutationUsingHT("3 2 1") == false)
    }
    
    func isPalindromePermutationUsingHT(_ source: String) -> Bool {
        let input = filter(source)
        let map = createMap(input)
        return checkDiff(input, map)
    }
    
    private func createMap(_ source: String) -> [Character: Int] {
        
        var map = [Character: Int]()
        
        for item in source {
            
            if let number = map[item] {
                map[item] = number + 1
            } else {
                map[item] = 1
            }
        }
        
        return map
    }
    
    private func checkDiff(_ source: String, _ map: [Character: Int]) -> Bool {
        
        var diff = 0
        
        for item in source {
            
            if let number = map[item], number % 2 != 0 {
                diff += 1
                if diff >= 2 { return false }
            }
        }
        
        return true
    }
}

extension PalindromePermutationTests {
    
    /// Time: O(n)
    /// Space: O(1)
    
    /// TODO: Implement this using a bit vector
    
    /// If you think more deeply about this problem, you might notice
    /// that we don't actually need to know the counts. We just need to know
    /// if the count is even or odd.
    ///
    /// Think about flipping a light on/off (that is initially off).
    /// If the light winds up in the off state, we don't know how many times
    /// we flipped it, but we do know it was an even count.
    ///
    /// Page 197
    
    /// func isPalindromePermutationUsingBitSet(_ source: String) -> Bool {
    ///
    /// }
}
