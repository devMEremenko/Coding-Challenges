# https://leetcode.com/problems/is-subsequence/
import collections
import bisect

class Solution:
    
    def isSubsequence(self, sub: str, s: str) -> bool:
        return self.solution_follow_up(sub, s)
    
    # Time: O(s) + O(sub)
    # Space: O(s)
    def solution_follow_up(self, sub, s):
        if not sub: 
            return True
        
        indexes = collections.defaultdict(list)
        for idx, item in enumerate(s):
            indexes[item].append(idx)
        
        curr = 0
        for char in sub:
            position = bisect.bisect_left(indexes[char], curr)
            if position == len(indexes[char]):
                return False
            curr = indexes[char][position] + 1
        return True
    
    # Time: O(s)
    # Space: O(1)
    def solution_simple(self, sub, s):
        if not sub: 
            return True
        
        curr = 0
        for char in s:
            if sub[curr] == char:
                curr += 1
                if curr == len(sub):
                    return True
        return False
    