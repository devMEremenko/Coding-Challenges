# https://leetcode.com/problems/assign-cookies/

class Solution:
    def findContentChildren(self, children: [int], cookies: [int]) -> int:
        children.sort()
        cookies.sort()
        counter = 0
        for cookie in cookies:
            if counter == len(children):
                break
            if cookie >= children[counter]: # Is the cookie ok for that child?
                counter += 1 # increase a counter and go to the next child
        return counter
