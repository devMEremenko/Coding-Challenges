//
//  UnionFind.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 21.11.2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class UnionFindTests: XCTestCase {
    
    func test1() {
        var sut = UnionFind(count: 4)
        sut.union(0, 0)
        sut.union(0, 1)
        sut.union(0, 2)
        sut.union(0, 3)
        XCTAssertTrue(sut.find(0, 0))
        XCTAssertTrue(sut.find(0, 1))
        XCTAssertTrue(sut.find(0, 2))
        XCTAssertTrue(sut.find(0, 3))
    }
    
    func test2() {
        var sut = UnionFind(count: 4)
        sut.union(0, 0)
        sut.union(0, 3)
        XCTAssertTrue(sut.find(0, 0))
        XCTAssertFalse(sut.find(0, 1))
        XCTAssertFalse(sut.find(0, 2))
        XCTAssertTrue(sut.find(0, 3))
    }
    
    func test3() {
        var sut = UnionFind(count: 4)
        sut.union(0, 10)
        XCTAssertFalse(sut.find(0, 1))
        XCTAssertFalse(sut.find(0, 2))
        XCTAssertFalse(sut.find(0, 3))
    }
    
    func test_find1() {
        let sut = UnionFind(count: 10)
        for idx in (0..<sut.items.count) {
            XCTAssertFalse(sut.find(idx, idx + 1))
        }
    }
    
    func test_find2() {
        var sut = UnionFind(count: 10)
        for idx in (0..<sut.items.count) {
            sut.union(idx, 5)
        }
        for idx in (0..<sut.items.count - 1) {
            XCTAssertTrue(sut.find(idx, idx + 1))
        }
    }
}

struct UnionFind {
    
    typealias Element = Int
    
    private(set) var items: [Element]
    private var depths: [Int]
    
    init(count: Int) {
        depths = .init(repeating: 0, count: count)
        items = .init(repeating: 0, count: count)
        items.enumerated().forEach {
            items[$0.offset] = $0.offset
        }
    }
    
    mutating func union(_ first: Element, _ second: Element) {
        guard checkBounds(first, second) else { return }
        
        let firstRoot = findRoot(first)
        let secondRoot = findRoot(second)
        
        guard firstRoot != secondRoot else { return }
        
        if depths[firstRoot] < depths[secondRoot] {
            items[firstRoot] = secondRoot
            depths[secondRoot] += depths[firstRoot]
        } else {
            items[secondRoot] = firstRoot
            depths[firstRoot] += depths[secondRoot]
        }
    }
    
    /// Returns `true` if elements are connected.
    func find(_ first: Element, _ second: Element) -> Bool {
        guard checkBounds(first, second) else {
            return false
        }
        return findRoot(first) == findRoot(second)
    }
    
    private func findRoot(_ element: Element) -> Int {
        var root = element
        while items[root] != root {
            root = items[root]
        }
        return root
    }
    
    private func checkBounds(_ first: Element, _ second: Element) -> Bool {
        guard first < items.count else { return false }
        guard second < items.count else { return false }
        return true
    }
}
