//
//  Permutation.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/3/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class PermutationTests: XCTestCase {
    
    func testPermutation() {
        permutation("ABC")
    }
    
    func permutation(_ source: String) {
        permutation(source, "")
    }
    
    /// TODO: complete the solution. Page 51
    func permutation(_ source: String, _ prefix: String) {
        
        guard source.count > 0 else {
            print(prefix)
            return
        }
        
        for idx in 0..<source.count - 1 {
            
            let offset = source.index(source.startIndex, offsetBy: idx)
            let rem = String(source[source.startIndex..<offset]) + String(source[idx + 1])
            
            permutation(rem, prefix + String(source[idx]))
        }
    }
}
