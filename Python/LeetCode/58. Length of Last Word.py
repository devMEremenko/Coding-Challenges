# https://leetcode.com/problems/length-of-last-word/submissions/

class Solution:
    def lengthOfLastWord(self, s: str) -> int:
        # return self.solution1(s)
        return self.solution2(s)
        
    def solution1(self, s):
        res = 0
        foundCharacter = False
        for char in reversed(s):
            if char == " ":
                if foundCharacter:
                    break
                else:
                    continue
            res += 1
            foundCharacter = True
            
        return res
    
    def solution2(self, s):
        res = 0
        idx = len(s) - 1
        while idx >= 0 and s[idx] == ' ':
            idx -= 1
        while idx >= 0 and s[idx] != ' ':
            idx -= 1
            res += 1
        return res
        