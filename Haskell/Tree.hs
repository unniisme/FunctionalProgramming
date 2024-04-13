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



-- Excercise
-- Q. Write an algorithm that takes a tree and returns a tree that has all values equal to the min of the tree
------ Make it so that lazy evaluation constructs the tree in one pass

---2 pass version---

-- Find the minimum element in a tree

findMin :: Ord a => Tree a -> a -> a
    -- Ord a means a can be ordered
    -- For details of Ord : check out Ord.hs and TypeClasses.md

findMin (Node Empty a Empty) currMin = min currMin a
findMin (Node t1 a t2) currMin = min (min (findMin t1 currMin) a) (findMin t2 currMin)
findMin _ currMin = currMin

fillMinTree :: Ord a => Tree a -> a -> Tree a
fillMinTree Empty _ = Empty
fillMinTree (Node t1 a t2) m = Node (fillMinTree t1 m) m (fillMinTree t2 m)

findMinTree :: (Ord a, Bounded a) => Tree a -> Tree a
findMinTree t = fillMinTree t (findMin t maxBound)


---1 pass version---
_helper :: (Ord a, Bounded a) => Tree a -> a -> (Tree a, a)
_helper Empty m = (Empty, maxBound)
_helper (Node t1 v t2) m = (Node tnew1 m tnew2, tmin1 `min` v `min` tmin2)
            where   (tnew1, tmin1) = _helper t1 m
                    (tnew2, tmin2) = _helper t2 m

findMinTreeOnePass :: (Ord a, Bounded a) => Tree a -> Tree a
findMinTreeOnePass t = outTree
            where (outTree, m) = _helper t m 


-- Q. Write a fold function for Trees
foldTree :: (s -> a -> s -> s) -> s -> Tree a -> s
foldTree _ s Empty = s
foldTree f s (Node t1 a t2) = f (foldTree f s t1) a (foldTree f s t2)

-- Q. Write the minTree function using fold
-- _helperFold :: (Ord a, Bounded a) => Tree a -> a -> (Tree a, a)

main = do
    let t = Node (Node (singleton (2::Int)) 12 Empty) 5 (Node (Node (singleton (-1)) 12 (singleton 5)) 2 Empty) 
    putStrLn "Inorder : "
    putStr (printTree t 0 "  ")
    print (inorder t)

    putStrLn ""
    putStr (printTree (findMinTree t) 0 "  ")
    putStr (printTree (findMinTreeOnePass t) 0 "  ")







-----------------More stuff-----------------------------

instance Functor Tree where
  fmap :: (a -> b) -> Tree a -> Tree b
  fmap f Empty = Empty
  fmap f (Node ta a tb) = Node (fmap f ta) (f a) (fmap f tb)

instance Applicative Tree where
    -- Singleton
    pure :: a -> Tree a
    pure x = Node Empty x Empty

    (<*>) :: Tree (a -> b) -> Tree a -> Tree b
    Empty <*> _ = Empty
    _ <*> Empty = Empty
    Node tfa f tfb <*> Node ta v tb = Node (tfa <*> ta) (f v) (tfb <*> tb)

instance Monad Tree where
  (>>=) :: Tree a -> (a -> Tree b) -> Tree b
  Empty >>= _ = Empty
  Node ta v tb >>= f = f v
        -- Not a very useful Monad
     
    