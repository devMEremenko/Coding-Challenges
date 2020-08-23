# https://leetcode.com/problems/lemonade-change/submissions/

class Solution:
    def lemonadeChange(self, bills: [int]) -> bool:
        # $5 -> no
        # $10 -> 5
        # $20 -> 5,10 (preferred) or 5,5,5
        
        f = t = 0
        for item in bills:
            if item == 5:
                f += 1
            elif item == 10:
                f -= 1
                t += 1    
            else:
                if t > 0:
                    f -= 1
                    t -= 1
                else:
                    f -= 3
            if f < 0 or t < 0:
                return False
        return True
    