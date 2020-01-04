//
//  BMTwoOppositeSigns.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 01/04/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class BMTwoOppositeSignsTests: XCTestCase {
    
    /// Given two signed integers, write a function that returns true if the signs
    /// of given integers are different, otherwise false.
    ///
    /// The function should not use any of the arithmetic operators
    
    func test() {
        XCTAssertTrue(isSignDifferent(10, -20))
        XCTAssertTrue(isSignDifferent(-10, 20))
        
        XCTAssertFalse(isSignDifferent(10, 20))
        XCTAssertFalse(isSignDifferent(-10, -20))
    }
    
    func isSignDifferent(_ first: Int, _ second: Int) -> Bool {
        return (first ^ second) < 0
    }
    
    /// Another solution is right shifting by the 'number_of_signs_in_integer - 1'
}
