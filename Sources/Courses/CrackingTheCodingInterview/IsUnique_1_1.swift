//
//  IsUnique_1_1.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/6/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class IsUniqueTests: XCTestCase {
    
    func test() {
        
        XCTAssert(isUnique("ABC"))
        XCTAssert(isUnique("GDAREWQ"))
        XCTAssert(isUnique("ABCA") == false)
        XCTAssert(isUnique("ABCAABBQ") == false)
    }
    
    func isUnique(_ string: String) -> Bool {
        
        let chars = string.sorted()
        
        for idx in 0..<chars.count - 2 {
            if chars[idx] == chars[idx + 1] {
                return false
            }
        }
        
        return true
    }
    
    /// TODO: Implement this with a bit vector. Page 193
}
