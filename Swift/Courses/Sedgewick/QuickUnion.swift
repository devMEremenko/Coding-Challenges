//
//  QuickUnion.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 21.11.2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class QuickUnionTests: XCTestCase {
    
    func test1() {
        var sut = QuickUnion(count: 4)
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
        var sut = QuickUnion(count: 4)
        sut.union(0, 0)
        sut.union(0, 3)
        XCTAssertTrue(sut.find(0, 0))
        XCTAssertFalse(sut.find(0, 1))
        XCTAssertFalse(sut.find(0, 2))
        XCTAssertTrue(sut.find(0, 3))
    }
    
    func test3() {
        var sut = QuickUnion(count: 4)
        sut.union(0, 10)
        XCTAssertFalse(sut.find(0, 1))
        XCTAssertFalse(sut.find(0, 2))
        XCTAssertFalse(sut.find(0, 3))
    }
}

struct QuickUnion {
    
    typealias Element = Int
    
    private var items: [Element]
    
    init(count: Int) {
        items = .init(repeating: 0, count: count)
        items.enumerated().forEach {
            items[$0.offset] = $0.offset
        }
    }
    
    mutating func union(_ first: Element, _ second: Element) {
        guard checkBounds(first, second) else {
            return
        }
        items[findRoot(first)] = findRoot(second)
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
