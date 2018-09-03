//
//  HeapSort.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/13/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class HeapSortExample: XCTestCase {
    
    var values: [Int] {
        return [1, 5, 2, 5, 8, 3, 9, 1, 104, 0, 1, 4, 70, 41, 94, 3, 4, 28, 1, 7, 3, 2, 1, 3, 4, 5, 1]
    }
}

extension HeapSortExample {
    
    func testHeapSort() {
        
        var toSort = values
        
        heapSort(&toSort)
        
        XCTAssert(toSort == values.sorted())
    }
    
    func heapSort(_ arr: inout [Int]) {
        
        guard arr.count > 1 else { return }
        
        /// Create a max heap
        for i in stride(from: arr.count / 2 - 1, through: 0, by: -1) {
            shiftDown(&arr, from: i)
        }
        
        /// Sort: decrease `arrCount` and shift down to the max heap
        for arrCount in stride(from: arr.count - 1, through: 0, by: -1) {
            arr.swapAt(0, arrCount)
            
            /// Create a max heap
            shiftDown(&arr, from: 0, arrCount)
        }
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

extension HeapSortExample {
    
    func testUsingHeapDataStructure() {
        
        let source = [4, 2, 1, 5, 1, 5, 2, 5, 1, 6]
        
        XCTAssert(usingHeapSortDS(source, sort: <) == source.sorted())
        XCTAssert(usingHeapSortDS(source, sort: >) == source.sorted(by: >))
    }
    
    func usingHeapSortDS<T>(_ arr: [T], sort: @escaping Heap<T>.Sort) -> [T] {
        return Heap<T>(sort: sort, array: arr).map({ $0 })
    }
}
