//
//  RouteBetweenNodes_4_1.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 10/22/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class RouteBetweenNodesTests: XCTestCase {
    
    /// Given a directed graph, design an algorithm to find out
    /// whether there is a route between two nodes.
        
    private class GraphNode<Value> {
        var value: Value
        var edges = [GraphNode<Value>]()
        
        init(_ value: Value) {
            self.value = value
        }
    }
    
    func test() {
        
        let node1 = GraphNode(1)
        let node2 = GraphNode(2)
        let node3 = GraphNode(3)
        let node4 = GraphNode(4)
        
        node1.edges = [node2, node3]
        node2.edges = [node3]
        node3.edges = [node4]
        
        //  1--->2    4
        //   \   v   /
        ///   -->3->/
        
        XCTAssertTrue(hasPath(node1, node2))
        XCTAssertTrue(hasPath(node1, node3))
        XCTAssertTrue(hasPath(node1, node4))
        XCTAssertTrue(hasPath(node2, node4))
        
        XCTAssertFalse(hasPath(node3, node2))
        XCTAssertFalse(hasPath(node3, node1))
        XCTAssertFalse(hasPath(node2, node1))
        XCTAssertFalse(hasPath(node4, node3))
        XCTAssertFalse(hasPath(node4, node2))
        XCTAssertFalse(hasPath(node4, node1))
    }
    
    private func hasPath<T: Hashable>(_ fromNode: GraphNode<T>,
                                      _ toNode: GraphNode<T>) -> Bool {
        
        guard !fromNode.edges.isEmpty else { return false }
        
        var queue = List<GraphNode<T>>()
        var visited = [T: Bool]()
        
        queue.addTo(start: fromNode)
        visited[fromNode.value] = true
        
        while !queue.isEmpty {

            let node = queue.removeFirst()!
            guard node.value != toNode.value else { return true }
            
            node.edges.forEach { edge in
                
                guard visited[edge.value] == nil else { return }
                visited[edge.value] = true
                queue.addTo(end: edge)
            }
        }
        
        return false
    }
}

///       1
///     2   2
///    3 3 3 3
///   4444 4444

///     1: [1]
///     2: [2, 2]
///     3: [3, 3, 3, 3]
///     4: [4, 4, 4, 4, 4, 4, 4, 4]
