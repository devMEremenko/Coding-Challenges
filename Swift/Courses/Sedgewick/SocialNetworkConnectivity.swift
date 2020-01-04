//
//  SocialNetworkConnectivity.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 17.12.2019.
//  Copyright © 2019 Eremenko Maxim. All rights reserved.
//

import XCTest

private typealias PersonID = Int
private typealias Connection = (PersonID, PersonID)

class SocialNetworkConnectivityTests: XCTestCase {
    
    /// Social network connectivity.
    ///
    /// Given a social network containing `n` members and a log file
    /// containing `m` timestamps at which times pairs of members formed friendships.
    ///
    /// Design an algorithm to determine the earliest time at which all members
    /// are connected (i.e., every member is a friend of a friend ... of a friend).
    /// Assume that the log file is sorted by timestamp and that friendship
    /// is an equivalence relation.
    ///
    /// The running time of your algorithm should be `m log⁡ n` or better
    /// and use extra space proportional to `n`.
    
    func test_earliestConnectionTime_oddConnections() {
        let members = [0, 1, 2, 3]
        let connections = [
            Connection(0, 1),
            Connection(2, 3),
            Connection(1, 3),
        ]
        let sut = SocialNetworkConnectivity(members: members, connections: connections)
        XCTAssertEqual(sut.earliestConnectionTime(), 3)
    }
    
    func test_earliestConnectionTime_evenConnections() {
        let members = [0, 1, 2, 3, 4]
        let connections = [
            Connection(0, 1),
            Connection(2, 3),
            Connection(1, 2),
            Connection(3, 4),
        ]
        let sut = SocialNetworkConnectivity(members: members, connections: connections)
        XCTAssertEqual(sut.earliestConnectionTime(), 4)
    }
    
    func test_earliestConnectionTime_graphIsNotConnected() {
        let members = [0, 1, 2, 3]
        let connections = [
            Connection(0, 1),
            Connection(2, 3),
        ]
        let sut = SocialNetworkConnectivity(members: members, connections: connections)
        XCTAssertNil(sut.earliestConnectionTime())
    }
}

private struct SocialNetworkConnectivity {
    
    let members: [PersonID]
    let connections: [Connection]
    
    func earliestConnectionTime() -> Int? {
        var graph = UnionFind(count: members.count)
        for (index, (first, second)) in connections.enumerated() {
            graph.union(first, second)
            if graph.isAllConnected {
                return index.oneBased
            }
        }
        return nil
    }
}

private extension UnionFind {
    
    var isAllConnected: Bool {
        var numberOfRoots = 0
        for (index, _) in items.enumerated() {
            if items[index] == index {
                numberOfRoots += 1
            }
            if numberOfRoots >= 2 {
                return false
            }
        }
        return true
    }
}

private extension Int {
    
    var oneBased: Int {
        return self + 1
    }
}
