//
//  HastSet.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/26/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class HastSetTest: XCTestCase {
    
    /// This HashSet uses an array of linked lists to store the data.
    
    func testHashSet() {
        
        var set = HashSet<Int>()
        XCTAssert(set.contains(0) == false)
        
        set.add(0)
        set.add(5)
        set.add(10)
        set.add(15)
        set.add(5)
        set.add(0)
        
        XCTAssert(set.contains(0))
        XCTAssert(set.contains(5))
        XCTAssert(set.contains(10))
        XCTAssert(set.contains(15))
        XCTAssert(set.contains(3) == false)
        
        set.remove(10)
        XCTAssert(set.contains(10) == false)
        XCTAssert(set.contains(0))
        XCTAssert(set.contains(5))
        XCTAssert(set.contains(15))
        
        set.remove(5)
        XCTAssert(set.contains(5) == false)
        XCTAssert(set.contains(0))
        XCTAssert(set.contains(15))
        
        set.remove(0)
        set.remove(15)
        XCTAssert(set.contains(0) == false)
        XCTAssert(set.contains(15) == false)
    }
}

private struct HashSet<Value: Hashable> {
    
    typealias Bucket = List<Value>
    private var buckets: [Bucket]
    
    init() {
        self.init(capacity: 17)
    }
    
    init(capacity: Int = 17) {
        let adjustedCapacity = capacity > 0 ? capacity : 17
        buckets = Array()
        buckets.reserveCapacity(adjustedCapacity)
    }
    
    /// The number of buckets should be increased when 2/3 of the HashTable is filled.
    mutating func add(_ value: Value) {
        let bucket = findOrCreateBucket(value)
        
        if !bucket.contains({ $0 == value }) {
            bucket.append(value)
        }
    }
    
    func contains(_ value: Value) -> Bool {
        guard let bucket = findBucket(value) else { return false }
        return bucket.contains({ $0 == value })
    }
    
    func remove(_ value: Value) {
        let bucket = findBucket(value)
        bucket?.remove({ $0 == value })
    }
}

private extension HashSet {
    
    @inline(__always) mutating func findOrCreateBucket(_ value: Value) -> Bucket {
        guard let bucket = findBucket(value) else {
            let newBucket = List<Value>()
            buckets.insert(newBucket, at: _findIndex(value))
            return newBucket
        }
        return bucket
    }
    
    @inline(__always) func findBucket(_ value: Value) -> Bucket? {
        let index = _findIndex(value)
        guard isValid(index) else { return nil }
        return buckets[index]
    }
    
    @inline(__always) func _findIndex(_ value: Value) -> Int {
        let hash = abs(value.hashValue)
        guard hash != 0 else { return 0 }
        guard buckets.count != 0 else { return 0 }
        return hash % buckets.count
    }
    
    @inline(__always) func isValid(_ index: Int) -> Bool {
        return index >= 0 && index < buckets.count
    }
}

