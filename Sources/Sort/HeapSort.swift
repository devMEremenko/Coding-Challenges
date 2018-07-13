//
//  HeapSort.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/13/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class HeapSortExample: XCTestCase {
    
    func test() {
        
        let source = [4, 2, 1, 5, 1, 5, 2, 5, 1, 6]
        
        XCTAssert(heapSort(source, sort: <) == source.sorted())
        XCTAssert(heapSort(source, sort: >) == source.sorted(by: >))
    }
    
    func heapSort(_ arr: [Int], sort: @escaping Heap<Int>.Sort) -> [Int] {
        return Heap<Int>(sort: sort, array: arr).map({ $0 })
    }
}
