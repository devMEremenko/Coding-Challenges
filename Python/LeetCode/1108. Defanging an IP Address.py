# https://leetcode.com/problems/defanging-an-ip-address/

class Solution:
    def defangIPaddr(self, address: str) -> str:
        # return self.solution1(address)
        return self.solution2(address)
        
    def solution1(self, address):
        result = []
        for c in address:
            if c == '.':
                result += "[.]"
            else:
                result += c
        return ''.join(result)
    
    def solution2(self, address):
        # available options:
        # address.replace('.','[.]')
        return "[.]".join(address.split('.'))