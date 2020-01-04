# https://leetcode.com/problems/happy-number/

class Solution:

    # Input:
    # 19
    # slow: 82, 68
    # fast: 68, 1
    
    # 2
    
    def sq_of_digits(self, n) -> int:
        sq = 0
        while n > 0:
            digit = n % 10
            sq += digit * digit
            n = n // 10
        return sq

    def isHappy(self, n: int) -> bool:
        slow = self.sq_of_digits(n)
        fast = self.sq_of_digits(slow)
        
        while fast != slow and fast != n and fast != 1:
            slow = self.sq_of_digits(slow)
            fast = self.sq_of_digits(self.sq_of_digits(fast))
        return fast == 1