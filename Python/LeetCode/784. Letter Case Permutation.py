# https://leetcode.com/problems/letter-case-permutation/

class Solution:
    
    # Time O(2^n)
    # Space O((2^n)*n)
    # Where n is a number of characters in a string
    def letterCasePermutation(self, s: str) -> [str]:
        res = []
        
        for c in s:
            if not res:
                if c.isdigit():
                    res.append([c])
                else:
                    res.append([c.lower()])
                    res.append([c.upper()])
            else:
                for idx in range(len(res)):
                    lower = res[idx]
                    if c.isdigit():
                        lower.append(c)
                    else:
                        upper = [item for item in lower]
                        lower.append(c.lower())
                        upper.append(c.upper())
                        res.append(upper)
                        
        return [''.join(item) for item in res]
