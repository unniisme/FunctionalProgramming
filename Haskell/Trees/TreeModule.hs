module TreeModule (Tree, empty, singleton, search, insert) where
-- The way this is exposed, it is not possible to construct the tree outside the module
-- since no constructors are exposed

-- This datatype is very opaque and will disallow any pattern matching with the tree itself


data Tree a = EmptyTree | Node (Tree a) a (Tree a)

-- Smart constructor
-- Constraints type
empty :: a -> Tree a
empty x = EmptyTree

singleton :: a -> Tree a
singleton x = Node EmptyTree x EmptyTree


search :: Ord a => Tree a -> a -> Maybe a
search (Node l x r) a   | x == a = Just a
                        | x < a  = search r a
                        | otherwise = search l a
search EmptyTree a = Nothing

insert :: Ord a => Tree a -> a -> Tree a
insert (Node l x r) a   | x >= a = Node (insert l a) x r
                        | otherwise = Node l x (insert r a)
insert EmptyTree a = singleton a