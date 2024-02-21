data Tree a = Empty
    | Node (Tree a) a (Tree a)


isEmptyTree :: Tree a -> Bool
isEmptyTree Empty   = True
isEmptyTree _       = False

singleton :: a -> Tree a
singleton x = Node Empty x Empty

depth :: Tree a -> Int
depth Empty = 0
depth (Node l _ r) = 1 + max (depth l) (depth r)


inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node l a r) = inorder l ++ [a] ++ inorder r

preorder :: Tree a -> [a]
preorder Empty = []
preorder (Node l a r) = [a] ++ preorder l ++ preorder r

postorder :: Tree a -> [a]
postorder Empty = []
postorder (Node l a r) = postorder l ++ postorder r ++ [a]


rotateLeft :: Tree a -> Tree a
rotateLeft (Node t1 a (Node t2 b t3)) = Node (Node t1 a t2) b t3
rotateLeft t = t

rotateRight :: Tree a -> Tree a
rotateRight (Node (Node t3 b t2) a t1) = Node t3 b (Node t2 a t1)
rotateRight t = t


--- Printing
duplicate string n = concat $ replicate n string -- repeate a string n times
printTree (Node t1 a t2) d delim = duplicate delim d ++ show a ++ "\n" ++ printTree t1 (d+1) delim ++ "\n" ++ printTree t2 (d+1) delim
printTree Empty d delim = ""


main = do
    let t = Node (Node (singleton 2) 12 Empty) 5 (Node (Node (singleton 0) 0 (singleton 0)) 2 Empty) 
    putStrLn "Inorder : "
    putStr (printTree t 0 "  ")
    print (inorder t)


-- Excercise
-- Write an algorithm that takes a tree and returns a tree that has all values equal to the min of the tree
------ Make it so that lazy evaluation constructs the tree in one pass