# https://leetcode.com/problems/two-sum/

class Solution:
    def twoSum(self, nums: [int], target: int) -> [int]:
        m = {}
        for idx, item in enumerate(nums):
            complement = target - item
            if complement in m:
                return [m[complement], idx]
            else:
                m[item] = idx
        return []
