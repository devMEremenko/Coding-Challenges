# https://leetcode.com/problems/island-perimeter/

class Solution:
    def islandPerimeter(self, grid: [[int]]) -> int:
        res = 0
        for ri, row in enumerate(grid):
            for ci, _ in enumerate(row):
                res += self.perimeter_of_cell(grid, ri, ci)
        return res
        
    def perimeter_of_cell(self, grid, r, c):        
        
        def calculate(r, c):
            if r < 0 or r >= len(grid):
                return 1
            if c < 0 or c >= len(grid[0]):
                return 1
            return 1 if grid[r][c] == 0 else 0
        
        counter = 0
        
        if grid[r][c] == 1:
            counter += calculate(r + 1,  c)
            counter += calculate(r - 1,  c)
            counter += calculate(r,  c + 1)
            counter += calculate(r,  c - 1)

        return counter