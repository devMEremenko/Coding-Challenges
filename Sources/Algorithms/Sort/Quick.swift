//
//  Quick.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/1/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class QuickSortExample: XCTestCase {
    
    func testQuickSort() {
        
        let original = [8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1, 26]
        var sorted = original
        
        quickSort(&sorted, 0, sorted.count - 1)
        
        XCTAssert(sorted == original.sorted())
    }
    
    func testDutchQuickSort() {
        
        let original = [8, 8, 3, 3, 8, 3, 3, 3, 1, 3, 8, -1, 3]
        var sorted = original
        
        dutchQuickSort(&sorted, 0, sorted.count - 1)
        
        XCTAssert(sorted == original.sorted())
    }
    
    func quickSort(_ arr: inout [Int], _ left: Int, _ right: Int) {
        guard left < right else { return }
        
        let pivot = arr[(left + right) / 2]
        let index = partition(&arr, left, right, pivot)
        
        quickSort(&arr, left, index - 1)
        quickSort(&arr, index, right)
    }
    
    func partition(_ arr: inout [Int], _ left: Int, _ right: Int, _ pivot: Int) -> Int {
        var left = left
        var right = right
        
        while left <= right {
            
            while arr[left] < pivot { left += 1}
            while arr[right] > pivot { right -= 1}
            
            if left <= right {
                arr.swapAt(left, right)
                left += 1
                right -= 1
            }
        }
        return left
    }
    
    /// Dutch national flag partitioning
    func dutchQuickSort(_ arr: inout [Int], _ left: Int, _ right: Int) {
        guard left < right else { return }
        
        let indices = dutchPartition(&arr, left, right)
        dutchQuickSort(&arr, left, indices.0 - 1)
        dutchQuickSort(&arr, indices.1 + 1, right)
    }
    
    func dutchPartition(_ arr: inout [Int], _ left: Int, _ right: Int) -> (Int, Int) {
        
        let pivot = arr[left + (right - left) / 2]
        
        var small = left
        var equal = left
        var large = right
        
        while equal <= right {
            
            if arr[equal] < pivot {
                arr.swapAt(small, equal)
                small += 1
                equal += 1
            } else if arr[equal] == pivot {
                equal += 1
            } else {
                arr.swapAt(equal, large)
                large -= 1
            }
        }
        
        return (small, large)
    }
}
