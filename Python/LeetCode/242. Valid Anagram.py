# https://leetcode.com/problems/valid-anagram

from collections import Counter
from string import ascii_lowercase 

class Solution:
    
    #Input:
    # car
    # rac
    
    # Anagram: if 2 strings have the same amount of equal characters
    # Solution 1: Brute force O(n*n)
    # Solution 2: Use dictionary to map [char: count] O(n)
    # Solution 3: Sort both strings O(n*log n)
    # Solution 4: Create an array of 26 items Time: O(n), Space O(1)
    
    def isAnagram(self, s: str, t: str) -> bool:
        # return Counter(s) == Counter(t) # 2
        # return sorted(s) == sorted(t) # 3
        
        arr = [0 for _ in range(0, 26)]
        for item in s:
            arr[ord(item) - 97] += 1
        for item in t:
            arr[ord(item) - 97] -= 1
        
        return all(v == 0 for v in arr) # 4
