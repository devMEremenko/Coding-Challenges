//
//  Extensions.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

public extension String {
    
    subscript(range: Range<Index>) -> String {
        get {
            return String(self[range])
        }
        set {
            replaceSubrange(range, with: newValue)
        }
    }
    
    subscript(index: Int) -> Character {
        get {
            return self[findStringIndex(index)]
        }
        set {            
            let stringIndex = findStringIndex(index)
            remove(at: stringIndex)
            insert(newValue, at: stringIndex)
        }
    }
    
    subscript(range: CountableRange<Int>) -> String {
        get {
            return self[findStringIndexRange(range)]
        }
        set {
            self[findStringIndexRange(range)] = newValue
        }
    }
    
    private func findStringIndex(_ offset: Int) -> Index {
        return index(startIndex, offsetBy: offset)
    }
    
    private func findStringIndexRange(_ range: CountableRange<Int>) -> Range<Index> {
        let start = findStringIndex(range.lowerBound)
        let end = index(start, offsetBy: range.count)
        return start..<end
    }
}

//MARK: - Dictionary

public extension Dictionary where Value: Equatable {
    
    func key(for value: Value) -> [Key] {
        //ATTENTION: use flatMap if you compile it with LeetCode
        return compactMap({ return $0.value == value ? $0.key : nil })
    }
}
