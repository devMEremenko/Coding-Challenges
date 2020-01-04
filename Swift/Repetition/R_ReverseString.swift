//
//  R_ReverseString.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 24.12.2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class R_ReverseString: XCTestCase {
    
    func test_even() {
        var sut = "123456"
        reverse(&sut)
        XCTAssertEqual(sut, "654321")
    }
    
    func test_odd() {
        var sut = "12345"
        reverse(&sut)
        XCTAssertEqual(sut, "54321")
    }
    
    func test_empty() {
        var sut = ""
        reverse(&sut)
        XCTAssertEqual(sut, "")
    }
    
    func test_custom_collection_reversed() {
        let some = MyCollection([1, 2, 3])
        XCTAssertEqual(some.reversed(), [3, 2, 1])
    }
}

extension R_ReverseString {
    
    /// There are 2 options to reverse a String
    ///
    /// 1) Using a `ReverseCollection` type. O(1) time and space.
    /// 2) Using an additional array to make it inplace. O(n) time and space.
    
    func reverse(_ source: inout String) {
        var items = Array(source)
        var s = items.startIndex
        var e = items.index(before: items.endIndex)
        
        while s < e {
            items.swapAt(s, e)
            items.formIndex(after: &s)
            items.formIndex(before: &e)
        }
        source = String(items)
    }
}

private struct MyCollection<Item>: Collection {
    
    private var items = [Item]()
    
    init<C: Collection>(_ items: C) where C.Element == Item {
        self.items = items.map { $0 }
    }
    
    func index(after i: Int) -> Int {
        return items.index(after: i)
    }
    
    subscript(position: Int) -> Item {
        return items[position]
    }
    
    var startIndex: Int {
        return items.startIndex
    }
    
    var endIndex: Int {
        return items.endIndex
    }
}
