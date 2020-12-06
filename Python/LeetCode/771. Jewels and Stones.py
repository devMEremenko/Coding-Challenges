# https://leetcode.com/problems/jewels-and-stones/submissions/

from collections import defaultdict

class Solution:
    def numJewelsInStones(self, J: str, S: str) -> int:
        # return self.iterative_solution(J, S)
        return self.extra_space_solution(J, S)
        
    # Time: O(n * log(n)) where N is max(S, J)
    # Space: O(1)
    def iterative_solution(self, J, S):
        counter = 0
        
        J = sorted(J)
        S = sorted(S)
        
        p = 0
        for j in J:
            for si in range(p, len(S)):
                if j == S[si]:
                    counter += 1
                elif ord(S[si]) < ord(j):
                    continue
                else:
                    p = si
                    break
                
        return counter
    
    # Time: O(max(S, J))
    # Space: O(S)
    def extra_space_solution(self, J, S):
        d = defaultdict(int)
        for s in S:
            d[s] += 1
            
        counter = 0
        for j in J:
            if j in d:
                counter += d[j]
                
        return counter
