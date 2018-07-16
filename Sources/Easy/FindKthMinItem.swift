//
//  FindKthMinItem.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/16/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class FindKthMinItemTest: XCTestCase {
    
    func testSimple() {
        
        var values = [4, 1, 3, 5, 2]
        
        ///       4
        ///      / \
        ///     2   3
        ///    /
        ///   1
        
        XCTAssert(findKthMinItem(&values, 4) == 4)
    }
    
    func testComplex() {
        
        var values = [4, 8, 6, 29, 1, 689, 9, 4, 1, 1, 35, 3, 3, 3, 1, 9, 20]
        
        XCTAssert(findKthMinItem(&values, 1) == 1)
        XCTAssert(findKthMinItem(&values, 2) == 1)
        XCTAssert(findKthMinItem(&values, 3) == 1)
        XCTAssert(findKthMinItem(&values, 4) == 1)
        XCTAssert(findKthMinItem(&values, 5) == 3)
        XCTAssert(findKthMinItem(&values, 6) == 3)
        XCTAssert(findKthMinItem(&values, 7) == 3)
        XCTAssert(findKthMinItem(&values, 8) == 4)
        XCTAssert(findKthMinItem(&values, 9) == 4)
        XCTAssert(findKthMinItem(&values, 10) == 6)
    }
    
    /// Complexity: O(k + (n-k) * log(k))
    
    func findKthMinItem(_ arr: inout [Int], _ k: Int) -> Int? {
        
        guard k > 0 else { return nil }
        guard arr.count >= k else { return nil }
        
        /// Build a max heap
        for parentIdx in stride(from: arr.count / 2 - 1, through: 0, by: -1) {
            shiftDown(&arr, from: parentIdx, k)
        }
        
        /// If an item (in a range k..<count) is smaller than root
        /// set it as a root and heapify()
        
        for idx in k..<arr.count {
            if arr[idx] < arr[0] {
                arr.swapAt(0, idx)
                shiftDown(&arr, from: 0, k)
            }
        }
        
        return arr.first
    }
    
    func shiftDown(_ arr: inout [Int], from idx: Int, _ toIdx: Int? = nil) {
        
        var parentIndex = idx
        let toIdx = toIdx ?? arr.count - 1
        
        while hasLeftChild(parentIndex, toIdx) {
            
            var maxIndex = leftChildIndex(parentIndex)
            
            if arr[leftChildIndex(parentIndex)] > arr[parentIndex] {
                maxIndex = leftChildIndex(parentIndex)
            }
            
            if hasRightChild(parentIndex, toIdx) {
                if arr[rightChildIndex(parentIndex)] > arr[maxIndex] {
                    maxIndex = rightChildIndex(parentIndex)
                }
            }
            
            if arr[parentIndex] > arr[maxIndex] {
                break
            } else {
                arr.swapAt(parentIndex, maxIndex)
            }
            
            parentIndex = maxIndex
        }
    }
    
    @inline(__always) func hasLeftChild(_ parentIndex: Int, _ arrCount: Int) -> Bool {
        return leftChildIndex(parentIndex) < arrCount
    }
    
    @inline(__always) func hasRightChild(_ parentIndex: Int, _ arrCount: Int) -> Bool {
        return rightChildIndex(parentIndex) < arrCount
    }
    
    @inline(__always) func leftChildIndex(_ parentIndex: Int) -> Int {
        return (2 * parentIndex) + 1
    }
    
    @inline(__always) func rightChildIndex(_ parentIndex: Int) -> Int {
        return (2 * parentIndex) + 2
    }
}
