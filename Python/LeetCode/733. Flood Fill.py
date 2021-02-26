# https://leetcode.com/problems/flood-fill/solution/

class Solution:
    def floodFill(self, image: [[int]], sr: int, sc: int, newColor: int) -> [[int]]:
        
        self.dfs(image, sr, sc, newColor, image[sr][sc])
        return image
        
    def dfs(self, image, sr, sc, newColor, originalColor):
        if sr < 0 or sr >= len(image):
            return
        if sc < 0 or sc >= len(image[0]):
            return
        
        if image[sr][sc] == newColor:
            return
        
        if image[sr][sc] == originalColor:
            image[sr][sc] = newColor

            self.dfs(image, sr - 1, sc, newColor, originalColor)
            self.dfs(image, sr + 1, sc, newColor, originalColor)
            self.dfs(image, sr, sc + 1, newColor, originalColor)
            self.dfs(image, sr, sc - 1, newColor, originalColor)
