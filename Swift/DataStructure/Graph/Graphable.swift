//
//  Graphable.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 10/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Graphable is an abstract interface for all types of graphs

protocol Graphable: CustomStringConvertible {
    
    associatedtype Item: Hashable
    
    func add(_ item: Item)
    
    func addEdge(from: Item, to: Item, weight: Double?)
    
    func weight(from: Item, to: Item) -> Double?
}

class GraphableTests: XCTestCase {
    
    func testAddItem() {
        
        use(graph: HashGraph<String>())
        use(graph: MatrixGraph<String>())
        use(graph: ArrayGraph<String>())
    }
    
    func use<T: Graphable>(graph: T) where T.Item == String {
        
        let newYork = "New York"
        let london = "London"
        let kiev = "Kiev"
        let moscow = "Moscow"
        
        graph.add(newYork)
        graph.add(london)
        graph.add(kiev)
        graph.add(moscow)
        
        graph.addEdge(from: newYork, to: london, weight: 1)
        
        graph.addEdge(from: london, to: kiev, weight: 2)
        graph.addEdge(from: kiev, to: london, weight: 2)
        
        graph.addEdge(from: newYork, to: kiev, weight: 3)
        graph.addEdge(from: kiev, to: newYork, weight: 4)
        
        graph.addEdge(from: kiev, to: moscow, weight: 1)
        
        graph.addEdge(from: moscow, to: newYork, weight: 6)
        graph.addEdge(from: newYork, to: moscow, weight: 6)
        
        print(graph.description)
    }
}
