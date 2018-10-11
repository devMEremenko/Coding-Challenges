//
//  ZeroMatrix_1_8.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class ZeroMatrixTests: XCTestCase {
    
    /// Write an algorithm such that if an element in an MxN matrix is 0,
    /// its entire row and column are set to O.
    
    func testZeroMatrix1() {
        
        var result = createMatrix1()

        zeroMatrix(&result.source)
        
        XCTAssert(result.source == result.expected)
    }
    
    func testZeroMatrix2() {
        
        var result = createMatrix2()
        
        zeroMatrix(&result.source)
        
        XCTAssert(result.source == result.expected)
    }
    
    func testZeroMatrixWithConstantSpace1() {
        
        var result = createMatrix1()
        
        zeroMatrixWithConstantSpace(&result.source)
        
        XCTAssert(result.source == result.expected)
    }
    
    func testZeroMatrixWithConstantSpace2() {
        
        var result = createMatrix2()
        
        zeroMatrixWithConstantSpace(&result.source)
        
        XCTAssert(result.source == result.expected)
    }
}

extension ZeroMatrixTests {
    
    /// Time: (M*N)
    /// Space: (1)
    
    func zeroMatrixWithConstantSpace(_ matrix: inout [[Int]]) {
        
        guard !matrix.isEmpty else { return }
        
        var rowHasZero = false
        var columnHasZero = false
        
        /// Check if a first row has a zero
        for col in 0..<matrix[0].count {
            if matrix[0][col] == 0 {
                rowHasZero = true
                break
            }
        }
        
        /// Check if a first column has a zero
        for row in 0..<matrix.count {
            if matrix[row][0] == 0 {
                columnHasZero = true
                break
            }
        }
        
        /// Check for zeros in the rest of the matrix
        for row in 1..<matrix.count {
            for col in 1..<matrix[0].count {
                if matrix[row][col] == 0 {
                    matrix[row][0] = 0
                    matrix[0][col] = 0
                }
            }
        }
        
        /// Nullify rows based on values in a first column
        for row in 1..<matrix.count {
            if matrix[row][0] == 0 {
                nullify(row: row, &matrix)
            }
        }
        
        /// Nullify columns based on values in a first row
        for col in 1..<matrix[0].count {
            if matrix[0][col] == 0 {
                nullify(column: col, &matrix)
            }
        }
        
        /// Nullify a first row
        if rowHasZero {
            nullify(row: 0, &matrix)
        }
        
        /// Nullify a first column
        if columnHasZero {
            nullify(column: 0, &matrix)
        }
    }
    
    private func nullify(row: Int, _ matrix: inout [[Int]]) {
        for col in 0..<matrix[0].count {
            matrix[row][col] = 0
        }
    }
    
    private func nullify(column: Int, _ matrix: inout [[Int]]) {
        for row in 0..<matrix.count {
            matrix[row][column] = 0
        }
    }
}

extension ZeroMatrixTests {
    
    /// Time: (M*N)
    /// Space: (N) - for marked rows
    
    struct Constant {
        /// Note: -1 is used as a mark for simplicity
        static let mark = -1
    }
    
    func zeroMatrix(_ source: inout [[Int]]) {
        if let markedRows = createMarkedRows(&source) {
            setColumnsToZero(&source, markedRows)
        }
    }
    
    private func createMarkedRows(_ source: inout [[Int]]) -> [Int]? {
        
        guard !source.isEmpty else { return nil }
        
        var markedRows = Array(repeating: Constant.mark, count: source.first!.count)
        
        for (columnIdx, rows) in source.enumerated() {
            
            for (rowIdx, row) in rows.enumerated() {
                if row == 0 {
                    markedRows[rowIdx] = columnIdx
                }
            }
            
            if markedRows.contains(columnIdx) {
                for idx in 0..<source[columnIdx].count {
                    source[columnIdx][idx] = 0
                }
            }
        }
        
        return markedRows
    }
    
    private func setColumnsToZero(_ source: inout [[Int]], _ markedRows: [Int]) {
        for case (let row, let column) in markedRows.enumerated()
            where column != Constant.mark {
                
            source.enumerated().forEach({ rowIdx, _ in
                source[rowIdx][row] = 0
            })
        }
    }
}

extension ZeroMatrixTests {
    
    /// Test data
    
    /// [row][col] = [2][1] = 5
    /// row 0   3
    /// row 1   4
    /// row 2   5
    
    func createMatrix1() -> (source: [[Int]], expected: [[Int]]) {
        
        let source = [[0, 1, 2], [1, 1, 3], [0, 0, 2], [1, 4, 3]]
        let expected = [[0, 0, 0], [0, 0, 3], [0, 0, 0], [0, 0, 3]]
        
        /// source  expected
        /// 0 1 2   0 0 0
        /// 1 1 3   0 0 3
        /// 0 0 2   0 0 0
        /// 1 4 3   0 0 3
        
        /// marked rows:
        /// 2 2 -1
        
        return (source, expected)
    }
    
    func createMatrix2() -> (source: [[Int]], expected: [[Int]]) {
        
        let source = [[0, 1, 2, 3], [1, 1, 3, 4], [0, 2, 2, 0], [1, 4, 3, 5]]
        let expected = [[0, 0, 0, 0], [0, 1, 3, 0], [0, 0, 0, 0], [0, 4, 3, 0]]
        
        /// source       expected
        /// 0, 1, 2, 3   0, 0, 0, 0
        /// 1, 1, 3, 4   0, 1, 3, 0
        /// 0, 2, 2, 0   0, 0, 0, 0
        /// 1, 4, 3, 5   0, 4, 3, 0
        
        /// marked rows:
        /// 2, -1, -1, 2
        
        return (source, expected)
    }
}
