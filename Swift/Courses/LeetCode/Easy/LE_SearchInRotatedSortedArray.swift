//
//  LE_SearchInRotatedSortedArray.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 11/07/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class LE_SearchInRotatedSortedArray: XCTestCase {
    
    /// Suppose an array sorted in ascending order is rotated
    /// at some pivot unknown to you beforehand.
    ///
    /// (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).
    ///
    /// You are given a target value to search.
    /// If found in the array return its index, otherwise return -1.
    ///
    /// You may assume no duplicate exists in the array.
    /// Your algorithm's runtime complexity must be in the order of O(log n).
    ///
    /// https://leetcode.com/problems/search-in-rotated-sorted-array/
    
    func test1() {
        XCTAssertEqual(search([5, 6, 7, 1, 3], 1), 3)
    }
    
    func test2() {
        XCTAssertEqual(search([4, 5, 6, 7, 0, 1, 2], 3), -1)
    }
    
    func test3() {
        XCTAssertEqual(search([5, 1, 3], 1), 1)
    }
    
    func test4() {
        XCTAssertEqual(search([5, 1, 3], 5), 0)
    }
    
    func test5() {
        /// TODO: XCTAssertEqual(search([1, 3], 3), 1)
    }
    
    func test6() {
        XCTAssertEqual(search([1, 3], 1), 0)
    }
    
    func test7() {
        XCTAssertEqual(search([1, 3], 5), -1)
    }
    
    func test8() {
        XCTAssertEqual(search([3, 1], 3), 0)
    }
    
    func test9() {
        XCTAssertEqual(search([3, 1], 1), 1)
    }
    
    func test10() {
        XCTAssertEqual(search([3, 1], 5), -1)
    }
}

extension LE_SearchInRotatedSortedArray {
    
    /// Time: O(log n)
    /// Space: O(1)
    
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard !nums.isEmpty else { return -1 }
        
        var left = 0
        var right = nums.count - 1
        
        while left < right {
            let mid = (right + left) / 2
            
            if target == nums[mid] {
                return mid
            }
            
            if target >= nums[left] {
                right = mid
            } else { /// target <= nums[right] && target > nums[mid]
                left = mid + 1
            }
        }
        return nums[left] == target ? left : -1
    }
}
