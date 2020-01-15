# https://leetcode.com/problems/design-hashset/

from collections import deque

class MyHashSet:
    
    # This implementation is based on chaining.
    # I would use a self-balancing BST as an underlying bucket in the production.
    # This implementation does not support resizing, 
    # but it's enough for LeetCode test cases.
    
    def __init__(self):
        self.arr = [deque() for _ in range(16)]
    
    def add(self, key: int) -> None:
        b = self.__bucket(key)
        if key not in b:
            b.append(key)
            
    def remove(self, key: int) -> None:
        b = self.__bucket(key)
        if key in b:
            b.remove(key)

    def contains(self, key: int) -> bool:
        b = self.__bucket(key)
        return key in b
    
    def __bucket(self, key):
        idx = hash(key) % len(self.arr)
        return self.arr[idx]
