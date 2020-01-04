//
//  CharacterSet+Ext.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 03/02/2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import Foundation

public extension CharacterSet {
    
    func contains(char: Character) -> Bool {
        guard let first = char.unicodeScalars.first else { return false }
        return contains(first)
    }
}
