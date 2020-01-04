# https://leetcode.com/problems/roman-to-integer/

class Solution:
        
    def romanToInt(self, s: str) -> int:
        if not s: 
            return 0
        
        roman = {'M': 1000,'D': 500 ,'C': 100,'L': 50,'X': 10,'V': 5,'I': 1}
        res = roman[s[-1]] # set the last value as initial one
        
        for idx in range(len(s) - 1): #exclude the last char
            
            if roman[s[idx]] < roman[s[idx + 1]]:
                res -= roman[s[idx]]
            else:
                res += roman[s[idx]]
                
        return res
        