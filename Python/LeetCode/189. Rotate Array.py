# https://leetcode.com/problems/rotate-array/

from itertools import chain
from itertools import islice

class Solution:
    
    # 1. Reverse all items of the array
    # 2. Reverse items from 0 to k - 1
    # 3. Reverse items from k to count - 1
    # Time: O(n), Space: O(1)
    def rotate_by_reversion(self, nums: [int], k: int) -> None:
        count = len(nums)
        k = k % count # If k is greater than a length of the array
        
        for i in range(count // 2):
            j = count - 1 - i
            (nums[j], nums[i]) = (nums[i], nums[j])
        
        for i in range(k // 2):
            j = k - 1 - i
            (nums[i], nums[j]) = (nums[j], nums[i])

        for i in range((count - k) // 2):
            j = count - 1 - i 
            (nums[i + k], nums[j]) = (nums[j], nums[i + k])
    
    # Update items in (n-k: end) and (start: n-k)
    # Time: O(n), Space(1)
    def rotate_by_reversion_pythonic(self, nums: [int], k: int) -> None:
        n = len(nums)
        k = k % n
        
        # In case of slicing space is O(n) due to copying
        # nums[:] = nums[n-k:] + nums[:n-k]
        
        # To avoid copying, there are 2 iterators that are traversed one by one
        nums[:] = chain(islice(nums, n-k, n), islice(nums, None, n-k))
    
    # 1. Store 'temp' value at `next` index
    # 2. Replace value at `next` index with a `prev` value
    # 3. Update `prev` value with a temp variable
    # Time: O(n), Space: O(1)
    def rotate_inplace(self, nums: [int], k: int) -> None:
        count = 0
        start = 0
        while count < len(nums):
            current = start 
            prev = nums[start] #store the value in the position
            
            while True:
                next = (current + k) % len(nums) 
                temp = nums[next] #store it temporaly 
                nums[next] = prev #overide the next 
                prev = temp #reset prev
                current = next #reset current
                count += 1

                if start == current:
                    break 
            start += 1
        
    def rotate(self, nums: [int], k: int) -> None:
        if not nums or k < 1:
            return
        
        # Solution 1
        # self.rotate_by_reversion(nums, k)
        
        # Solution 2
        # self.rotate_by_reversion_pythonic(nums, k)
        
        # Solution 3
        self.rotate_inplace(nums, k)
        
        # Solution 4
        # Form a new array in the correct order

# Driver
nums = [1, 2, 3]        
Solution().rotate(nums, 2)
print(nums)

# Input: [1, 2, 3, 4, 5]
# k = 2

# start: 3, end: 5
# print(*islice(nums, n-k, n)) -> [4, 5]

# Input: [1]
# k = 1

# start: None->0, end: 0
# print(*islice(nums, None, n-k)) -> []
