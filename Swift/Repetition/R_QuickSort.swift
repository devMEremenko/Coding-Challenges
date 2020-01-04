//
//  R_QuickSort.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 02/07/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class R_QuickSort: XCTestCase {
    
    func test() {
        var array = [5, 3, 2, 1, 4]
        quickSort(&array)
        XCTAssertEqual(array, array.sorted(by: <))
    }
    
    func quickSort(_ array: inout [Int]) {
        _quickSort(&array, 0, array.count - 1)
    }
    
    func _quickSort(_ array: inout [Int], _ left: Int, _ right: Int) {
        guard left < right else { return }
        
        let pivot = array[(left + right) / 2]
        let newPivotIndex = partitioning(&array, pivot, left, right)
        _quickSort(&array, left, newPivotIndex - 1)
        _quickSort(&array, newPivotIndex, array.count - 1)
    }
    
    private func partitioning(_ array: inout [Int], _ pivot: Int, _ left: Int, _ right: Int) -> Int {
        
        var left = left
        var right = right
        
        while left <= right {
            while array[left] < pivot {
                left += 1
            }
            while array[right] > pivot {
                right -= 1
            }
            
            if left <= right {
                array.swapAt(left, right)
                left += 1
                right -= 1
            }
        }
        
        return left
    }
}
