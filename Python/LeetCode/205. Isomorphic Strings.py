# https://leetcode.com/problems/isomorphic-strings/

class Solution:

    # Time: O(n), Space(n)
    def using2Map(self, s: str, t: str) -> bool:
        m1 = {}
        m2 = {}
        for idx in range(len(s)):
            item1 = s[idx]
            item2 = t[idx]

            if item1 not in m1:
                if item2 in m2:
                    return False
                m1[item1] = t[idx]
                m2[item2] = s[idx]
            else:
                if m1[item1] != t[idx]:
                    return False
        return True

    def isIsomorphic(self, s: str, t: str) -> bool:
        return self.using2Map(s, t)

# Driver
print(Solution().isIsomorphic("ab", "ba"))
