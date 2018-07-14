//
//  HeapSort.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/13/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class HeapSortExample: XCTestCase {
    
}

extension HeapSortExample {
    
    func testHeapSort() {
        
    }
    
    func heapSort(_ arr: [Int]) {
        
    }
}

extension HeapSortExample {
    
    func testUsingHeapDataStructure() {
        
        let source = [4, 2, 1, 5, 1, 5, 2, 5, 1, 6]
        
        XCTAssert(usingHeapSortDS(source, sort: <) == source.sorted())
        XCTAssert(usingHeapSortDS(source, sort: >) == source.sorted(by: >))
    }
    
    func usingHeapSortDS<T>(_ arr: [T], sort: @escaping Heap<T>.Sort) -> [T] {
        return Heap<T>(sort: sort, array: arr).map({ $0 })
    }
}
