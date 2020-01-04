//
//  BitManipulation.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 11/02/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class BitManipulation: XCTestCase {
    
    func test_XOR() {
        // 0b00001010 -> 10
        // 0b00010001 -> 17
        // 0b00011011 -> 27
        XCTAssertEqual(10 ^ 17, 27)
    }
    
    func test_setBit() {
        XCTAssertEqual(Int8(0b0001_0100).setBit(position: 0), 0b0001_0101)
        XCTAssertEqual(Int8(0b0001_0101).setBit(position: 3), 0b0001_1101)
        
        let expected = Int8(bitPattern: 0b1000_0000) // -128
        XCTAssertEqual(Int8(0b0000_0000).setBit(position: 7), expected)
    }
    
    func test_getBit() {
        XCTAssertTrue(Int8(0b0001_1001).getBit(position: 3))
        XCTAssertFalse(Int8(0b0001_0001).getBit(position: 3))
        
        XCTAssertTrue(Int8(0b0001_0101).getBit(position: 0))
        XCTAssertFalse(Int8(0b0001_0000).getBit(position: 0))
        
        XCTAssertTrue(Int8(bitPattern: 0b1000_0000).getBit(position: 7))
        XCTAssertFalse(Int8(0b0001_0000).getBit(position: 7))
    }
    
    func test_clearBit() {
        XCTAssertEqual(Int8(0b0011_1001).clearBit(position: 0), 0b0011_1000)
        XCTAssertEqual(Int8(0b0011_1001).clearBit(position: 3), 0b0011_0001)
        XCTAssertEqual(Int8(0b0011_1011).clearBit(position: 1), 0b0011_1001)
        XCTAssertEqual(Int8(0b0011_1111).clearBit(position: 2), 0b0011_1011)
        XCTAssertEqual(Int8(bitPattern: 0b1000_0000).clearBit(position: 7), 0)
    }
    
    func test_clearMSBit_usingAND() {
        XCTAssertEqual(Int8(bitPattern: 0b1111_1111).clearMSBit_usingAND(position: 3), 0b0000_0111)
        XCTAssertEqual(Int8(bitPattern: 0b1111_1111).clearMSBit_usingAND(position: 6),
                       Int8(bitPattern: 0b0011_1111))
        
        XCTAssertEqual(Int8(bitPattern: 0b1111_1111).clearMSBit_usingAND(position: 0),
                       Int8(bitPattern: 0b0000_0000))
    }
    
    func test_clearMSBit_usingXOR() {
        XCTAssertEqual(Int8(bitPattern: 0b1111_1111).clearMSBit_usingXOR(position: 3), 0b0000_0111)
        XCTAssertEqual(Int8(bitPattern: 0b1111_1111).clearMSBit_usingXOR(position: 6),
                       Int8(bitPattern: 0b0011_1111))
        
        XCTAssertEqual(Int8(bitPattern: 0b1111_1111).clearMSBit_usingXOR(position: 0),
                       Int8(bitPattern: 0b0000_0000))
    }
    
    func test_clearBitsFrom() {
        XCTAssertEqual(Int8(0b0011_1001).clearBitsFrom(position: 0), 0b0011_1000)
        XCTAssertEqual(Int8(0b0111_1011).clearBitsFrom(position: 1), 0b0111_1000)
        XCTAssertEqual(Int8(0b0111_1011).clearBitsFrom(position: 3), 0b0111_0000)
        XCTAssertEqual(Int8(0b0111_1011).clearBitsFrom(position: 6), 0)
        XCTAssertEqual(Int8(bitPattern: 0b1000_0000).clearBitsFrom(position: 7), 0)
    }
    
    func test_updateBit() {
        XCTAssertEqual(Int8(0b0011_1001).updateBit(position: 0, value: true), 0b0011_1001)
        XCTAssertEqual(Int8(0b0011_1001).updateBit(position: 0, value: false), 0b0011_1000)
        
        XCTAssertEqual(Int8(0b0011_1001).updateBit(position: 1, value: true), 0b0011_1011)
        XCTAssertEqual(Int8(0b0011_1001).updateBit(position: 1, value: false), 0b0011_1001)
        
        XCTAssertEqual(Int8(0b0011_1001).updateBit(position: 3, value: true), 0b0011_1001)
        XCTAssertEqual(Int8(0b0011_1001).updateBit(position: 3, value: false), 0b0011_0001)
        
        XCTAssertEqual(Int8(0b0011_1001).updateBit(position: 6, value: true), 0b0111_1001)
        XCTAssertEqual(Int8(0b0011_1001).updateBit(position: 6, value: false), 0b0011_1001)
        
        XCTAssertEqual(Int8(0).updateBit(position: 7, value: true),
                       Int8(bitPattern: 0b1000_0000))
        XCTAssertEqual(Int8(bitPattern: 0b1000_0000).updateBit(position: 7, value: false), 0)
    }
}

private extension Int8 {
    
    /// Note: Each example assumes that 'position' equals 2.
    
    func setBit(position: Int8) -> Int8 {
        /// 1010 - value
        /// 0100 - mask
        /// 1110 - result (OR)
        return self | (Int8(1) << position)
    }
    
    func getBit(position: Int8) -> Bool {
        /// 1110 - value
        /// 0100 - mask
        /// 0100 - result (AND)
        return (self & (Int8(1) << position)) != 0
    }
    
    func clearBit(position: Int8) -> Int8 {
        /// 1110 - value
        /// 1011 - inverted mask
        /// 1010 - result (AND)
        let mask = ~(Int8(1) << position)
        return self & mask
    }
    
    /// Clear all bits from the most significant bit through position (inclusive)
    func clearMSBit_usingAND(position: Int8) -> Int8 {
        /// 1110 - value
        /// 0100 - mask
        /// 0011 - mask - 1 (Note: 0100 - 0001 = 0011)
        /// 0010 - result (AND)
        let mask = (Int8(1) << position) - 1
        return self & mask
    }
    
    /// Clear all bits from the most significant bit through position (inclusive)
    func clearMSBit_usingXOR(position: Int8) -> Int8 {
        /// Method 2
        /// 1110 - value
        /// 1100 - mask
        /// 0010 - result (XOR)
        let mask = Int8(-1) << position
        return self ^ mask
    }
    
    /// Clear all bits from position (inclusive) through 0 (inclusive)
    func clearBitsFrom(position: Int8) -> Int8 {
        /// 10110 - value
        /// 11111 - mask
        /// 11000 - shifted mask
        /// 10000 - result (AND)
        let mask = Int8(-1) << (position + 1)
        return self & mask
    }
    
    func updateBit(position: Int8, value: Bool) -> Int8 {
        /// Set to 0
        /// 1110 - value
        /// 1011 - mask
        /// 1010 - masked value (AND)
        /// 0000 - mask of 0
        /// 1010 - result (OR)
        
        /// Set to 1
        /// 1010 - value
        /// 1011 - mask
        /// 1010 - masked value (AND)
        /// 0100 - mask of 1
        /// 1110 - result (OR)
        let clearMask = ~(Int8(1) << position)
        let setMask = Int8(value ? 1 : 0) << position
        return (self & clearMask) | setMask
    }
}
