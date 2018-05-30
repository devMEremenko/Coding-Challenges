//
//  Fibonacci.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 5/29/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class FindFibonacciNumber: XCTestCase {
    
    func testFindFibonacci() {
        
        XCTAssert(fibonacci(for: 0) == 0)
        XCTAssert(fibonacci(for: 1) == 1)
        XCTAssert(fibonacci(for: 2) == 3)
        XCTAssert(fibonacci(for: 3) == 5)
        XCTAssert(fibonacci(for: 4) == 8)
        XCTAssert(fibonacci(for: 5) == 13)
        XCTAssert(fibonacci(for: 6) == 21)
        XCTAssert(fibonacci(for: 7) == 34)
        XCTAssert(fibonacci(for: 8) == 55)
        XCTAssert(fibonacci(for: 9) == 89)
        XCTAssert(fibonacci(for: 10) == 144)
        XCTAssert(fibonacci(for: 90) == 7_540_113_804_746_346_429)
    }
    
    func fibonacci(for number: Int) -> Int {
        
        guard number > 0 else { return 0 }
        guard number > 1 else { return 1 }
        
        var first = 0
        var second = 1
        var result = 0 /// The initial value does not matter
        
        /// i       0 1 2 3 4
        ///         ---------
        /// first   0 0 1 1 2
        /// second  - 1 1 2 3
        /// result  0 1 2 3 5
        
        for _ in 0...number {
            /// can overflow
            result = first + second
            first = second
            second = result
        }
        
        return result
    }
}
