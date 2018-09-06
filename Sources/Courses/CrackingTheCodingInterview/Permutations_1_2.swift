//
//  Permutation.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/3/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class PermutationTests: XCTestCase {
    
    func test() {
        
        XCTAssert(isPermutated("ABCD", "DCBA"))
        XCTAssert(isPermutated("ABAB", "BABA"))
        XCTAssert(isPermutated("", ""))
        XCTAssert(isPermutated("ABAB", "CABA") == false)
        XCTAssert(isPermutated("ABAB", "ABABA") == false)
    }
    
    func isPermutated(_ source1: String, _ source2: String) -> Bool {
        
        guard source1.count == source2.count else { return false }
        
        return source1.sorted() == source2.sorted()
    }
    
    /// TODO: implement it by counting
}

extension PermutationTests {
    
    func testPermutation() {
        permutation("ABC")
    }
    
    func permutation(_ source: String) {
        permutation(source, "")
    }
    
    /// TODO: Report a bug. Page 51
    func permutation(_ source: String, _ prefix: String) {
        
        guard source.count > 0 else {
            print(prefix)
            return
        }
        
        for idx in 1..<source.count {
            
            let offset = source.index(source.startIndex, offsetBy: idx)
            let rem = String(source[offset..<source.endIndex])
            
            permutation(rem, prefix + String(source[idx]))
        }
    }
}
