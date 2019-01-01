//
//  Optional+Ext.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 31/12/2018.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

public extension Optional {
    
    var notNil: Bool {
        switch self {
        case .none: return false
        case .some: return true
        }
    }
    
    var isNil: Bool {
        return !notNil
    }
}
