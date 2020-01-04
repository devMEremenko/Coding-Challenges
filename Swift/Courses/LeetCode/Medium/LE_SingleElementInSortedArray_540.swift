//
//  LE_SingleElementInSortedArray_540.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 05/07/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class LE_SingleElementInSortedArray_540: XCTestCase {
    
    func test() {
        XCTAssertEqual(singleNonDuplicate([1, 1, 5, 5, 2, 3, 3, 4, 4, 8, 8]), 2)
    }
    
    func test2() {
        XCTAssertEqual(singleNonDuplicate([1, 1, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 8]), 7)
    }
    
    func test3() {
        XCTAssertEqual(singleNonDuplicate([1, 1, 3, 4, 4]), 3)
    }
    
    func test4() {
        XCTAssertEqual(singleNonDuplicate([1, 1, 3, 4, 4, 5, 5, 6, 6, 8, 8]), 3)
    }
    
    func test5() {
        XCTAssertEqual(singleNonDuplicate([1, 4, 4, 5, 5, 6, 6]), 1)
    }
    
    func test6() {
        XCTAssertEqual(singleNonDuplicate([1]), 1)
    }
    
    func test7() {
        XCTAssertEqual(singleNonDuplicate([2, 2, 1]), 1)
    }
    
    func test8() {
        XCTAssertEqual(singleNonDuplicate([1, 2, 2]), 1)
    }
    
    func test9() {
        XCTAssertEqual(singleNonDuplicate([1, 1, 2, 2, 3]), 3)
    }
    
    func test10() {
        XCTAssertEqual(singleNonDuplicate([]), 0)
    }
    
    func test11() {
        XCTAssertEqual(singleNonDuplicate([3,3,7,7,10,11,11]), 10)
    }
    
    func test12() {
        XCTAssertEqual(singleNonDuplicate([1, 1, 2, 2, 3, 4, 4, 5, 5]), 3)
    }
}

extension LE_SingleElementInSortedArray_540 {
    
    func singleNonDuplicate(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        var left = 0
        var right = nums.count - 1
        
        while left < right {
            var mid = (left + right) / 2
            if mid % 2 == 1 {
                mid -= 1
            }
            if nums[mid] == nums[mid + 1] {
                left = mid + 2
            } else {
                right = mid
            }
        }
        
        return nums[left]
    }
}
