//
//  Big(O).swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 9/3/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class BigOTests: XCTestCase {
    
    func testSqrt() {
        XCTAssert(findSqrt(16) == 4)
        XCTAssert(findSqrt(25) == 5)
        XCTAssert(findSqrt(23) == -1)
    }
    
    /// Time: O(log n)
    func findSqrt(_ n: Int) -> Int {
        return _findSqrt(n, 1, n)
    }
    
    func _findSqrt(_ n: Int, _ min: Int, _ max: Int) -> Int {
        guard max >= min else { return -1 }
        
        let guess = (min + max) / 2
        let factor = guess * guess
        
        if factor == n {
            return guess
        } else if factor < n {
            return _findSqrt(n, guess + 1, max)
        } else {
            return _findSqrt(n, min, guess - 1)
        }
    }
}
