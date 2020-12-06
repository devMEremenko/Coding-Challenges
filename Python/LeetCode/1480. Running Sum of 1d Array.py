# https://leetcode.com/problems/running-sum-of-1d-array/

class Solution:
    def runningSum(self, nums: [int]) -> [int]:        
        for i in range(1, len(nums)): 
            nums[i] += nums[i - 1]
        return nums
