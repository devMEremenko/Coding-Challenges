//
//  AdjacencyMatrix.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 10/26/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/// MatrixGraph
///
/// It's a common implementation of Adjacency Matrix.
///
/// `matrix` -> 2D array that stores weight of edges.
/// `nodes`  -> hash table that stores a relationship
///             between an item and index in the 'matrix' array

class MatrixGraph<Item: Hashable> {
    
    typealias MatrixIndex = Int
    
    private var matrix = [[Double?]]()
    private var nodes = [Item: MatrixIndex]()
}

extension MatrixGraph: Graphable {
    
    func add(_ item: Item) {
        
        guard nodes[item] == nil else { return }
        
        for idx in stride(from: matrix.count - 1, through: 0, by: -1) {
            var item = matrix[idx]
            item.append(nil)
            matrix[idx] = item
        }
        
        matrix.append(Array(repeating: nil, count: matrix.count + 1))
        nodes[item] = MatrixIndex(matrix.count - 1)
    }
    
    func addEdge(from: Item, to: Item, weight: Double?) {
        
        guard let fromIndex = nodes[from] else { return }
        guard let toIndex = nodes[to] else { return }
        
        matrix[fromIndex][toIndex] = weight
    }
    
    func weight(from: Item, to: Item) -> Double? {
        
        guard let fromIndex = nodes[from] else { return nil }
        guard let toIndex = nodes[to] else { return nil }
        
        return matrix[fromIndex][toIndex]
    }
    
    var description: String {
        var result = ""
        matrix.forEach { row in
            row.forEach({ item in
                if let item = item {
                    result += "| " + String(item)
                } else {
                    result += "| nil"
                }
            })
        }
        return result
    }
}
