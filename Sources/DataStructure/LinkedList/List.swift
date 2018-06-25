//
//  LinkedList.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

class List<T> {
    
    public class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        weak var previous: LinkedListNode?
        
        public init(_ value: T) {
            self.value = value
        }
    }
    
    public typealias Node = LinkedListNode<T>
    
    private var head: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: T? {
        return head?.value
    }
    
    public var last: T? {
        return lastNode?.value
    }
    
    fileprivate var firstNode: Node? {
        return head
    }
    
    fileprivate var lastNode: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    typealias Comparison = (T) -> (Bool)
    
    public func contains(_ block: Comparison) -> Bool {
        var temp = head
        while let unwrappedHead = temp {
            if block(unwrappedHead.value) {
                return true
            }
            temp = unwrappedHead.next
        }
        return false
    }
    
    public func append(_ value: T) {
        let newNode = Node(value)
        if let lastNode = lastNode {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public func removeLast() {
        guard head?.next != nil else {
            head = nil
            return
        }
        
        var temp = head
        
        while temp?.next != nil {
            temp = temp?.next
        }
        
        //TODO: implement previous
        
        let previous = temp?.previous
        previous?.next = nil
    }
    
    public func remove(_ block: Comparison) {
        
        guard let value = head?.value else {
            return
        }
        
        if block(value) {
            head = head?.next
            return
        }
        
        var temp = head?.next
        var previous = head
        
        while let value = temp?.value {
            if block(value) {
                previous?.next = temp?.next
                break
            } else {
                previous = temp
                temp = temp?.next
            }
        }
    }
}
