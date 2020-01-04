//
//  RingBuffer.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 8/13/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class RingBufferTest: XCTestCase {
    
    func testWriting() {
        
        var buffer = RingBuffer<Int>(4)
        
        for item in 1...8 {
            buffer.write(item)
        }
        
        XCTAssert([Int](5...8) == buffer.allItems)
    }
    
    func testReading() {
        
        var buffer = RingBuffer<Int>(4)
        
        for item in 1...8 {
            buffer.write(item)
            XCTAssert(buffer.read() == item)
        }
        
        XCTAssert([Int](5...8) == buffer.allItems)
    }
}

struct RingBuffer<T> {
    
    private var storage: [T?]
    private var writeIndex = 0
    private var readIndex = 0
    
    init(_ count: Int) {
        self.storage = Array(repeating: nil, count: count > 0 ? count : 0)
    }
    
    mutating func read() -> T? {
        if readIndex >= storage.count {
            guard storage.count != 0 else { return nil }
            readIndex = 0
        }
        
        guard let item = storage[readIndex] else { return nil }
        readIndex += 1
        return item
    }
    
    mutating func write(_ item: T) {
        if writeIndex >= storage.count {
            guard storage.count != 0 else { return }
            writeIndex = 0
        }
        storage[writeIndex] = item
        writeIndex += 1
    }
}

// MARK: - Debug

extension RingBuffer {
    
    fileprivate var allItems: [T?] {
        return storage
    }
}
