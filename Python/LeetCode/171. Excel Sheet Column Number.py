# https://leetcode.com/problems/excel-sheet-column-number/

class Solution:
    
    # A-Z:      1 - 26
    # AA - AZ:  27 - 52
    # BA - BZ   53 - 78
    
    # digit * (26 ^ power)
    def solution1(self, s):
        power = 0
        ans = 0
        
        for item in reversed(s):
            digit = ord(item) - ord('A') + 1
            ans += digit * (26 ** power)
            power += 1
        return ans
    
    def solution2(self, s):
        ans = 0
        for item in s:
            ans *= 26
            ans += ord(item) - ord('A') + 1
            
        return ans
    
    def titleToNumber(self, s: str) -> int:
        # return self.solution1(s)
        return self.solution2(s)
