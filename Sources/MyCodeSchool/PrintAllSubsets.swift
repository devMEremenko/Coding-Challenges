//
//  PrintAllSubsets.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/26/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class PrintAllSubsets: XCTestCase {
    
    func testAllCombination() {
        printAllCombinations("AB")
        /// A AA AB
        /// B BB BA
    }
    
    /// Time: O(string.count ^ string.count)
    func printAllCombinations(_ source: String) {
        printAllCombinationsHelper(source, "", source.count)
    }
    
    func printAllCombinationsHelper(_ source: String, _ prefix: String, _ remaining: Int) {
        
        /// Note: it is commented to speed up the test runtime
        /// print(prefix)
        
        guard remaining > 0 else { return }
        
        for item in source {
            printAllCombinationsHelper(source, prefix + String(item), remaining - 1)
        }
    }
}
