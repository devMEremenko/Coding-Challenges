//
//  IsFibonacciNumber.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 5/30/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class IsFibonacciNumber: XCTestCase {
    
    func testIsFibonacciNumber() {
        
        XCTAssert(isFibonacci(number: 0))
        XCTAssert(isFibonacci(number: 1))
        XCTAssert(isFibonacci(number: 2))
        XCTAssert(isFibonacci(number: 3))
        XCTAssert(isFibonacci(number: 4) == false)
        XCTAssert(isFibonacci(number: 5))
        XCTAssert(isFibonacci(number: 6) == false)
        XCTAssert(isFibonacci(number: 7) == false)
        XCTAssert(isFibonacci(number: 8))
        XCTAssert(isFibonacci(number: 13))
        XCTAssert(isFibonacci(number: 21))
        XCTAssert(isFibonacci(number: 34))
        XCTAssert(isFibonacci(number: 55))
        XCTAssert(isFibonacci(number: 88) == false)
        XCTAssert(isFibonacci(number: 89))
    }
    
    /// The function checks whether a given number is a Fibonacci number or not.
    ///
    /// It uses a formula (5 * n ^ 2 +- 4)
    /// to check whether a given number is a perfect square.
    ///
    /// If yes, it's a Fibonacci number.
    ///
    /// Time:  O(1)
    /// Space: O(1)
    
    func isFibonacci(number: Int) -> Bool {
        
        guard number >= 0 else { return false }
        
        let formula = 5 * number * number // +- 4
        
        return isPerfectSquare(formula + 4) ||
               isPerfectSquare(formula - 4)
    }
    
    func isPerfectSquare(_ number: Int) -> Bool {
        /// Note, we have to cast a result of sqrt to Int
        let square = Int(sqrtf(Float(number)))
        return square * square == number
    }
}
