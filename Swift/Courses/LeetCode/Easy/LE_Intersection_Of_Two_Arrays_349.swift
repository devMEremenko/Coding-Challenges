//
//  LE_Intersection_Of_Two_Arrays_349.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 04/02/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class LE_Intersection_Of_Two_Arrays_349: XCTestCase {
    
    /// Given two arrays, write a function to compute their intersection.
    ///
    /// https://leetcode.com/problems/intersection-of-two-arrays/
    
    func test() {
        let result = intersection([1, 2, 2, 4, 1, 5], [2, 4, 2, 3])
        /// Note: The set is used to prevent the comparison by the order
        XCTAssertEqual(Set(result), Set([2, 4]))
    }
    
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let minArray = nums1.count < nums2.count ? nums1 : nums2
        let maxArray = nums1.count < nums2.count ? nums2 : nums1
        return Array(Set(minArray).intersection(maxArray))
    }
}
