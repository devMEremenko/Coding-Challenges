# https://leetcode.com/problems/kids-with-the-greatest-number-of-candies/submissions/

class Solution:
    def kidsWithCandies(self, candies: [int], extraCandies: int) -> [bool]:
        maxCandies = max(candies, default=0)
        return [True if v + extraCandies >= maxCandies else False for v in candies]