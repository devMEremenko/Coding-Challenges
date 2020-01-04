//
//  AdjacencyList+HashTable.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 10/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/// HashGraph
///
/// It's a graph that is based on a HashTable where:
///
///     key -> vertex
///     value -> array of edges

class HashGraph<Item: Hashable> {
    
    private var nodes = [Item: [Edge<Item>]]()
}

extension HashGraph: Graphable {
    
    func add(_ item: Item) {
        
        if nodes[item] == nil {
            nodes[item] = []
        }
    }
    
    func addEdge(from: Item, to: Item, weight: Double?) {
        
        guard var edges = nodes[from] else { return }
        
        guard !edges.contains(where: { $0.to == to && $0.weight == weight }) else {
            return
        }
        
        edges.append(Edge(to, weight))
        nodes[from] = edges
    }
    
    func weight(from: Item, to: Item) -> Double? {
        
        guard let edges = nodes[from] else { return nil }
        
        return edges.first(where: { $0.to == to })?.weight
    }
    
    var description: String {
        
        var result = ""
        
        for (item, edges) in nodes {
            
            result += "[ \(item) ->"
            
            for (idx, edge) in edges.enumerated() {
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

private struct Edge<Item>: CustomStringConvertible {
    
    var to: Item
    
    var weight: Double?
    
    init(_ to: Item, _ weight: Double?) {
        self.to = to
        self.weight = weight
    }
    
    var description: String {
        return "\(to)" + (weight == nil ? "" : " \(weight!)")
    }
}
