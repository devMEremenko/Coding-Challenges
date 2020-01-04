# https://leetcode.com/problems/merge-sorted-array/

class Solution:

    # [1, 2, 2, 3, 5, 6], m = 3
    # [2, 5, 6], n = 3
    
    # [2, 0]
    # [1]
    
    # [1, 2, 0]
    # [4]
    
    def merge(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        """
        Do not return anything, modify nums1 in-place instead.
        """        
        
        if not nums1 or not nums2:
            return
        
        # Note: m and n are `number of steps`, not indices, 
        #       that is why > is used rather than >=
        while n > 0 and m > 0:
            if nums1[m-1] <= nums2[n-1]:
                nums1[m+n-1] = nums2[n-1]
                n -= 1
            else:
                nums1[m+n-1] = nums1[m-1]
                m -= 1
                
        if n > 0:
            nums1[:n] = nums2[:n]
