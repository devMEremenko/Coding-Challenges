//
//  TwoSum_1.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 4/10/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class TwoSum_1: XCTestCase {
    
    /*
     https://leetcode.com/problems/two-sum/description/
     
     Solution 1
     
     Time complexity O(n)
     Space complexity O(1)
     
     Iterate over all values (with nested loop) and compare their sum with a target.
     
     
     Solution 2
     Time complexity O(1)
     Space complexity O(n)
     
     1) Iterate over all values
     2) Calculate 'next' item (target - currentItem)
     3) Place result in the HashTable
     4) Do not forget to check stored value at the beginning
     
     Details:
     1) Create a HashTable.
     2) Run through a loop of source values.
     3) Calculate result of subtraction (target - iterated value).
     4) Read a value from the hash table using the calculated result as a key.
     5) If hash table returns a value - use it as a resulting index.
     6) If a result does not exist, put the current iterated value to the hast table.
     
     */
    
    func testTwoSum_1() {
        
        let sources = generateSources()
        let values = sources.0
        let target = sources.1
        
        let check: (Int?, Int?) -> () = { first, second in
            XCTAssert(first == values.count - 2 && second == values.count - 1)
        }
        
        let bruteResults = twoSumBruteForce1(values, target)
        check(bruteResults?.first, bruteResults?.last)
        
        let mappingResults = twoSumWithHashTable2(values, target)
        check(mappingResults?.first, mappingResults?.last)
    }
    
    //MARK: Solution 1
    
    func twoSumBruteForce1(_ nums: [Int], _ target: Int) -> [Int]? {
        
        for idx1 in 0...(nums.count - 2)  {
            let i = nums[idx1]
            for idx2 in (idx1 + 1)...(nums.count - 1) {
                let j = nums[idx2]
                
                guard i + j == target else { continue }
                
                return [idx1, idx2]
            }
        }
        return nil
    }
    
    
    //MARK: Solution 2
    
    func twoSumWithHashTable2(_ nums: [Int], _ target: Int) -> [Int]? {
        
        var map = [Int: Int]()
        
        for (idx, i) in nums.enumerated() {
            
            let key = target - i
            if let storedValue = map[key] {
                return [storedValue, idx]
            }
            map.updateValue(idx, forKey: i)
        }
        
        return nil
    }
    
    
    //MARK: Helpers
    
    func generateSources() -> ([Int], Int) {
        
        let first = 999999
        let second = 8888888
        
        let target = first + second
        
        var values = Set<Int>()
        
        for _ in 0...arc4random_uniform(5000) {
            values.update(with: Int(arc4random_uniform(5000)))
        }
        var results = Array(values)
        results.append(first)
        results.append(second)
        
        return (results, target)
    }
}

extension TwoSum_1 {
    
    /// Time: O(n)
    /// Space: O(n)
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int: Int](minimumCapacity: nums.count)
        for (index, num) in nums.enumerated() {
            if let storedIndex = dict[target - num], storedIndex != index {
                return [storedIndex, index]
            }
            dict[num] = index
        }
        return []
    }
}
