# https://leetcode.com/problems/reshape-the-matrix/

class Solution:
    def matrixReshape(self, nums: [[int]], r: int, c: int) -> [[int]]:
        
        if r * c != len(nums) * len(nums[0]):
            return nums
        
        # return self.solution1(nums, r, c)
        # return self.solution2(nums, r, c)
        # return self.solution3(nums, r, c)
        return self.solution4(nums, r, c)
       
    # Time O(n), Space(2n)
    def solution1(self, nums, r, c):
        q = []
        for row in nums:
            for item in row:
                q.append(item)
        res = []
        for ri in range(r):
            row = []
            for ci in range(c):
                row.append(q[ri * c + ci])
            res.append(row)
        
        return res
    
    # Time O(n), Space(n)
    def solution2(self, nums, r, c):
        res = [[]]
        
        ri = 0
        ci = 0
        for row in nums:
            for item in row:
                if ci == c:
                    ci = 0
                    ri += 1
                    res.append([])
                res[ri].append(item)
                ci += 1
        
        return res
    
    # Time O(n), Space(n)
    def solution3(self, nums, r, c):
        res = [
            [None for i in range(c)] for j in range(r)
        ]
        
        counter = 0
        for row in nums:
            for item in row:
                res[counter // c][counter % c] = item
                counter += 1
        return res
    
    # Time O(n), Space O(n)
    def solution4(self, nums, r, c):
        
        def next_item():
            for row in nums:
                for item in row:
                    yield item
        
        res = []
        provider = next_item()
        
        for ri in range(r):
            row = []
            for ci in range(c):
                row.append(next(provider))
            res.append(row)
            
        return res
