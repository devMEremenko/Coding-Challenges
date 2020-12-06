# https://leetcode.com/problems/to-lower-case/

class Solution:
    
    # Time: O(len(str))
    def toLowerCase(self, str: str) -> str:
        # A - 65
        # a - 97
        #   = 32
        
        # return self.solution1(str)
        return self.solution2(str)
        
    def solution1(self, str):
        res = []
        for c in str:
            code = ord(c)
            if code >= 65 and code < 97:
                res += chr(code + 32)
            else:
                res += c
        return ''.join(res)
    
    def solution2(self, str):
        return str.lower()
