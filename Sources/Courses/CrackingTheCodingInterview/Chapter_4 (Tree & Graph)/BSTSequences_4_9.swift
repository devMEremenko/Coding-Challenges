//
//  BSTSequences_4_9.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 31/12/2018.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class BSTSequences_4_9: XCTestCase {
    
    /// A binary search tree was created by traversing through an array
    /// from left to right and inserting each element.
    ///
    /// Given a binary search tree with distinct elements,
    /// print all possible arrays that could have led to this tree.
    
    func test_allBSTSequences_with_smallBST() {
        
        /// [in progress]
        
        // let input = makeSmallBST()
        
        // let result = allBSTSequences(input.source)
        
        // XCTAssertTrue(result == input.expected)
    }
}

extension BSTSequences_4_9 {
    
    private func allBSTSequences(_ node: Node<Int>?) -> [[Int]] {
        
        guard let node = node else { return [[Int]()] }
        
        var prefix = [node.value]
        var result = [[Int]]()
        
        let left = allBSTSequences(node.left)
        let right = allBSTSequences(node.right)
        
        for var leftList in left {
            for var rightList in right {
                var weaved = [[Int]]()
                weaveLists(&leftList, &rightList, &weaved, &prefix)
                result.append(contentsOf: weaved)
            }
        }
        return result
    }
    
    private func weaveLists(_ left: inout [Int],
                            _ right: inout [Int],
                            _ results: inout [[Int]],
                            _ prefix: inout [Int]) {
        if left.isEmpty || right.isEmpty {
            var list = prefix
            list.append(contentsOf: left)
            list.append(contentsOf: right)
            results.append(list)
            return
        }
        
        let firstItem = left[safe: 0]
        if firstItem.notNil {
            prefix.append(firstItem!)
        }
        weaveLists(&left, &right, &results, &prefix)
        _ = prefix.popLast()
        if firstItem.notNil {
            left.insert(firstItem!, at: 0)
        }
        
        let secondItem = right[safe: 0]
        if secondItem.notNil {
            prefix.append(secondItem!)
        }
        weaveLists(&left, &right, &results, &prefix)
        _ = prefix.popLast()
        if secondItem.notNil {
            right.insert(secondItem!, at: 0)
        }
    }
}

extension BSTSequences_4_9 {
    
    private class Node<Value> {
        var value: Value
        var left: Node<Value>?
        var right: Node<Value>?
        
        init(_ value: Value) {
            self.value = value
        }
    }
}

extension BSTSequences_4_9 {
    
    private typealias Input = (source: Node<Int>, expected: [[Int]])
    
    private func makeSmallBST() -> Input {
        
        ///           7
        ///      5         9
        ///    3  6
        
        let bst = Node(7)
        bst.left = Node(5)
        bst.left?.left = Node(3)
        bst.left?.right = Node(6)
        bst.right = Node(9)
        
        let expected: [[Int]] = [
            [7, 5, 3, 6, 9],
            [7, 5, 6, 3, 9],
            [7, 9, 5, 3, 6],
            [7, 9, 5, 6, 3],
        ]
        
        return (bst, expected)
    }
    
    private func makeBigBST() -> Input {
        
        ///           7
        ///      5         9
        ///    3  6      8    11
        //   2  4      8     10 12
        
        let bst = Node(7)
        bst.left = Node(5)
        bst.left?.left = Node(3)
        bst.left?.right = Node(6)
        bst.left?.left?.left = Node(2)
        bst.left?.left?.right = Node(4)
        
        bst.right = Node(9)
        bst.right?.left = Node(8)
        bst.right?.right = Node(11)
        bst.right?.right?.left = Node(10)
        bst.right?.right?.right = Node(12)
        
        return (bst, [])
    }
}

private extension Array where Element == List<Int> {
    
    static func ==(left: [List<Int>], right: [List<Int>]) -> Bool {
        guard left.count == right.count else { return false }
        
        for idx in 0...left.count {
            guard left[idx] == right[idx] else { return false }
        }
        
        return true
    }
}

private extension Array {
    
    subscript(safe idx: Int) -> Element? {
        guard idx >= 0 && idx < count else { return nil }
        return self[idx]
    }
}
