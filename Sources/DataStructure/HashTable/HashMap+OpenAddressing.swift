//
//  HashMap+OpenAddressing.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/* TODO:
    HashTable based on open addressing (with double hashing).
 */

/*
@inline(__always) private func _index(for key: Key) -> Int {
    return abs(key.hashValue) % buckets.count
}

@inline(__always) private func _offset(for key: Key, after index: Int) -> Int {
    let constant = buckets.count - 1
    let steps = constant - index % constant
    let adjustedSteps = steps > 0 ? steps : 1
    return (index + adjustedSteps) % buckets.count
}
*/
