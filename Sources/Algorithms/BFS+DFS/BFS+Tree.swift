//
//  BFS+Tree.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 9/2/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

private class BFSTreeTests: XCTestCase {
    
    func testBFS() {
        
        var tree = BSTDictionary<String, Int>()
        tree["3"] = 3
        tree["4"] = 4
        tree["2"] = 2
        tree["5"] = 5
        tree["1"] = 1
        
        var keys = [String]()
        var values = [Int]()
        
        tree.traverseBFS {
            keys.append($0)
            values.append($1)
        }
        
        XCTAssert(keys == ["3", "2", "4", "1", "5"])
        XCTAssert(values == [3, 2, 4, 1, 5])
    }
}

extension BSTDictionary {
    
    typealias Traversal = (Key, Value) -> Void
    
    func traverseBFS(_ block: Traversal) {
        
        guard let root = self.root else { return }
        
        var queue = List<Node>(root)
        
        while !queue.isEmpty {
            
            for node in queue {
                
                block(node.key, node.value)
                queue.removeFirst()
                
                if let left = node.left {
                    queue.addTo(end: left)
                }
                
                if let right = node.right {
                    queue.addTo(end: right)
                }
            }
        }
    }
}
