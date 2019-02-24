//
//  LE_Jewels_And_Stones_771.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 04/02/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class LE_Jewels_And_Stones_771: XCTestCase {
    
    /// You're given strings J representing the types of stones that are jewels,
    /// and S representing the stones you have. Each character in S is a type of
    /// stone you have. You want to know how many of the stones you have are also
    /// jewels.
    ///
    /// The letters in J are guaranteed distinct, and all characters in J and S
    /// are letters. Letters are case sensitive, so "a" is considered a different
    /// type of stone from "A".
    ///
    /// https://leetcode.com/problems/jewels-and-stones/
    
    func test() {
        XCTAssertEqual(numJewelsInStones("aFAo", "aAoAbfbObob"), 5)
    }
    
    func numJewelsInStones(_ j: String, _ s: String) -> Int {
        var count = 0
        let map = Set(j)
        s.forEach {
            if map.contains($0) {
                count += 1
            }
        }
        return count
    }
}
