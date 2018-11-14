//
//  Counting.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 7/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class CountingSortExample: XCTestCase {
    
    func test() {
        
        let values = [3, -2, 1, 3, 1, -6, 1, -10, 3, 6, 2, 5, -6, 1, 0, 1, -4, 6, 10]
        
        XCTAssert(countingSort(values) == values.sorted())
    }
    
    func countingSort(_ arr: [Int]) -> [Int] {
        
        /// Calculate a number of buckets in a range: min...max
        let max = arr.max() ?? 0
        let min = arr.min() ?? 0
        let count = max - min + 1
        
        var countArray = [Int](repeating: 0, count: count)
        for element in arr {
            /// Increase a bucket that represents a respective number
            countArray[element - min] += 1
        }
        
        for index in 1 ..< countArray.count {
            /// Set a number of values in the current and previous buckets.
            /// It is useful when repeated items occur.
            countArray[index] += countArray[index - 1]
        }
        
        /// `Count array` now can help with mapping an item to the required position.
        var sortedArray = [Int](repeating: 0, count: arr.count)
        for item in arr {
            /// Two reasons to decrease a value by 1
            /// - any array's index starts from 0. values(indexes) in `count array`
            ///   starts from 1.
            /// - if there are duplicates, each of them should not be placed
            ///   in the same position twice.
            countArray[item - min] -= 1
            sortedArray[countArray[item - min]] = item
        }
        
        return sortedArray
    }
}
