//
//  DP_MakeChange_1.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class DP_MakeChange_1: XCTestCase {
    
    /// Given an integer representing a specific amount of change
    /// and a set of coin sizes.
    ///
    /// Determine the minimum number of coins required to make that
    /// amount of change.
    ///
    /// You may assume there is always 1 cent coin.
    
    /// Top Down
    func testChangeTopDown_120() {
        
        XCTAssert(changeTopDown([10, 6, 1, 4, 5], 120) == 12)
    }
    
    func testChangeTopDown_2() {
        
        XCTAssert(changeTopDown([10, 6, 1], 12) == 2)
    }
    
    /// Bottom Up
    func testChangeBottomUp_120() {
        
        XCTAssert(changeBottomUp([10, 6, 1, 4, 5], 120) == 12)
    }
    
    func testChangeBottomUp_2() {
        
        XCTAssert(changeBottomUp([10, 6, 1], 12) == 2)
    }
}

extension DP_MakeChange_1 {
    
    func changeBottomUp(_ set: [Int], _ target: Int) -> Int {
        
        var computations = Array(repeating: 0, count: target + 1)

        for idx in 1...target {
            
            var minCoins = Int.max
            
            for coin in set {
                if idx - coin >= 0 {
                    minCoins = min(minCoins, computations[idx - coin])
                }
            }
            computations[idx] = minCoins + 1
        }
        
        return computations[target]
    }
}

extension DP_MakeChange_1 {
    
    func changeTopDown(_ set: [Int], _ target: Int) -> Int {
        
        var computations = Array(repeating: 0, count: target + 1)
        
        return changeTopDownHelper(set, target, &computations)
    }
    
    func changeTopDownHelper(_ set: [Int], _ target: Int, _ computations: inout [Int]) -> Int {
        
        guard target > 0 else { return 0 }
        guard computations[target] == 0 else { return computations[target] }
        
        var minCoins = Int.max
        
        for coin in set {
            let nextTarget = target - coin
            if nextTarget >= 0 {
                let result = changeTopDownHelper(set, nextTarget, &computations)
                minCoins = min(minCoins, result)
            }
        }
        
        computations[target] = minCoins + 1
        return computations[target]
    }
}

/*
 Top Down. Recursion Stack.
 
 ------------------ Brute Force Solution ------------------
 
 1                    6                   10
 1      6      10     1      6      10     1      6      10
 1 6 10 1 6 10 1 6 10 1 6 10 1 6 10 1 6 10 1 6 10 1 6 10 1 6 10
 
 
 
 ------------------ DP Solution ------------------
 
                            12
 change(10)             change(6)                change(1)
 change(1)      change(6)   change(1)    change(10)  change(6)    change(1)
 change(1)                  change(1)    change(1)   change(1)    change(1)
                            change(1)                change(1)    change(1)
                            change(1)                change(1)    change(1)
                            change(1)                change(1)    change(1)
                            change(1)                change(1)    change(1)
                                                                  change(1)
                                                                  change(1)
                                                                  change(1)
                                                                  change(1)
                                                                  change(1)
                                                                  change(1)
                                                                  change(1)
                            12
 2                          6                         11
 1                       0    5                 1     7       10
 0                            4                 0     6  1   0  4  9
                              3                       0            8 3
                                                                   7   2
                                                                   6    1
                                                                   0     0
 */
