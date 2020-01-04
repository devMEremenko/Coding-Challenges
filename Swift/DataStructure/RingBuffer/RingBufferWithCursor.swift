//
//  RingBufferWithCursor.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 22/10/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class RingBufferWithCursorTests: XCTestCase {
    
    typealias Buffer = RingBufferWithCursor<Int>
    
    func test_flush1() {
        var sut = Buffer(itemsCount: 100, readingOffset: 10)
        sut.setReadingIndex()
        write(&sut, 1...10)
        XCTAssertEqual(sut.flush(), (1...10).array)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func test_flush2() {
        var sut = Buffer(itemsCount: 100, readingOffset: 10)
        write(&sut, 1...10)
        sut.setReadingIndex()
        XCTAssertEqual(sut.flush(), (1...10).array)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func test_flush3() {
        var sut = Buffer(itemsCount: 100, readingOffset: 0)
        write(&sut, 1...10)
        sut.setReadingIndex()
        XCTAssertEqual(sut.flush(), [])
        XCTAssertTrue(sut.isEmpty)
    }
    
    func test_flush4() {
        var sut = Buffer(itemsCount: 100, readingOffset: 0)
        /// reading index is set to 0
        write(&sut, 1...10)
        XCTAssertEqual(sut.flush(), (1...10).array)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func test_flush5() {
        var sut = Buffer(itemsCount: 10, readingOffset: 0)
        write(&sut, 1...15)
        XCTAssertEqual(sut.flush(), (6...15).array)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func test_flush6() {
        var sut = Buffer(itemsCount: 10, readingOffset: 10)
        write(&sut, 1...15)
        sut.setReadingIndex()
        XCTAssertEqual(sut.flush(), (6...15).array)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func test_flush7() {
        var sut = Buffer(itemsCount: 10, readingOffset: 2)
        write(&sut, 1...10)
        sut.setReadingIndex() // readingIndex = 8
        write(&sut, 11...25)  // readingIndex = 16
        XCTAssertEqual(sut.flush(), (16...25).array)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func test_flush8() {
        var sut = Buffer(itemsCount: 10, readingOffset: 2)
        write(&sut, 1...10)
        sut.setReadingIndex()
        write(&sut, 11...25)
        sut.setReadingIndex()
        XCTAssertEqual(sut.flush(), (24...25).array)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func test_flush9() {
        var sut = Buffer(itemsCount: 10, readingOffset: 3)
        write(&sut, 1...21)
        sut.setReadingIndex()
        XCTAssertEqual(sut.flush(), (19...21).array)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func test_flush10() {
        var sut = Buffer(itemsCount: 10, readingOffset: 3)
        write(&sut, 1...10)
        sut.setReadingIndex()
        write(&sut, 11...21)
        sut.setReadingIndex()
        XCTAssertEqual(sut.flush(), (19...21).array)
        XCTAssertTrue(sut.isEmpty)
    }
}

extension RingBufferWithCursorTests {
    
    private func write(_ sut: inout Buffer, _ range: ClosedRange<Int>) {
        range.array.forEach { sut.write($0) }
    }
}

private extension ClosedRange where Bound == Int {
    
    var array: [Int] {
        return map { $0 }
    }
}

struct RingBufferWithCursor<Element> {
    
    private(set) var items = [Element?]()
    private var readIndex: Array<Element>.Index
    private var writeIndex: Array<Element>.Index
    private let readIndexOffset: Int
    
    init(itemsCount: Int, readingOffset: Int) {
        items = .init(repeating: nil, count: itemsCount)
        readIndex = items.startIndex
        writeIndex = items.startIndex
        readIndexOffset = readingOffset
    }
}

extension RingBufferWithCursor {
    
    mutating func setReadingIndex() {
        readIndex = max(writeIndex - readIndexOffset, 0)
    }
    
    mutating func write(_ item: Element) {
        defer {
            writeIndex += 1
        }
        if isFull {
            readIndex += 1
        }
        items[inBounds: writeIndex] = item
    }
    
    mutating func flush() -> [Element] {
        defer {
            reset()
        }
        return readAll()
    }
    
    mutating func reset() {
        items = .init(repeating: nil, count: items.count)
        readIndex = items.startIndex
        writeIndex = items.startIndex
    }
}

extension RingBufferWithCursor {
    
    private mutating func readAll() -> [Element] {
        var results = [Element]()
        results.reserveCapacity(availableSpaceForReading)
        while !isEmpty {
            if let item = read() {
                results.append(item)
            }
        }
        return results
    }
    
    private mutating func read() -> Element? {
        guard !isEmpty else { return nil }
        defer {
            readIndex += 1
        }
        return items[inBounds: readIndex]
    }
}

extension RingBufferWithCursor {
    
    var isEmpty: Bool {
        return availableSpaceForReading == 0
    }
    
    var isFull: Bool {
        return availableSpaceForWriting == 0
    }
    
    private var availableSpaceForReading: Int {
        return writeIndex - readIndex
    }

    private var availableSpaceForWriting: Int {
        return items.count - availableSpaceForReading
    }
}

private extension Array {
    
    subscript(inBounds index: Int) -> Element {
        get {
            return self[validIndex(from: index)]
        }
        set {
            self[validIndex(from: index)] = newValue
        }
    }
        
    private func validIndex(from index: Int) -> Int {
        return index == 0 ? 0 : index % count
    }
}

