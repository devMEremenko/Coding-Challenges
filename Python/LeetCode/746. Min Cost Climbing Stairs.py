# https://leetcode.com/problems/min-cost-climbing-stairs/

class Solution:
    def minCostClimbingStairs(self, cost: [int]) -> int:
        left = right = 0
        for item in reversed(cost):
            left, right = (item + min(left, right), left)
        return min(left, right)
