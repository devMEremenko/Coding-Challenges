//
//  BMNumberOfBitsInDigit.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 01/04/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class BMNumberOfBitsInDigitTests: XCTestCase {
    
    /// Write an efficient program to count number of 1s in binary representation
    /// of an integer.
    ///
    /// You can assume that the number is not negative.
    ///
    /// Resources:
    /// https://www.geeksforgeeks.org/count-set-bits-in-an-integer/
    /// http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetTable
}

extension BMNumberOfBitsInDigitTests {
        
    func test_naive_isCorrect() {
        XCTAssertEqual(bitsCountNaive(1), 1)  /// 00..0001
        XCTAssertEqual(bitsCountNaive(2), 1)  /// 00..0010
        XCTAssertEqual(bitsCountNaive(3), 2)  /// 00..0011
        XCTAssertEqual(bitsCountNaive(0), 0)
        XCTAssertEqual(bitsCountNaive(12), 2) /// 00..1100
    }
    
    func bitsCountNaive(_ value: Int) -> Int {
        var count = 0
        var temp = value
        while temp != 0 {
            count += temp & 1
            temp >>= 1
        }
        return count
    }
}

extension BMNumberOfBitsInDigitTests {
    
    /// Brian Kernighan’s Algorithm
    ///
    /// - Initialize count: = 0
    /// - If integer n is not zero
    ///     (a) Do bitwise & with (n-1) and assign the value back to n
    ///         n: = n&(n-1)
    ///     (b) Increment count by 1
    ///     (c) go to step 2
    /// - Else return count
    ///
    /// Time: O(log n)
    /// Space: O(1)
    
    func test_bitsCountUsingBK() {
        XCTAssertEqual(bitsCountUsingBK(1), 1)  /// 00..0001
        XCTAssertEqual(bitsCountUsingBK(2), 1)  /// 00..0010
        XCTAssertEqual(bitsCountUsingBK(3), 2)  /// 00..0011
        XCTAssertEqual(bitsCountUsingBK(0), 0)
        XCTAssertEqual(bitsCountUsingBK(12), 2) /// 00..1100
    }
    
    func bitsCountUsingBK(_ value: Int) -> Int {
        var count = 0
        var temp = value
        while temp != 0 {
            temp &= (temp - 1)
            count += 1
        }
        return count
    }
}

extension BMNumberOfBitsInDigitTests {
    
    /// The 3rd options is to use lookup table
    /// https://www.geeksforgeeks.org/count-set-bits-integer-using-lookup-table/
    /// Time: O(1) access
}
