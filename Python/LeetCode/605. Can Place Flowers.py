# https://leetcode.com/problems/can-place-flowers/

class Solution:
    def canPlaceFlowers(self, flowerbed: [int], n: int) -> bool:
        # [1,0,0,0,1] n=1
        # [0,1,0,0], n=1
        # [0]
        # [0,1,1,0,0] items = 5
        # [1,0,0,0,0,0,1]
        # [0,0,1,0,0,0,1]
        
        def left(flowerbed, idx, count):
            if idx == 0:
                return 0
            return flowerbed[idx - 1]
        
        def right(flowerbed, idx, count):
            if idx == count - 1:
                return 0
            return flowerbed[idx + 1]
        
        count = len(flowerbed)
        for idx, item in enumerate(flowerbed):
            if item == 0:
                if not left(flowerbed, idx, count):
                    if not right(flowerbed, idx, count):
                        n -= 1
                        flowerbed[idx] = 1
        return n <= 0
