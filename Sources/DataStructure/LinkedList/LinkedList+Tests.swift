//
//  LinkedList+Tests.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 6/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class LinkedListTests: XCTestCase {
    
    func testLinkedListRemoveFirstItem() {
        
        let list = List<Int>()
        list.append(1)
        list.remove({ $0 == 1 })
        XCTAssert(list.contains({ $0 == 1 }) == false)
    }
    
    func testLinkedListRemoveTwoItems() {
        
        let list = List<Int>()
        list.append(1)
        list.append(2)
        list.remove({ $0 == 1 })
        XCTAssert(list.contains({ $0 == 1 }) == false)
        XCTAssert(list.contains({ $0 == 2 }))
        
        list.remove({ $0 == 2 })
        XCTAssert(list.contains({ $0 == 2 }) == false)
        
        list.append(2)
        list.append(1)
        list.remove({ $0 == 2 })
        XCTAssert(list.contains({ $0 == 2 }) == false)
        XCTAssert(list.contains({ $0 == 1 }))
        
        list.remove({ $0 == 1 })
        XCTAssert(list.contains({ $0 == 1 }) == false)
    }
}
