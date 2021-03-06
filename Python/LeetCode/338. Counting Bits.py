# https://leetcode.com/problems/counting-bits/

class Solution:
    def countBits(self, num: int) -> [int]:
        # return self.solution1(num)
        return self.solution2(num)
    
    # Time: O(n * sizeOf(int))
    def solution1(self, num):
        return list(map(lambda i: bin(i).count("1"), range(0, num + 1)))
    
    # Time: O(n)
    # even: countBits(i) == countBits(i // 2)
    # odd:  countBits(i) == countBits(i - 1) + 1 where (i - 1) is even
    # 2: 00010
    # 4: 00100
    # 8: 01000
    def solution2(self, num):
        res = [0] * (num + 1)
        for i in range(num + 1):
            #         or i >> 1  or i % 2
            res[i] = res[i // 2] + (i & 1)
        return res
    