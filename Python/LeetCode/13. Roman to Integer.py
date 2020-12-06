# https://leetcode.com/problems/roman-to-integer/

class Solution:
        
    def romanToInt(self, s: str) -> int:
        # return self.solution1(s)
        # return self.solution2(s)
        return self.solution3(s)

    def solution1(self, s):
        m = {'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100, 'D': 500, 'M': 1000}
            
        buf = 0
        res = 0
                
        for i in range(len(s)):
            current = m[s[i]]
            isLast = i+1 == len(s)
            
            if isLast or current >= m[s[i+1]]:
                res += current - buf
                buf = 0
            else:
                buf += current
                
        return res
    
    def solution2(self, s):
        m = {'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100, 'D': 500, 'M': 1000}
        
        prev = 0
        res = 0
        
        for c in s:
            if m[c] <= prev:
                res += prev
            else:
                res -= prev
            prev = m[c]
                
        return res + prev

    def solution3(self, s):
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
