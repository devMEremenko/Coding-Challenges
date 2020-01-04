//
//  ListOfDepths_4_3.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 19/11/2018.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class ListOfDepthsTests: XCTestCase {
    
    /// List of Depths
    ///
    /// Given a binary tree, design an algorithm which creates
    /// a linked list of all the nodes at each depth.
    /// (e.g., if you have a tree with depth D, you'll have D linked lists).
    
    func test() {
        
        let data = createTree()
        
        let resultMap = makeLists(data.source)
        
        verify(resultMap, data.expected)
    }
    
    private class Node<Value> {
        var value: Value
        var left: Node<Value>?
        var right: Node<Value>?
        
        init(_ value: Value) {
            self.value = value
        }
    }
}

extension ListOfDepthsTests {
    
    /// Time: O(n)
    ///
    /// Space: O(depth)
    ///
    /// It's already assumed that the algorithm requires
    /// an additional memory to store all the lists of O(depth)
    /// and their nodes of O(nodes) by default.
    ///
    /// The size of the hash table will grow as well as the depth
    /// of the source tree. So, it's needed O(depth) to store
    /// all levels as well as a recursion stack.
    
    private typealias Map<T> = [Int: List<Node<T>>]
    
    private func makeLists<T>(_ root: Node<T>) -> Map<T> {
        
        var map = Map<T>()
        makeListsHelper(root, &map, 1)
        return map
    }
    
    private func makeListsHelper<T>(
        _ node: Node<T>,
        _ map: inout Map<T>,
        _ depth: Int)
    {
        if var list = map[depth] {
            list.addTo(end: node)
            map[depth] = list
        } else {
            map[depth] = List(node)
        }
        
        if let left = node.left {
            makeListsHelper(left, &map, depth + 1)
        }
        if let right = node.right {
            makeListsHelper(right, &map, depth + 1)
        }
    }
}

extension ListOfDepthsTests {
    
    private typealias Data<T> = (
        source: Node<T>,
        expected: Dictionary<Int, [T]>
    )
    
    private func createTree() -> Data<Int> {
        
        ///         1
        ///       2   3
        ///     4  5    6
        ///   7        8
        
        let root = Node(1)
        root.left = Node(2)
        root.right = Node(3)
        root.left?.left = Node(4)
        root.left?.right = Node(5)
        root.right?.right = Node(6)
        root.left?.left?.left = Node(7)
        root.right?.right?.left = Node(8)
        
        let map = [1: [1],
                   2: [2, 3],
                   3: [4, 5, 6],
                   4: [7, 8]]
        
        return (root, map)
    }
    
    private func verify(_ result: Map<Int>, _ expected: [Int: [Int]]) {
        
        for (depth, values) in expected {
            
            guard let list = result[depth] else {
                XCTFail("The list of the depth \(depth) should exist")
                return
            }
            
            values.forEach { value in
                XCTAssertTrue(list.contains({ $0.value == value }))
            }
        }
    }
}
