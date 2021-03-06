//
// 997. Find the Town Judge.swift
// CodingChallenges
//
// Created on 3/4/21.
//

/// https://leetcode.com/problems/find-the-town-judge/

import Foundation

class LE_FindTheTownJudge {
    func findJudge(_ n: Int, _ trust: [[Int]]) -> Int {
        // return solution1(n, trust)
        return solution2(n, trust)
    }
    
    
    func solution2(_ n: Int, _ trust: [[Int]]) -> Int {
        var candidates = Array(repeating: 0, count: n)
        
        for pair in trust {
            let left = pair[0] - 1
            let right = pair[1] - 1
            
            if candidates[right] != -1 {
                candidates[right] += 1
            }
            candidates[left] = -1
        }
        
        guard let index = candidates.firstIndex(of: n - 1) else {
            return -1
        }
        return index + 1
    }
    
    func solution1(_ n: Int, _ trust: [[Int]]) -> Int {
        var candidates = [Int: Int]()
        
        for item in (1...n) {
            candidates[item] = 0
        }
        
        for pair in trust {
            candidates[pair[0], default: 0] -= 1
            candidates[pair[1], default: 0] += 1
        }
        
        return candidates.first { $0.value == n - 1 }?.key ?? -1
    }
}
