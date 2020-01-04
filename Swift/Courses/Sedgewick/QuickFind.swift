//
//  UnionFind.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 07/11/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class QuickFindTests: XCTestCase {
    
    func test_union1() {
        var sut = QuickFind(count: 10)
        sut.union(3, 9)
        sut.union(1, 5)
        XCTAssertEqual(sut.items, [0, 5, 2, 9, 4, 5, 6, 7, 8, 9])
    }
    
    func test_union2() {
        var sut = QuickFind(count: 10)
        for idx in (0..<sut.items.count) {
            sut.union(idx, 3)
        }
        XCTAssertEqual(sut.items, [Int].init(repeating: 3, count: 10))
    }
    
    func test_find1() {
        let sut = QuickFind(count: 10)
        for idx in (0..<sut.items.count) {
            XCTAssertFalse(sut.find(idx, idx + 1))
        }
    }
    
    func test_find2() {
        var sut = QuickFind(count: 10)
        for idx in (0..<sut.items.count) {
            sut.union(idx, 5)
        }
        for idx in (0..<sut.items.count - 1) {
            XCTAssertTrue(sut.find(idx, idx + 1))
        }
    }
}

struct QuickFind {
    
    typealias Element = Int
    
    private(set) var items: [Element]
    
    init(count: Int) {
        items = .init(repeating: 0, count: count)
        items.enumerated().forEach {
            items[$0.offset] = $0.offset
        }
    }
    
    mutating func union(_ first: Element, _ second: Element) {
        guard first != second else { return }
        
        for (idx, item) in items.enumerated() where item == first {
            items[idx] = second
        }
    }
    
    /// Returns `true` if elements are connected.
    func find(_ first: Element, _ second: Element) -> Bool {
        guard first < items.count else { return false }
        guard second < items.count else { return false }
        return items[first] == items[second]
    }
}
