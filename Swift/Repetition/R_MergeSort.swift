//
//  R_MergeSort.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 02/07/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class R_MergeSort: XCTestCase {
    
    func test() {
        let original = [5, 3]
        let result = mergeSort(original)
        XCTAssertEqual(result, original.sorted())
    }
    
    func mergeSort(_ array: [Int]) -> [Int] {
        return Array(_mergeSort(array, 0, array.count - 1))
    }
    
    func _mergeSort(_ arr: [Int], _ left: Int, _ right: Int) -> [Int] {
        guard left < right else { return [arr[left]] }
        
        let mid = left + (right - left) / 2
        let arr1 = _mergeSort(arr, left, mid)
        let arr2 = _mergeSort(arr, mid + 1, right)
        return merge(arr1, arr2)
    }
    
    func merge(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
        var result = [Int]()
        result.reserveCapacity(arr1.count + arr2.count)
        
        var i = 0
        var j = 0
        
        while i < arr1.count && j < arr2.count {
            if arr1[i] < arr2[j] {
                result.append(arr1[i])
                i += 1
            } else {
                result.append(arr2[j])
                j += 1
            }
        }
        
        if i < arr1.count {
            result += arr1[i..<arr1.count]
        }
        
        if j < arr2.count {
            result += arr2[j..<arr2.count]
        }
        
        return result
    }
}
