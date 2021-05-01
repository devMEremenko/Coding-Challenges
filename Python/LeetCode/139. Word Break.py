# https://leetcode.com/problems/word-break/

class Solution:
    def wordBreak(self, s: str, wordDict: [str]) -> bool:
        words = set(wordDict)
        visited = set()
        
        def helper(s):
            if not s: return True
            if s in visited: return False
            
            for i in range(len(s)):
                prefix = s[:i+1]
                if prefix in words:
                    suffix = s[i+1:]
                    if helper(suffix):
                        return True
            
            visited.add(s)
            return False
                    
        return helper(s)
