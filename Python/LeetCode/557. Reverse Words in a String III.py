# https://leetcode.com/problems/reverse-words-in-a-string-iii/

class Solution:
    def reverseWords(self, s: str) -> str:
        # return self.solution1(s)
        # return self.solution3(s)
        return self.solution2(s)        
        
    # Time O(n), Space O(n)
    def solution2(self, s):
        res = []
        word = []
        
        for char in s:
            if char == ' ':
                res.extend(reversed(word))
                res.append(' ')
                word = []
            else:
                word.append(char)
        
        res.extend(reversed(word))
            
        return ''.join(res)
    
    
    # Time O(n), Space O(n)
    def solution1(self, s):
        if len(s) <= 1:
            return s
        
        counter = 0
        res = []
        
        def extract_word(from_index, count):
            for prev in range(count):
                res.append(s[from_index - prev])
        
        for idx, char in enumerate(s):
            if char == ' ':
                extract_word(idx - 1, counter)
                res.append(' ')
                counter = 0
            else:
                counter += 1
                
        extract_word(len(s) - 1, counter)
                
        return ''.join(res)
    
    def solution3(self, s):
        return ' '.join([v[::-1] for v in s.split()])
