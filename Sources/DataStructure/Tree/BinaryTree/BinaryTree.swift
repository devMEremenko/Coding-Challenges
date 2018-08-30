//
//  BinaryTree.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 7/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class BinaryTreeTests: XCTestCase {
    
    func testSum() {
        
        let one = BinaryTree.node(.empty, 1, .empty)
        let two = BinaryTree.node(.empty, 2, .empty)
        let amount = BinaryTree.node(one, 0, two)
        
        XCTAssert(amount.sum == 3)
    }
    
    func testCount() {
        
        let one = BinaryTree.node(.empty, 1, .empty)
        let two = BinaryTree.node(one, 2, one)
        let amount = BinaryTree.node(two, 0, two)
        
        XCTAssert(amount.count == 7)
    }
    
    func testPreOrder() {
        
        let one = BinaryTree.node(.empty, 1, .empty)
        let two = BinaryTree.node(one, 2, one)
        let amount = BinaryTree.node(two, 0, two)
        
        var source = [Int]()
        amount.preOrder { value in
            source.append(value)
        }
        
        let result = [0, 2, 1, 1, 2, 1, 1]
        XCTAssert(result == source)
    }
    
    func testInOrder() {
        
        let one = BinaryTree.node(.empty, 1, .empty)
        let two = BinaryTree.node(one, 2, one)
        let amount = BinaryTree.node(two, 0, two)
        
        var source = [Int]()
        amount.inOrder { value in
            source.append(value)
        }
        
        let result = [1, 2, 1, 0, 1, 2, 1]
        XCTAssert(result == source)
    }
    
    func testPostOrder() {
        
        let one = BinaryTree.node(.empty, 1, .empty)
        let two = BinaryTree.node(one, 2, one)
        let amount = BinaryTree.node(two, 0, two)
        
        var source = [Int]()
        amount.postOrder { value in
            source.append(value)
        }
        
        let result = [1, 1, 2, 1, 1, 2, 0]
        XCTAssert(result == source)
    }
}

private indirect enum BinaryTree<T> {
    
    case node(BinaryTree<T>, T, BinaryTree<T>)
    case empty
}

extension BinaryTree where T == Int {
    
    var sum: Int {
        switch self {
        case let .node(left, value, right):
            return left.sum + value + right.sum
        case .empty: return 0
        }
    }
}

extension BinaryTree {
    
    var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty: return 0
        }
    }
}

extension BinaryTree {
    
    typealias Traverse = (T) -> ()
    
    func inOrder(_ block: Traverse) {
        switch self {
        case let .node(left, value, right):
            left.inOrder(block)
            block(value)
            right.inOrder(block)
        case .empty: break
        }
    }
    
    func preOrder(_ block: Traverse) {
        switch self {
        case let .node(left, value, right):
            block(value)
            left.preOrder(block)
            right.preOrder(block)
        case .empty: break
        }
    }
    
    func postOrder(_ block: Traverse) {
        switch self {
        case let .node(left, value, right):
            left.postOrder(block)
            right.postOrder(block)
            block(value)
        case .empty: break
        }
    }
}
