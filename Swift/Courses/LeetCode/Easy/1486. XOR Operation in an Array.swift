//
// 1486. XOR Operation in an Array.swift
// CodingChallenges
//
// Created on 3/3/21.
//

/// https://leetcode.com/problems/xor-operation-in-an-array/

class LE_XOROperationInAnArray {
    func xorOperation(_ n: Int, _ start: Int) -> Int {
        // solution1(n, start)
        solution2(n, start)
    }
    
    func solution1(_ n: Int, _ start: Int) -> Int {
        let arr = (0..<n).map {
            start + 2 * $0
        }
        var res = arr[0]
        for idx in (1..<arr.count) {
            res ^= arr[idx]
        }
        return res
    }
    
    func solution2(_ n: Int, _ start: Int) -> Int {
        let generator = stride(from: 1, to: n, by: 1)
        return generator.reduce(start) { $0 ^ (start + $1 * 2) }
    }
}
