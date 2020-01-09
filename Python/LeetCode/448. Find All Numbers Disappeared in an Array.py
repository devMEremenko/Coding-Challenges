# https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/

class Solution:
    def findDisappearedNumbers(self, nums: [int]) -> [int]:
        for item in nums:
            idx = abs(item) - 1
            nums[idx] = -abs(nums[idx])
            
        return [idx + 1 for idx, value in enumerate(nums) if value > 0]