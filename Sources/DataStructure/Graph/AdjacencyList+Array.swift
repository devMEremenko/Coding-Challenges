//
//  AdjacencyList.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 10/22/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class AdjacencyList: XCTestCase {
    
    func test() {
        
        let graph = Graph<String>()
        
        let newYork = Vertex("New York")
        let london = Vertex("London")
        let kiev = Vertex("Kiev")
        let moscow = Vertex("Moscow")
        
        graph.add(newYork)
        graph.add(london)
        graph.add(moscow)
        graph.add(kiev)
        
        graph.addEdge(from: newYork, to: london, weight: 1)
        graph.addEdge(from: london, to: newYork, weight: 1)
        
        graph.addEdge(from: london, to: kiev, weight: 2)
        
        graph.addEdge(from: newYork, to: kiev, weight: 3)
        graph.addEdge(from: kiev, to: newYork, weight: 4)
        
        graph.addEdge(from: kiev, to: moscow, weight: 1)
        graph.addEdge(from: moscow, to: kiev, weight: 1)
        
        graph.addEdge(from: moscow, to: newYork, weight: 6)
    }
}

private struct Vertex<Item: Equatable> {
    
    var value: Item
    
    init(_ value: Item) {
        self.value = value
    }
    
    static func ==(left: Vertex<Item>, right: Vertex<Item>) -> Bool {
        return left.value == right.value
    }
}

private class Edge<Destination> {
    
    var from: Destination
    var to: Destination
    
    var weight: Float?
    
    init(_ from: Destination, _ to: Destination, _ weight: Float? = nil) {
        self.from = from
        self.to = to
        self.weight = weight
    }
}

private class Graph<Item: Equatable> {
    
    typealias Node = Edge<Vertex<Item>>
    
    private lazy var nodes = [Vertex<Item>]()
    private lazy var edges = [Node]()
    
    func add(_ vertex: Vertex<Item>) {
        
        guard !contains(vertex) else { return }
        nodes.append(vertex)
    }
    
    func addEdge(from: Vertex<Item>, to: Vertex<Item>, weight: Float?) {
        
        if let edge = findEdge(from, to) {
            edge.weight = weight
        } else {
            edges.append(Node(from, to, weight))
        }
    }
    
    private func contains(_ vertex: Vertex<Item>) -> Bool {
        return nodes.contains(where: { $0 == vertex })
    }
    
    private func findEdge(_ from: Vertex<Item>, _ to: Vertex<Item>) -> Node? {
        return edges.first(where: { $0.from == from && $0.to == to })
    }
}
