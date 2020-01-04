//
//  GoldmanSachsInterviewTest.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 9/25/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class GoldmanSachsInterviewTest: XCTestCase {
    
}

extension GoldmanSachsInterviewTest {
    
    func testEasyTask1() {
        XCTAssert(differentTeams(skills: "pcmbz") == 1)
    }
    
    func testEasyTask2() {
        XCTAssert(differentTeams(skills: "pcmpp") == 0)
    }
    
    func testEasyTask3() {
        XCTAssert(differentTeams(skills: "pcmpcmbbbzz") == 2)
    }
    
    func differentTeams(skills: String) -> Int {
        var p = 0
        var c = 0
        var m = 0
        var b = 0
        var z = 0
        
        for letter in skills {
            switch letter {
                case "p": p += 1
                case "c": c += 1
                case "m": m += 1
                case "b": b += 1
                case "z": z += 1
                default: continue
            }
        }
        
        return min(p, min(c, min(m, min(b, z))))
    }
}

extension GoldmanSachsInterviewTest {
    
    func testMediumTask1() {
        let arr = [7, 9, 5, 6, 3, 2]
        
        XCTAssert(maxDifferenceOddEven(a: arr) == 1)
    }
    
    func testMediumTask2() {
        let arr = [2, 3, 10, 1, 4, 8, 1]
        
        XCTAssert(maxDifferenceOddEven(a: arr) == 7)
    }
    
    func testMediumTask3() {
        let arr = [1, 2, 3, 6, 4]
        
        XCTAssert(maxDifferenceOddEven(a: arr) == 5)
    }
    
    func maxDifferenceOddEven(a: [Int]) -> Int {
        guard a.count > 1 else { return 0 }
        
        var maxDiff = 0
        var minOdd: Int? = nil
        
        for idx in 0..<a.count {
            let item = a[idx]
            
            if item % 2 == 0 {
                if let minOddUnwrapped = minOdd {
                    maxDiff = max(maxDiff, item - minOddUnwrapped)
                }
            } else {
                if let minOddUnwrapped = minOdd {
                    minOdd = min(minOddUnwrapped, item)
                } else {
                    minOdd = item
                }
            }
        }
        
        return maxDiff
    }
}
