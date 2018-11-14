//
//  BSTDictionary.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 8/30/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class BSTKeyValueExample: XCTestCase {
    
    func test() {
        
        var dictionary = BSTDictionary(key: "7", value: 7)
        dictionary["4"] = 4
        dictionary["8"] = 8
        dictionary["1"] = 1
        dictionary["5"] = 5
        dictionary["0"] = 0
        dictionary["2"] = 2
        dictionary["4"] = 4
        dictionary["3"] = 3
        dictionary["6"] = 6
        
        var keys = [String]()
        var values = [Int]()
        
        dictionary.inOrder { key, value in
            keys.append(key)
            values.append(value)
        }
        
        for item in 0...8 {
            XCTAssert(values[item] == item)
            XCTAssert(keys[item] == String(item))
        }
    }
    
    func testBST() {
        
        /// TODO: fix deletion for that case
        
        var binaryTree = BSTDictionary(key: 123, value: Car("Red"))
        
        binaryTree[99] = Car("Blue")
        binaryTree[126] = Car("Green")
        binaryTree[44] = Car("Yellow")
        binaryTree[32] = Car("Mini")
        binaryTree[234] = Car("Big car")
        binaryTree[432] = Car("A bus")
        binaryTree[104] = Car("Jeep")
        binaryTree[100] = Car("Batmobile")
        binaryTree[101] = Car("Sedan")
        binaryTree[105] = Car("Firetruck")
        
        print("::::::::::Testing subscript::::::::::")
        /// print("Blue car: ", binaryTree[99]?.name)
        
        binaryTree[99] = Car("Not Blue")
        
        /// print("Blue car: ", binaryTree[99]?.name)
        
        print(binaryTree)
        binaryTree[99] = nil
        
        /// print("Blue car: ", binaryTree[99]?.name)
        
        print("::::::::::Testing min/max::::::::::")
        /// let value = binaryTree.minValue()
        /// print("MIN car: ", binaryTree[binaryTree.minKey()!]?.name)
        /// print("MAX car: ", binaryTree[binaryTree.maxKey()!]?.name)
        
        print("::::::::::Delete max::::::::::")
        binaryTree[432] = nil
        XCTAssert(binaryTree.maxKey() == nil)
    }
}

class Car {
    
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

struct BSTDictionary<Key: Comparable, Value> {
    
    var root: Node? /// This is not marked as 'private' because it is used by BFS DFS.
    
    init() {}
    
    init(key: Key, value: Value) {
        self.root = Node(key, value)
    }
    
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
        for (key, value) in sequence {
            put(value, for: key)
        }
    }
    
    class Node {
        var key: Key
        var value: Value
        var left: Node?
        var right: Node?
        
        init(_ key: Key, _ value: Value) {
            self.key = key
            self.value = value
        }
        
        func inOrder(_ block: Traverse) {
            left?.inOrder(block)
            block(key, value)
            right?.inOrder(block)
        }
        
        var description: String {
            var s = ""
            if let left = left {
                s += "(\(left.description)) <- "
            }
            s += "\(value)" + " \(key)"
            if let right = right {
                s += " -> (\(right.description))"
            }
            return s
        }
    }
}

extension BSTDictionary {
    
    mutating func put(_ value: Value, for key: Key) {
        root = put(value: value, key: key, node: root)
    }
    
    private func put(value: Value, key: Key, node: Node?) -> Node {
        guard let node = node else { return Node(key, value) }
        
        if key < node.key {
            node.left = put(value: value, key: key, node: node.left)
        } else if key > node.key {
            node.right = put(value: value, key: key, node: node.right)
        } else {
            node.value = value
        }
        
        return node
    }
}

extension BSTDictionary {
    
    func value(for key: Key) -> Value? {
        return value(for: key, node: root)
    }
    
    private func value(for key: Key, node: Node?) -> Value? {
        guard let node = node else { return nil }
        
        if key < node.key {
            return value(for: key, node: node.left)
        } else if key > node.key {
            return value(for: key, node: node.right)
        } else {
            return node.value
        }
    }
}

extension BSTDictionary {
    
    mutating func delete(_ key: Key) {
        root = delete(key, node: root)
    }
    
    private func delete(_ key: Key, node: Node?) -> Node? {
        guard let node = node else { return nil }
        
        if key < node.key {
            node.left = delete(key, node: node.left)
        } else if key > node.key {
            node.right = delete(key, node: node.right)
        }
        
        guard let left = node.left else { return nil }
        
        let maxNode = max(node: left)
        maxNode.right = node.right
        return maxNode /// maxNode will become a new parent
    }
}

extension BSTDictionary {

    subscript(key: Key) -> Value? {
        get {
            return value(for: key)
        }
        set {
            if let value = newValue {
                put(value, for: key)
            } else {
                delete(key)
            }
        }
    }
    
    private func min(node: Node) -> Node {
        var minimum = node
        while let next = minimum.left {
            minimum = next
        }
        return minimum
    }
    
    private func max(node: Node) -> Node {
        var maximum = node
        while let next = maximum.right {
            maximum = next
        }
        return maximum
    }
}

extension BSTDictionary {
    
    typealias Traverse = (Key, Value) -> ()
    
    func inOrder(_ block: Traverse) {
        root?.inOrder(block)
    }
}

extension BSTDictionary: CustomStringConvertible {
    
    var description: String {
        return root?.description ?? ""
    }
}

// MARK: - Debug

private extension BSTDictionary {
    
    func minValue() -> Value? {
        guard let rootNode = root else { return nil }
        return min(node: rootNode).value
    }
    
    func maxValue() -> Value? {
        guard let rootNode = root else { return nil }
        return max(node: rootNode).value
    }
    
    func minKey() -> Key? {
        guard let rootNode = root else { return nil }
        return min(node: rootNode).key
    }
    
    func maxKey() -> Key? {
        guard let rootNode = root else { return nil }
        return max(node: rootNode).key
    }
}
