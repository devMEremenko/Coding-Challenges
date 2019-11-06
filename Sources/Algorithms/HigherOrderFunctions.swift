//
//  HigherOrderFunctions.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 17/08/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

class HigherOrderFunctions: XCTestCase {
    
    func test_customMap() {
        XCTAssertEqual([1, 2].customMap { $0 + 2 }, [3, 4])
        XCTAssertEqual([1, 2].customMap { String($0) }, ["1", "2"])
    }
    
    func test_customFlatMap() {
        XCTAssertEqual([[1, 2], [3, 4]].customFlatMap { $0 }, [1, 2, 3, 4])
        XCTAssertEqual([[1, 2], [3, 4]].customFlatMap { $0.map { String($0) } },
                       ["1", "2", "3", "4"])
    }
    
    func test_customFilter() {
        XCTAssertEqual([1, 2, 3, 4].customFilter { $0 % 2 == 0 }, [2, 4])
    }
    
    func test_customReduce_1() {
        XCTAssertEqual([1, 2, 3, 4].customReduce(0, +), 10)
        XCTAssertEqual([1, 2, 3, 4].customReduce("") { $0 + String($1) }, "1234")
    }
    
    func test_customReduce_2() {
        XCTAssertEqual([1, 2, 3, 4].customReduce(0, { $0 += $1 }), 10)
        XCTAssertEqual([1, 2, 3, 4].customReduce("") { $0 += String($1) }, "1234")
    }
}

private extension Array {
    
    func customMap<NewElement>(_ block: (Element) -> NewElement) -> [NewElement] {
        var result = [NewElement]()
        result.reserveCapacity(count)
        for item in self {
            result.append(block(item))
        }
        return result
    }
    
    func customFlatMap<NewSequence: Sequence>(_ block: (Element) -> NewSequence) -> [NewSequence.Element] {
        var result = [NewSequence.Element]()
        for item in self {
            result.append(contentsOf: block(item))
        }
        return result
    }
    
    func customFilter(_ block: (Element) -> Bool) -> Array {
        var result = [Element]()
        result.reserveCapacity(count)
        
        for item in self where block(item) {
            result.append(item)
        }
        return result
    }
    
    func customReduce<NewElement>(_ accumulator: NewElement, _ block: (NewElement, Element) throws -> NewElement) rethrows -> NewElement {
        
        var accumulator = accumulator
        for item in self {
            accumulator = try block(accumulator, item)
        }
        return accumulator
    }
    
    func customReduce<NewElement>(_ accumulator: NewElement, _ block: (inout NewElement, Element) throws -> Void) rethrows -> NewElement {
        var accumulator = accumulator
        for item in self {
            try block(&accumulator, item)
        }
        return accumulator
    }
}
