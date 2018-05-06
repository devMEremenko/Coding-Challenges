//
//  HashMap.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/26/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class HashMapTest: XCTestCase {
    
    func testHashMap_Addition() {
        
        let key = "Key"
        
        var map = HashMap<String, Int>()
        map[key] = 10
        map["AnotherKey"] = 10
        map[key] = 12
        
        XCTAssert(map.findValue(key) == 12)
    }
    
    func testHashMap_Deleting() {
        
        let key = "Key"
        
        var map = HashMap<String, Int>()
        map[key] = 10
        map["AnotherKey"] = 10
        map[key] = 12
        map[key] = nil
        
        XCTAssert(!map.contains(key))
    }
    
    func testHashMap_Contains() {
        
        var map = HashMap<String, Int>()
        map["1"] = 1
        map["2"] = 2
        map["3"] = 3
        map["4"] = 4
        
        map["1"] = 4
        map["2"] = 3
        map["3"] = 2
        map["4"] = 1
        
        XCTAssert(map.contains("1"))
        XCTAssert(map.contains("2"))
        XCTAssert(map.contains("3"))
        XCTAssert(map.contains("4"))
        
        map["1"] = nil
        map["2"] = nil
        map["3"] = nil
        map["4"] = nil
        
        XCTAssert(!map.contains("1"))
        XCTAssert(!map.contains("2"))
        XCTAssert(!map.contains("3"))
        XCTAssert(!map.contains("4"))
    }
}

/// This HashMap is based on Array of Array key-value pairs to store the data.
/// Linked list can be used instead to accelerate the speed of insertion and removing.
/// See HashSet.swift

private struct HashMap<Key: Hashable, Value> {
    
    struct Element {
        let key: Key
        var value: Value?
    }
    
    typealias Bucket = Array<Element>
    fileprivate var buckets = [Bucket?]()
    
    init(capacity: Int = 17) {
        let adjustedCapacity = capacity > 0 ? capacity : 17
        buckets = Array(repeating: nil, count: adjustedCapacity)
    }
    
    /// The number of buckets should be increased when 2/3 of the HashTable is filled.
    mutating func addValue(_ value: Value, forKey: Key) {
        let index = _index(forKey)
        let item = Element(key: forKey, value: value)
        
        guard var bucket = buckets[index] else {
            buckets[index] = Array<Element>(repeating: item, count: 1)
            return
        }
        
        for (idx, var bucketItem) in bucket.enumerated() {
            if bucketItem.key == forKey {
                bucketItem.value = value
                bucket[idx] = bucketItem
                buckets[index] = bucket
                return
            }
        }
        
        bucket.append(item)
        buckets[index] = bucket
    }
    
    mutating func removeValue(forKey: Key) {
        let index = _index(forKey)
        guard var bucket = buckets[index] else { return }
        
        for (idx, bucketItem) in bucket.enumerated() {
            if bucketItem.key == forKey {
                bucket.remove(at: idx)
                buckets[index] = bucket
            }
        }
    }
    
    func findValue(_ forKey: Key) -> Value? {
        let index = _index(forKey)
        guard let bucket = buckets[index] else { return nil }
        
        for bucketItem in bucket {
            if bucketItem.key == forKey {
                return bucketItem.value
            }
        }
        return nil
    }
    
    func contains(_ forKey: Key) -> Bool {
        return findValue(forKey) != nil
    }
}

extension HashMap {
    
    subscript(key: Key) -> Value? {
        get {
            return findValue(key)
        }
        set {
            if let value = newValue {
                addValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
}

private extension HashMap {
    
    @inline(__always) func _index(_ forKey: Key) -> Int {
        return abs(forKey.hashValue) % buckets.count
    }
}
