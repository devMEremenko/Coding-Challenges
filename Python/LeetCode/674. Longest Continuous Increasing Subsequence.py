# https://leetcode.com/problems/longest-continuous-increasing-subsequence/

class Solution:
    def findLengthOfLCIS(self, nums: [int]) -> int:
        length = 0
        maxLength = 0
        for idx, item in enumerate(nums): 
            if idx == 0 or item > nums[idx - 1]:
                length += 1
                maxLength = max(length, maxLength)
            else:
                length = 1
        return maxLength
