# https://leetcode.com/problems/min-stack/

class MinStack:
    
    # Input:
    # [1 2 3 0]
    # [1     0]
    
    # 2 0 3 0
    # 2 0   0
    
    # Solution with 2 stacks
    def __init__(self):
        self.all = []
        self.min = []
        
    def push(self, x: int) -> None:
        if not self.min or x <= self.min[-1]:
            self.min.append(x)
        self.all.append(x)

    def pop(self) -> None:
        if not self.all: 
            return 0
        
        item = self.all[-1]
        if self.getMin() == item:
            del self.min[-1]
            
        del self.all[-1]
        return item
        

    def top(self) -> int:
        return self.all[-1] if self.all else 0

    def getMin(self) -> int:
        return self.min[-1] if self.min else 0
        
    # 1) Store values in a doubly LinkedList
    #    - Search for min element on pop.
    #    - Store min element in the variable
    #    push O(1), pop O(n), min O(1)
    #    1, 2, 3, 4, 0
    #               min
    #
    #    Time: O(n)
    #    Memory: O(n)
    #
    # 2) Store values in a BST
    #    - Store min element in the variable
    #    push O(log n), pop O(log n), min O(1)
    #
    #    Time: O(log n)
    #    Memory: O(n)
    #
    #      3
    #     2 4
    #    1
    # 3) Store values in a Heap
    #    push O(log n) or in worst case O(n), pop O(log n), min O(1)
    #
    #    Time: O(log n)
    #    Space: O(n)
    #
    #      1
    #     2 3
    #    4
    # 4) Store values in 2 stacks: all and min
    #     all: 3, 1, 2, 3, 0, 5
    #     min: 3, 1, 0
    #     push O(1), pop O(1), min O(1)
    #     Time: O(1)
    #     Space: O(2n)
    
# Your MinStack object will be instantiated and called as such:
# obj = MinStack()
# obj.push(x)
# obj.pop()
# param_3 = obj.top()
# param_4 = obj.getMin()
