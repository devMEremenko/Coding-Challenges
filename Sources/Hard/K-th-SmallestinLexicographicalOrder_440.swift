//
//  K-th-SmallestinLexicographicalOrder_440.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/17/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class K_th_SmallestinLexicographicalOrder_440: XCTestCase {
    
    /// https://leetcode.com/problems/k-th-smallest-in-lexicographical-order/description/
    ///
    /// Given integers n and k, find the lexicographically k-th smallest integer
    /// in the range from 1 to n.
    ///
    /// Note: 1 ≤ k ≤ n ≤ 109.
    ///
    /// Input: n: 13   k: 2
    /// Output: 10
    ///
    /// Explanation:
    /// The lexicographical order is [1, 10, 11, 12, 13, 2, 3, 4, 5, 6, 7, 8, 9],
    /// so the second smallest number
    
    func test() {
        XCTAssert(findKthNumber(13, 2) == 10)
        XCTAssert(findKthNumber(2, 2) == 2)
        XCTAssert(findKthNumber(10, 3) == 2)
    }
    
    func testExtracting() {
        XCTAssert(findKthNumberByExtractingHeapValues(13, 2) == 10)
        XCTAssert(findKthNumberByExtractingHeapValues(2, 2) == 2)
        XCTAssert(findKthNumberByExtractingHeapValues(10, 3) == 2)
        XCTAssert(findKthNumberByExtractingHeapValues(100, 10) == 17)
        XCTAssert(findKthNumberByExtractingHeapValues(1, 1) == 1)
        
        /// Works too slow on big data sets
        /// XCTAssert(findKthNumberByExtractingHeapValues(4289384, 1922239) == WHO_KNOWS)
    }
    
    /// Complexity
    /// Time: O(n + k + (n - k) * log(k)) => O(2n * log(k)) => O(n * log(k))
    /// Space: O(n) - for an array
    
    func findKthNumber(_ n: Int, _ k: Int) -> Int {
        
        /// Create an array of numbers
        var arr = [Int]()
        arr.reserveCapacity(n)
        
        for i in 1...n {
            arr.append(i)
        }
        
        /// Build a max heap
        for parentIdx in stride(from: k, through: 0, by: -1) {
            shiftDown(&arr, from: parentIdx, k)
        }
        
        /// If an item is smaller than root
        /// set it as a root and heapify()
        
        for idx in stride(from: arr.count - 1, through: k + 1, by: -1) {
            if arr[0].isBigger(than: arr[idx]) {
                arr.swapAt(0, idx)
                shiftDown(&arr, from: 0, k - 1)
            }
        }
        
        return arr[0]
    }
    
    func shiftDown(_ arr: inout [Int], from idx: Int, _ toIdx: Int? = nil) {
        
        var parentIndex = idx
        let toIdx = toIdx ?? arr.count - 1
        
        while hasLeftChild(parentIndex, toIdx) {
            
            var maxIndex = leftChildIndex(parentIndex)
            
            if arr[leftChildIndex(parentIndex)].isBigger(than: arr[parentIndex]) {
                maxIndex = leftChildIndex(parentIndex)
            }
            
            if hasRightChild(parentIndex, toIdx) {
                if arr[rightChildIndex(parentIndex)].isBigger(than: arr[maxIndex]) {
                    maxIndex = rightChildIndex(parentIndex)
                }
            }
            
            if arr[parentIndex].isBigger(than: arr[maxIndex]) {
                break
            } else {
                arr.swapAt(parentIndex, maxIndex)
            }
            
            parentIndex = maxIndex
        }
    }
}

extension K_th_SmallestinLexicographicalOrder_440 {
    
    /// Complexity
    /// Time: O(n + n * log(n) + k)
    /// Space: O(n) - for a heap
    
    func findKthNumberByExtractingHeapValues(_ n: Int, _ k: Int) -> Int {
        
        /// Create an array of numbers
        var arr = [Int]()
        arr.reserveCapacity(n)
        
        for i in 1...n {
            arr.append(i)
        }
        
        let heap = Heap<Int>(sort: { left, right in
            return left.isLess(than: right)
        }, array: arr)
        
        for _ in stride(from: k - 1, through: 1, by: -1) {
            heap.poll()
        }
        return heap.poll() ?? -1
    }
}

extension K_th_SmallestinLexicographicalOrder_440 {
    
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

private extension Int {
    
    /// Returns true if the left is lexicographically less than right.
    
    func isLess(than number: Int) -> Bool {
        
        var i = 1
        while true {
            
            guard let leftDigit = self.digit(i) else {
                return true
            }
            
            guard let rightDigit = number.digit(i) else {
                return false
            }
            
            if leftDigit > rightDigit {
                return false
            } else if leftDigit < rightDigit {
                return true
            }
            i += 1
        }
    }
}

private extension Int {
    
    /// Returns true if the left is lexicographically greater than right.
    
    func isBigger(than number: Int) -> Bool {
        
        var i = 1
        while true {
            
            guard let leftDigit = self.digit(i) else {
                return true
            }
            
            guard let rightDigit = number.digit(i) else {
                return false
            }
            
            if leftDigit > rightDigit {
                return true
            } else if leftDigit < rightDigit {
                return false
            }
            i += 1
        }
    }
    
    func digit(_ number: Int) -> Int? {
        let string = String(self)
        guard number - 1 < string.count else { return nil }
        return Int(String(string[number - 1]))
    }
    
    var firstNumber: Int {
        var digit = self
        while digit > 9 {
            digit /= 10
        }
        return digit
    }
}
