class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

def ceil(node, val):
    if node is None: return None

    if node.val == val:
        return node
    
    if node.val < val:
        return ceil(node.right, val)
    
    candidate = ceil(node.left, val)
    return candidate if candidate is not None else node

def floor(node, val):
    if node is None: return None

    if node.val == val:
        return node
    
    if node.val < val:
        candidate = floor(node.right, val)
        return candidate if candidate is not None else node

    return floor(node.left, val)


#       5
#  4         10
#        8         13
#      7   9     12   14

root = TreeNode(5)
root.left = TreeNode(4)
root.right = TreeNode(10)
root.right.right = TreeNode(13)
root.right.left = TreeNode(8)
root.right.right.right = TreeNode(14)
root.right.right.left = TreeNode(12)
root.right.left.right = TreeNode(9)
root.right.left.left = TreeNode(7)

def printCeil(root, val):
    node = ceil(root, val)
    if node:
        print(node.val)
    else:
        print(None)

def printFloor(root, val):
    node = floor(root, val)
    if node:
        print(node.val)
    else:
        print(None)


printCeil(root, 5) #5
printCeil(root, 6) #7
printCeil(root, 9) #9
printCeil(root, 11) #12
printCeil(root, 15) #None

printFloor(root, 5) #5
printFloor(root, 6) #5
printFloor(root, 9) #9
printFloor(root, 11) #10
printFloor(root, 15) #14
printFloor(root, 3) #None
