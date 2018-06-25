//
//  Stack.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/13/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

class OwnStack<T> {
    
    typealias Comparison = (T) -> (Bool)
    
    private var items = List<T>()
    
    init() {}
    
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        for element in sequence {
            items.append(element)
        }
    }
    
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: T, value: Int) {
        for (element, _) in sequence {
            items.append(element)
        }
    }
    
    func push(_ value: T) {
        items.append(value)
    }
    
    func pop() {
        items.removeLast()
    }
    
    func pop(_ block: Comparison) {
        items.remove(block)
    }
    
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    var top: T? {
        return items.last
    }
}
