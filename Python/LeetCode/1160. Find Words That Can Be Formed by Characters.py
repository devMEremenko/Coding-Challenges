# https://leetcode.com/problems/find-words-that-can-be-formed-by-characters/submissions/

from collections import Counter

class Solution:
    
    # Time: O(n*k), Space(k). n - number of words, k - the biggest word
    def countCharacters(self, words: [str], chars: str) -> int:
        
        def is_good(item):
            m = Counter(chars)
            for char in item:
                if m[char] > 0:
                    m[char] -= 1
                else:
                    return False
            return True
        
        c = 0
        for item in words:
            if is_good(item):
                c += len(item)
        return c
