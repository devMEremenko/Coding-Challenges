# https://leetcode.com/problems/verifying-an-alien-dictionary/

class Solution:
    def isAlienSorted(self, words: [str], order: str) -> bool:
        m = {}
        for i, o in enumerate(order):
            m[o] = i
            
        def is_sorted(w1, w2):
            for c1, c2 in zip(w1, w2): 
                if m[c1] == m[c2]:
                    continue
                return m[c1] < m[c2]
                
            return len(w1) <= len(w2)
        
        for i in range(len(words) - 1):
            w1 = words[i]
            w2 = words[i + 1]
            
            if not is_sorted(w1, w2):
                return False
            
        return True
