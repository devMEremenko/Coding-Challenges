//
//  RI_MoveZerosToRight.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 15/08/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

/// [1, 2, 3, 0, 0, 5]
/// [2, 3, 5, 0, 0, 0]
/// [1, 2, 0, 3, 0, 5]
/// [2, 3, 5, 0, 0, 0]

class RI_MoveZerosToRight: XCTestCase {
    
    /// Given an array of integers.
    /// Move all zeros to right while keeping the order of other items
    ///
    /// Source: [0, 1, 2, 0, 3, 0, 5]
    /// Result: [1, 2, 3, 5, 0, 0, 0]
}

extension RI_MoveZerosToRight {
    
    func test_solution1() {
        XCTAssertEqual(solution1([0, 1, 2, 0, 3, 0, 5]), [1, 2, 3, 5, 0, 0, 0])
        XCTAssertEqual(solution1([1, 2, 3, 5]), [1, 2, 3, 5])
        XCTAssertEqual(solution1([1, 0, 3, 5]), [1, 3, 5, 0])
        XCTAssertEqual(solution1([]), [])
    }
    
    func test_solution2_1() {
        var source = [0, 1, 2, 0, 3, 0, 5]
        solution2(&source)
        XCTAssertEqual(source, [1, 2, 3, 5, 0, 0, 0])
    }
    
    func test_solution2_2() {
        var source = [1, 0, 3, 5]
        solution2(&source)
        XCTAssertEqual(source, [1, 3, 5, 0])
    }
    
    func test_solution2_3() {
        var source = [1, 2, 3, 5]
        solution2(&source)
        XCTAssertEqual(source, [1, 2, 3, 5])
    }
    
    func test_solution2_4() {
        var source = [Int]()
        solution2(&source)
        XCTAssertEqual(source, [])
    }
}

extension RI_MoveZerosToRight {
    
    /// Time: O(n)
    /// Space: O(1)
    
    func solution2(_ source: inout [Int]) {
        var left = 0
        
        for (index, item) in source.enumerated() {
            if item != 0 {
                source[index] = 0
                source[left] = item
                left += 1
            }
        }
    }
}

extension RI_MoveZerosToRight {
    
    /// Time: O(n)
    /// Space: O(n)

    func solution1(_ source: [Int]) -> [Int] {
        
        var left = 0
        var right = source.count - 1
        
        var result = Array(repeating: 0, count: source.count)
        for item in source {
            if item == 0 {
                right -= 1
            } else {
                result[left] = item
                left += 1
            }
        }
        return result
    }
}
