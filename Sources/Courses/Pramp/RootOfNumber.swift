//
//  RootOfNumber.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 10/13/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class RootOfNumberTests: XCTestCase {
    
    /// Implement a function root that calculates the n’th root of a number.
    /// The function takes a nonnegative number x and a positive integer n,
    /// and returns the positive n’th root of x within an error of 0.001
    ///
    /// Suppose the real root is y, then the error is:
    /// |y-root(x,n)|
    ///
    /// and must satisfy:
    /// |y-root(x,n)| < 0.001)
    ///
    /// input:  x = 7, n = 3
    /// output: 1.913
    ///
    /// input:  x = 9, n = 2
    /// output: 3
    
    func test1() {
        verify(root(x: 16, n: 4), expected: 2.0)
    }
    
    func test2() {
        verify(root(x: 3, n: 2), expected: 1.732)
    }
    
    func test3() {
        verify(root(x: 4, n: 2), expected: 2.0)
    }
    
    func test4() {
        verify(root(x: 10, n: 3), expected: 2.154)
    }
    
    func test5() {
        verify(root(x: 27, n: 3), expected: 3.0)
    }
    
    func test6() {
        verify(root(x: 160, n: 3), expected: 5.429)
    }
    
    func verify(_ result: Double, expected: Double) {
        XCTAssert(result > expected - 0.001)
        XCTAssert(result < expected + 0.001)
    }
}

extension RootOfNumberTests {
    
    /// Time: O(log n)
    /// Space: 1
    
    func root(x: Double, n: Double) -> Double {
        guard x != 0 else { return 0 }
        guard n != 1 else { return x }
        
        var lower = 0.0
        var upper = max(1.0, x)
        var approx = (lower + upper) / 2.0
        
        while approx - lower >= 0.001 {
            
            let guess = pow(approx, n)
            if guess > x {
                upper = approx
            } else if guess < x {
                lower = approx
            } else {
                break
            }
            approx = (upper + lower) / 2.0
        }
        return approx
    }
}
