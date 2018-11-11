//
//  CoursTests.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 03/01/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class CourseraInterviewTest: XCTestCase {
    
    func test() {
        
        let input = makeInput()
        
        let result = mystery(letter: input.source)
        
        XCTAssertEqual(result, input.expected)
    }
}

extension CourseraInterviewTest {
    
    /// Time: O(n)
    /// Space: O(1)
    
    func mystery(letter: [String]) -> [Int] {
        var results = [Int](repeating: 0, count: letter.count)
        for (idx, item) in letter.enumerated() {
            results[idx] = numberOfOperations(item)
        }
        return results
    }
    
    func numberOfOperations(_ word: String) -> Int {
        var count = 0
        
        for (prefix, suffix) in word.bidirectional {
            let prefixValue = prefix.unicodeValue
            let suffixValue = suffix.unicodeValue
            count += max(prefixValue, suffixValue) - min(prefixValue, suffixValue)
        }
        
        return count
    }
}

extension CourseraInterviewTest {
    
    typealias Input = (source: [String], expected: [Int])
    
    private func makeInput() -> Input {
        let source = ["a", "abc", "adai", "aaaaaaaaaaaa", "", "aaaaaaaaaaaab"]
        let expected = [0, 2, 11, 0, 0, 1]
        return (source, expected)
    }
}
