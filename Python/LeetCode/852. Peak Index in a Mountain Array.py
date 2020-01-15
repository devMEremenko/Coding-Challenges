# https://leetcode.com/problems/peak-index-in-a-mountain-array/

class Solution:
    
    # Time O(log n), Space O(1)
    def complex(self, nums: [int]) -> int:
        left = 0
        right = len(nums) - 1
        mid = (left + right) // 2
        
        while nums[mid - 1] >= nums[mid] or nums[mid] <= nums[mid + 1]:
            if nums[mid - 1] >= nums[mid]:
                right = mid - 1
            elif nums[mid] <= nums[mid + 1]:
                left = mid + 1
            mid = (left + right) // 2
        return mid
    
    # Time O(log n), Space O(1)
    def simple(self, nums: [int]) -> int:
        lo, hi = 0, len(nums) - 1
        while lo < hi:
            mi = (lo + hi) // 2
            if nums[mi] < nums[mi + 1]:
                lo = mi + 1
            else:
                hi = mi
        return lo
    
    def peakIndexInMountainArray(self, nums: [int]) -> int:
        # return self.simple(nums)
        return self.complex(nums)
