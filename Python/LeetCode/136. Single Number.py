# https://leetcode.com/problems/single-number/submissions/

from collections import Counter

class Solution:
    def singleNumber(self, nums: [int]) -> int:
        # return self.solution1(nums)
        # return self.solution2(nums)
        return self.solution3(nums)
    
    # n XOR n = 0
    def solution3(self, nums):
        res = 0
        for n in nums:
            res ^= n
        return res
    
    # 1, 2, 3  # 1, 2, 2, 3, 3
    # 6 vs 11
    # (6 * 2) - 11 => 1
    def solution2(self, nums):
        return sum(set(nums)) * 2 - sum(nums)
    
    def solution1(self, nums):
        c = Counter(nums)
        for (v, k) in c.items():
            if k == 1:
                return v
        return 0
        