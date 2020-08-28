# https://leetcode.com/problems/detect-capital/

class Solution:
    
    def solution1(self, word):
        return word.islower() or word.isupper() or word.istitle()
    
    def solution2(self, word):
        if len(word) <= 1:
            return True
        
        for idx in range(len(word) - 1):
            is_upper = word[idx].isupper() and word[idx + 1].isupper()
            is_lower = word[idx].islower() and word[idx + 1].islower()
            
            if is_upper or is_lower:
                continue
            else:
                if idx == 0 and word[idx].isupper():
                    continue
                else:
                    return False
        return True
    
    def solution3(self, word):
        if len(word)==1:
            return True
        
        if word[0].isupper() and word[1].isupper():
            for i in range(2,len(word)):
                if word[i].islower():
                    return False
            
        if word[0].isupper() and word[1].islower():
            for i in range(2,len(word)):
                if word[i].isupper():
                    return False
        if word[0].islower():
            for i in range(1,len(word)):
                if word[i].isupper():
                    return False
        return True
    
    def detectCapitalUse(self, word: str) -> bool:        
        # word[0] - upper, word[1...n] - upper
        # word[0] - upper, word[1...n] - lower
        # word[0] - lower, word[1...n] - lowe
        
        # return self.solution1(word)
        # return self.solution2(word)
        return self.solution3(word)
    