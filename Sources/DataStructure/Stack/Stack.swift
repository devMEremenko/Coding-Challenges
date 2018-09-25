//
//  Stack.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/13/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

struct Stack<Item> {
    
    private lazy var list = List<Item>()
    private(set) var size = 0
    
    init() {}
    
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Item {
        size = sequence.underestimatedCount
        for item in sequence {
            list.addTo(start: item)
        }
    }

    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Item, value: Int) {
        size = sequence.underestimatedCount
        for (item, _) in sequence {
            list.addTo(start: item)
        }
    }
    
    mutating func push(_ item: Item) {
        size += 1
        list.addTo(start: item)
    }
    
    @discardableResult
    mutating func pop() -> Item? {
        size = size > 0 ? size - 1 : 0 
        return list.removeFirst()
    }
    
    var isEmpty: Bool {
        mutating get { return list.isEmpty }
    }
    
    var top: Item? {
        mutating get { return list.first }
    }
}
