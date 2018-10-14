//
//  PriorityQueue.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/16/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class PriorityQueueTests: XCTestCase {
    
    func test() {
        
        let node1 = Node<String, Int>("first", priority: 1)
        let node2 = Node<String, Int>("second", priority: 2)
        
        let heap = Heap<Node>(sort: { $0.priority > $1.priority },
                              array: [node1, node2])
        
        XCTAssert(heap.poll()! == node2)
        XCTAssert(heap.poll()! == node1)
    }
}

private class Node<T, P: Equatable> {
    
    var priority: P
    var value: T
    
    init(_ value: T, priority: P) {
        self.value = value
        self.priority = priority
    }
}

extension Node where T: Equatable {
    
    static func == (left: Node<T, P>, right: Node<T, P>) -> Bool {
        return left.value == right.value && left.priority == right.priority
    }
}
