# https://leetcode.com/problems/construct-the-rectangle/

import math

class Solution:
    def constructRectangle(self, area: int) -> [int]:
        w = int(math.sqrt(area)) 
        for l in range(w, 0, -1):
            if area % l == 0:
                return [area // l, l]
        return []
