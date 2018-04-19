//
//  Extensions.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

//MARK: - String

public extension String {
    
    subscript (from: Int, to: Int) -> String? {
        
        guard !isEmpty else { return nil }
        
        guard let _fromIndex = index(startIndex, offsetBy: from, limitedBy: endIndex) else {
            return nil
        }
        guard let _toIndex = index(startIndex, offsetBy: from + to, limitedBy: endIndex) else {
            return nil
        }
        return String(self[_fromIndex..._toIndex])
    }
}

public extension String {
    
    subscript (idx: Int) -> Character {
        return self[index(startIndex, offsetBy: idx)]
    }
}

//MARK: - Dictionary

public extension Dictionary where Value: Equatable {
    
    func key(for value: Value) -> [Key] {
        //ATTENTION: use flatMap if you compile it with LeetCode
        return compactMap({ return $0.value == value ? $0.key : nil })
    }
}
