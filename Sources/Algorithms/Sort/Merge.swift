//
//  Merge.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 7/4/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class MergeSortExample: XCTestCase {
    
    func testMerging() {
        
        let first = [1, 3, 5, 6, 7, 8, 9, 9, 9, 9, 9]
        let second = [2, 4, 6, 7, 8, 8, 8, 8, 9, 9]
        
        XCTAssert(merge(first, second) == (first + second).sorted())
    }
    
    func testMergeSort() {
        
        let arr = [8, 3, 2, 6, 8, 2, 6, 1, 6, 2, 6, 1]
        
        XCTAssert(mergeSort(arr, 0, arr.count - 1) == arr.sorted())
    }
}

extension MergeSortExample {
    
    func mergeSort(_ arr: [Int], _ left: Int, _ right: Int) -> [Int] {
        guard left < right else { return [arr[left]] }
        
        let mid = left + (right - left) / 2
        let arr1 = mergeSort(arr, left, mid)
        let arr2 = mergeSort(arr, mid + 1, right)
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
        
        if i == arr1.count {
            result += arr2[j..<arr2.endIndex]
        }
        
        if j == arr2.count {
            result += arr1[i..<arr1.endIndex]
        }
        
        return result
    }
}
