class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    def deleteNode(self, root: TreeNode, key: int) -> TreeNode:
        if root is None: return None

        if root.val > key:
            root.left = self.deleteNode(root.left, key)
        elif root.val < key:
            root.right = self.deleteNode(root.right, key)
        else:
            if root.left is None: 
                return root.right
            if root.right is None:
                return root.left
            
            successorParent = root.right
            success = root.right

            while success.left is not None:
                successorParent = success
                success = success.left
            
            root.val = success.val

            if success.val == successorParent.val:
                root.right = success.right
            else:
                successorParent.left = success.right

        return root

root = TreeNode(5)
root.left = TreeNode(4)
root.right = TreeNode(11)
root.right.right = TreeNode(13)
root.right.left = TreeNode(8)
root.right.right.right = TreeNode(14)
root.right.right.left = TreeNode(12)
root.right.left.right = TreeNode(9)
root.right.left.left = TreeNode(7)
root.right.left.right.right = TreeNode(10)


solution = Solution()
root = solution.deleteNode(root, 4)
root = solution.deleteNode(root, 5)
root = solution.deleteNode(root, 7)
root = solution.deleteNode(root, 10)
root = solution.deleteNode(root, 12)
root = solution.deleteNode(root, 8)

def inorder_print(root):
    if root is None: return
    if root.left:
        inorder_print(root.left)
    print(root.val)
    if root.right:
        inorder_print(root.right)

inorder_print(root)
