# https://leetcode.com/problems/valid-parentheses/

class Solution:
    
    # ---- In-place Solution
    def isMatch(self, s1: str, s2: str) -> bool:
        if s1 == "(" and s2 == ")": return True
        if s1 == "[" and s2 == "]": return True
        if s1 == "{" and s2 == "}": return True
        return False
    
    def solve_inplace(self, s: str):
        l = list(s)
        top = -1
        
        for i in range(len(s)):
            if top < 0 or not self.isMatch(l[top], l[i]):
                top += 1
                l[top] = l[i]
            else:
                top -= 1
        return top == -1
    
    # ---- Stack Solution
    def isOpened(self, s: str):
        return s == '(' or s == '{' or s == '['
    
    def solve_using_stack(self, s: str):
        stack = []
        
        for item in s:
            if self.isOpened(item):
                stack.append(item)
            else:
                if not stack or not self.isMatch(stack.pop(), item):
                    return False
        return not stack
    
    def isValid(self, s: str) -> bool:
        # Input:
        # [()]
        # ()[]{}
        # {()[]}
        
        # return self.solve_inplace(s)
        return self.solve_using_stack(s)
