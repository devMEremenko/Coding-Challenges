# https://leetcode.com/problems/majority-element/

class Solution:
    
    # Input:
    # 1 1 | 2 2 2 | 3 3 3 3 3
    
    # Time: O(n), Space: O(1)
    def boyerMoreSolution(self, nums: List[int]) -> int:
        count = 0
        candidate = None
        
        for item in nums:
            if count == 0:
                candidate = item
            count = count + 1 if candidate == item else count - 1
        
        # Verifying: Source array mat not contain a mojority element
        #
        # occ = 0
        # for item in nums:
        #   occ = occ + 1 if item == candidate else occ - 1
        # return candidate if occ > len(nums) // 2 else 0
            
        return candidate
    
    # Time: O(n*log n), Space: O(1)
    def sortingSolution(self, nums: List[int]) -> int:
        nums.sort()
        return nums[len(nums) // 2] #Majority item is 100% in the middle
    
    def majorityElement(self, nums: List[int]) -> int:
        return self.boyerMoreSolution(nums)
