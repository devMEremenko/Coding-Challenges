//
//  AdjacencyList.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 10/22/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/// ArrayGraph
///
/// It's a graph that is based on array of vertexes and edges

class ArrayGraph<Item: Hashable> {
    
    private(set) lazy var nodes = [Item]()
    private lazy var edges = [Edge<Item>]()
    
    private func contains(_ vertex: Item) -> Bool {
        return nodes.contains(where: { $0 == vertex })
    }
    
    private func findEdge(_ from: Item, _ to: Item) -> Edge<Item>? {
        return edges.first(where: { $0.from == from && $0.to == to })
    }
    
    private func findAllEdges(of node: Item) -> [Edge<Item>] {
        return edges.filter({ $0.from == node })
    }
}

extension ArrayGraph: Graphable {
    
    func add(_ item: Item) {
        guard !contains(item) else { return }
        nodes.append(item)
    }
    
    func addEdge(from: Item, to: Item, weight: Double?) {
        if let edge = findEdge(from, to) {
            edge.weight = weight
        } else {
            edges.append(Edge(from, to, weight))
        }
    }
    
    func weight(from: Item, to: Item) -> Double? {
        return findEdge(from, to)?.weight
    }
    
    var description: String {
        var result = ""
        
        for item in nodes {
            result += "[ \(item) ->"
            
            let allEdges = findAllEdges(of: item)
            for (idx, edge) in allEdges.enumerated() {
                if idx == edges.count - 1 {
                    result += " \(edge)"
                } else {
                    result += " \(edge), "
                }
            }
            result += " ]\n"
        }
        
        return result
    }
}

private class Edge<Item> {
    
    var from: Item
    var to: Item
    
    var weight: Double?
    
    init(_ from: Item, _ to: Item, _ weight: Double? = nil) {
        self.from = from
        self.to = to
        self.weight = weight
    }
}
