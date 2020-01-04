//
//  UnionFind.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 21.11.2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class UnionFindTests: XCTestCase {
    
    /// Union Find: https://en.wikipedia.org/wiki/Disjoint-set_data_structure
    
    func test_union_withFirstElement_stateIsCorrect() {
        var sut = UnionFind(count: 4)
        sut.union(0, 0)
        sut.union(0, 1)
        sut.union(0, 2)
        sut.union(0, 3)
        XCTAssertTrue(sut.find(0, 0))
        XCTAssertTrue(sut.find(0, 1))
        XCTAssertTrue(sut.find(0, 2))
        XCTAssertTrue(sut.find(0, 3))
        XCTAssertEqual(sut.depths[0], 4)
        XCTAssertEqual(sut.depths[1], 1)
        XCTAssertEqual(sut.depths[2], 1)
        XCTAssertEqual(sut.depths[3], 1)
    }
        
    func test_union_withAbsentElement_stateIsCorrect() {
        var sut = UnionFind(count: 4)
        sut.union(0, 10)
        XCTAssertFalse(sut.find(0, 1))
        XCTAssertFalse(sut.find(0, 2))
        XCTAssertFalse(sut.find(0, 3))
    }
    
    func test_union_whenBoundsAreConnected_stateIsCorrect() {
        var sut = UnionFind(count: 4)
        sut.union(0, 0)
        sut.union(0, 3)
        XCTAssertTrue(sut.find(0, 0))
        XCTAssertFalse(sut.find(0, 1))
        XCTAssertFalse(sut.find(0, 2))
        XCTAssertTrue(sut.find(0, 3))
    }
    
    func test_find_with4Elements_depthsAreCorrect() {
        var sut = UnionFind(count: 4)
        sut.union(2, 3)
        sut.union(0, 1)
        sut.union(1, 2)
        XCTAssertTrue(sut.find(0, 2))
        XCTAssertTrue(sut.find(1, 2))
        XCTAssertTrue(sut.find(3, 2))
        XCTAssertTrue(sut.find(0, 2))
        XCTAssertTrue(sut.find(0, 3))
        XCTAssertTrue(sut.find(1, 3))
        
        XCTAssertEqual(sut.depths[0], 4)
        XCTAssertEqual(sut.depths[1], 1)
        XCTAssertEqual(sut.depths[2], 2)
        XCTAssertEqual(sut.depths[3], 1)
    }
    
    func test_union_with2Subsets_stateIsCorrect() {
        var sut = UnionFind(count: 4)
        sut.union(2, 3)
        sut.union(0, 1)
        XCTAssertTrue(sut.find(2, 3))
        XCTAssertTrue(sut.find(0, 1))
        XCTAssertFalse(sut.find(2, 1))
        XCTAssertFalse(sut.find(2, 0))
        XCTAssertFalse(sut.find(3, 1))
        XCTAssertFalse(sut.find(3, 0))
        
        sut.union(3, 1)
        XCTAssertTrue(sut.find(2, 3))
        XCTAssertTrue(sut.find(0, 1))
        XCTAssertTrue(sut.find(2, 1))
        XCTAssertTrue(sut.find(2, 0))
        XCTAssertTrue(sut.find(3, 1))
        XCTAssertTrue(sut.find(3, 0))
    }
    
    func test_find_allElementsNotConnected_stateIsCorrect() {
        var sut = UnionFind(count: 10)
        for idx in (0..<sut.items.count) {
            XCTAssertFalse(sut.find(idx, idx + 1))
        }
    }
    
    func test_find_allElementsConnectedAtMiddle_stateIsCorrect() {
        var sut = UnionFind(count: 10)
        for idx in (0..<sut.items.count) {
            sut.union(idx, 5)
        }
        for idx in (0..<sut.items.count - 1) {
            XCTAssertTrue(sut.find(idx, idx + 1))
        }
    }
}

/// `UnionFind` efficiently connects and checks the connection of passed elements.
///
/// The current implementation uses `Path Compression` technique
/// to reduce the height of a tree.
///
/// `Path Compression` is described [here](https://en.wikipedia.org/wiki/Disjoint-set_data_structure#Path_compression)

struct UnionFind {
    
    typealias Element = Int
    
    private(set) var items: [Element]
    private(set) var depths: [Int]
    
    /// Creates a new collection containing the specified number of elements.
    ///
    /// - Parameter count: The number of elements to initialize.
    ///                    Count must be zero or greater.
    init(count: Int) {
        precondition(count >= 0, "Count must be greater than or equal to zero.")
        depths = .init(repeating: 1, count: count)
        items = .init(repeating: 0, count: count)
        items.enumerated().forEach {
            items[$0.offset] = $0.offset
        }
    }
    
    /// Connects two elements.
    ///
    /// - Both parameters can be absent in the collection.
    /// - Do not crashes if elements are out of bounds.
    ///
    /// - Parameter first: First element to check.
    /// - Parameter second: Second element to check.
    ///
    /// - Returns: `true` if elements are connected, `false` otherwise.
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
    
    /// Checks if two elements are connected.
    ///
    /// - Both parameters can be absent in the collection.
    /// - Do not crashes if elements are out of bounds.
    ///
    /// - Parameter first: First element to check.
    /// - Parameter second: Second element to check.
    ///
    /// - Returns: `true` if elements are connected, `false` otherwise.
    mutating func find(_ first: Element, _ second: Element) -> Bool {
        guard checkBounds(first, second) else {
            return false
        }
        return findRoot(first) == findRoot(second)
    }
}

extension UnionFind {
    
    private mutating func findRoot(_ element: Element) -> Int {
        var root = element
        while items[root] != root {
            items[root] = items[items[root]] /// Path compression
            root = items[root]
        }
        return root
    }
    
    private func checkBounds(_ first: Element, _ second: Element) -> Bool {
        /// The error handling depends on use cases:
        ///
        /// - throw Swift.Error
        /// - fatalError("Element \(item) is out of bounds [0...\(items.count - 1)]")
        /// - handling silently
        guard first < items.count else { return false }
        guard second < items.count else { return false }
        return true
    }
}
