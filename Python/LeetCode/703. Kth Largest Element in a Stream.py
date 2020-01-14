# https://leetcode.com/problems/kth-largest-element-in-a-stream/submissions/

import heapq

# Initialization: Time O(n*log n), Space O(1)
# Addition: Time: O(k*log k), Space O(1)

class KthLargest:

    def __init__(self, k: int, nums: [int]):
        # 1. Make a heap
        heapq.heapify(nums)
        
        # 2. Make a heap of k max values
        for _ in range(len(nums) - k):
            heapq.heappop(nums)
        
        self.k = k
        self.nums = nums

    def add(self, val: int) -> int:
        # 3. If there is less than k values add the new one to the hap
        if len(self.nums) < self.k:
            heapq.heappush(self.nums, val)
        elif val > self.nums[0]:
            # 4. Add only values that are greather than a min value of max heap
            heapq.heapreplace(self.nums, val)
        return self.nums[0]
    
# Space: O(n)
class KthLargestWithoutSkippingValues:

    def __init__(self, k: int, nums: [int]):
        for idx, item in enumerate(nums): 
            nums[idx] = item * -1
            
        heapq.heapify(nums)
        self.k = k
        self.nums = nums

    def add(self, val: int) -> int:
        heapq.heappush(self.nums, val * -1)
        return heapq.nsmallest(self.k, self.nums)[-1] * -1
