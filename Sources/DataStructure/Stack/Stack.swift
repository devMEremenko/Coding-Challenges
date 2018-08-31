//
//  Stack.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/13/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

class Stack<Item> {
    
    private var list = List<Item>()
    
    init() {}
    
//    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Item {
//        for item in sequence {
//            list.addTo(start: item)
//        }
//    }
//
//    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Item, value: Int) {
//        for (item, _) in sequence {
//            list.addTo(start: item)
//        }
//    }
    
    func push(_ item: Item) {
        list.addTo(start: item)
    }
    
    @discardableResult
    func pop() -> Item? {
        return list.removeFirst()
    }
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    var top: Item? {
        return list.first
    }
}
