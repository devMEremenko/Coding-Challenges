//
//  RotateMatrix_1_7.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/9/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class RotateMatrixTests: XCTestCase {
    
    /// Rotate Matrix
    ///
    /// Given an image represented by an NxN matrix, where each pixel in the image
    /// is 4 bytes. Write a method to rotate the image by 90 degrees.
    ///
    /// Can you do this in place?
    
    func testRotation3x3() {
        
        var result = createMatrix3x3()
        
        rotateMatrix(&result.source)
        
        XCTAssert(result.source == result.expected)
    }
    
    func testRotation4x4() {
        
        var result = createMatrix4x4()
        
        rotateMatrix(&result.source)
        
        XCTAssert(result.source == result.expected)
    }
    
    func testRotation6x6() {
        
        var result = createMatrix6x6()
        
        rotateMatrix(&result.source)
        
        XCTAssert(result.source == result.expected)
    }
}

extension RotateMatrixTests {
    
    func rotateMatrix(_ matrix: inout [[Int]]) {
        
        guard !matrix.isEmpty else { return }
        guard !matrix[0].isEmpty else { return }
        guard matrix.count == matrix[0].count else { return }
        
        let matrixCount = matrix.count - 1
        
        for level in 0..<matrix.count / 2 {
            
            for idx in level..<matrixCount - level {
                
                let top = matrix[level][idx]
                
                let right = matrix[idx][matrixCount - level]
                
                let bottom = matrix[matrixCount - level][matrixCount - idx]
                
                let left = matrix[matrixCount - idx][level]
                
                /// top -> right
                matrix[idx][matrixCount - level] = top
                
                /// right -> bottom
                matrix[matrixCount - level][matrixCount - idx] = right
                
                /// bottom -> left
                matrix[matrixCount - idx][level] = bottom
                
                /// left -> top
                matrix[level][idx] = left
            }
        }
    }
}

extension RotateMatrixTests {
    
    /// Test data
    
    private func createMatrix3x3() -> (source: [[Int]], expected: [[Int]]) {
        
        let source = [[1,  2,  3],
                      [4,  5,  6],
                      [7,  8,  9]]
        
        let expected = [[7, 4, 1],
                        [8, 5, 2],
                        [9, 6, 3]]
        
        return (source, expected)
    }
    
    
    private func createMatrix4x4() -> (source: [[Int]], expected: [[Int]]) {
        
        let source = [[1,  2,  3,  4],
                      [5,  6,  7,  8],
                      [9,  10, 11, 12],
                      [13, 14, 15, 16]]
        
        let expected = [[13, 9, 5, 1],
                        [14, 10, 6, 2],
                        [15, 11, 7, 3],
                        [16, 12, 8, 4]]
        
        return (source, expected)
    }
    
    private func createMatrix6x6() -> (source: [[Int]], expected: [[Int]]) {
        
        let source = [[1,  2,  3,  4,  5,  6],
                      [7,  8,  9,  10, 11, 12],
                      [13, 14, 15, 16, 17, 18],
                      [19, 20, 21, 22, 23, 24],
                      [25, 26, 27, 28, 29, 30],
                      [31, 32, 33, 34, 35, 36]]
        
        let expected = [[31, 25, 19, 13,  7, 1],
                        [32, 26, 20, 14, 8, 2],
                        [33, 27, 21, 15, 9, 3],
                        [34, 28, 22, 16, 10, 4],
                        [35, 29, 23, 17, 11, 5],
                        [36, 30, 24, 18, 12, 6]]
        
        return (source, expected)
    }
}
