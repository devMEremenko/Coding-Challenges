//
//  AdjacencyMatrix.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 10/26/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class AdjacencyMatrix: XCTestCase {
    
    func test() {
        
        let graph = Graph<String>()
        
        let newYork = "New York"
        let london = "London"
        let kiev = "Kiev"
        let moscow = "Moscow"
        
        graph.add(newYork)
        graph.add(london)
        graph.add(kiev)
        graph.add(moscow)
        
        graph.addEdge(from: newYork, to: london, weight: 1)
        graph.addEdge(from: london, to: newYork, weight: 1)
        
        graph.addEdge(from: london, to: kiev, weight: 2)
        
        graph.addEdge(from: newYork, to: kiev, weight: 3)
        graph.addEdge(from: kiev, to: newYork, weight: 4)
        
        graph.addEdge(from: kiev, to: moscow, weight: 1)
        graph.addEdge(from: moscow, to: kiev, weight: 1)
        
        graph.addEdge(from: moscow, to: newYork, weight: 6)
        
        graph.printGraph()
    }
}

private struct Vertex<Item: Equatable> {
    
    var value: Item
    let index: Int
    
    init(_ value: Item, index: Int) {
        self.value = value
        self.index = index
    }
}

private class Graph<Item: Hashable> {
    
    private var matrix = [[Double?]]()
    private var nodes = [Item: Vertex<Item>]()
    
    func add(_ item: Item) {
        
        guard nodes[item] == nil else { return }
        
        for idx in stride(from: matrix.count - 1, through: 0, by: -1) {
            var item = matrix[idx]
            item.append(nil)
            matrix[idx] = item
        }
        
        matrix.append(Array(repeating: nil, count: matrix.count + 1))
        nodes[item] = Vertex(item, index: matrix.count - 1)
    }
    
    func addEdge(from: Item, to: Item, weight: Double) {
        
        guard let fromNode = nodes[from] else { return }
        guard let toNode = nodes[to] else { return }
        
        matrix[fromNode.index][toNode.index] = weight
    }
    
    func printGraph() {
        matrix.forEach { row in
            let rows = row.map({ item -> String in
                if let item = item {
                    return "| " + String(item)
                }
                return "| nil"
            })
            print(rows)
        }
    }
}
