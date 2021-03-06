# https://leetcode.com/problems/hamming-distance/

class Solution:
    def hammingDistance(self, x: int, y: int) -> int:
        # return self.solution1(x, y)
        return self.solution2(x, y)
        
    def solution1(self, x, y):
        return bin(x ^ y).count("1")
    
    def solution2(self, x, y):
        number = x ^ y
        res = 0
        while number > 0:
            if number & 1 > 0:
                res += 1
            number = number >> 1
        return res
