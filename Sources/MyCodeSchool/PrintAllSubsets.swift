//
//  PrintAllSubsets.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/26/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class PrintAllSubsets: XCTestCase {
    
    func test() {
        printAllSubsets([1, 2, 3, 4], depth: 3)
    }
    
    func printAllSubsets(_ orig: [Int], depth: Int) {
        var subset: [Int?] = Array(repeating: nil, count: depth)
        
        helper(orig, &subset, 0, 0, depth)
    }
    
    func helper(_ orig: [Int],
                _ subset: inout [Int?],
                _ start: Int,
                _ index: Int,
                _ depth: Int) {
        
        guard index != depth else {
            print(subset as! Array<Int> as Any)
            print()
            return
        }
        
        for var i in start..<orig.count { /// && (orig.count - i + 1 >= depth - index)
            subset[index] = orig[i]
            
            helper(orig, &subset, i + 1, index + 1, depth)
            
            i += 1
        }
    }
}
