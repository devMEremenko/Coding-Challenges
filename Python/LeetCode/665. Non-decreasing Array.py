# https://leetcode.com/problems/non-decreasing-array/submissions/

class Solution:
    def checkPossibility(self, n: [int]) -> bool:
        # [3, 4, 2, 3] -> false
        # [4, 2, 1] -> false
        # [4, 2, 3] -> true
        # [2, 3, 3, 2, 4]
        # [3, 4, 2, 3]
        # [-1,4, 2, 3]
        
        v = 0
        count = len(n)
        
        for i in range(count - 1):
            if n[i] > n[i+1]:
                v += 1
                
                previousGreaterNextNext = i-1 >= 0 and n[i-1] > n[i+1]
                currGreaterNextNext = i+2 < count and n[i+2] < n[i]
                
                if previousGreaterNextNext and currGreaterNextNext:
                    return False
        return v < 2
    