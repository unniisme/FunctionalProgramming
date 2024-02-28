
-------------
-- Haskell class Ord
--
-- class Eq a => Ord a where
--      compare :: a -> a -> Ordering
--      (<) :: a -> a -> Bool
--      (<=) :: a -> a -> Bool
--      (>) :: a -> a -> Bool
--      (>=) :: a -> a -> Bool
--      max :: a -> a -> a
--      min :: a -> a -> a

class Eq a => Order a where
    leq :: a -> a -> Bool

instance Order Bool where
    leq True False = False
    leq _ _ = True

instance Order Int where
    leq = (<=)

-- Lexicographic ordering
instance (Order a, Order b) => Order (a,b) where
    leq (a1, b1) (a2, b2)   | a1 == a2  = leq b1 b2
                            | leq a1 a2 = True
                            | otherwise = False

instance (Order a) => Order [a] where
    leq (x:xs) (y:ys)   | x == y  = leq xs ys
                        | leq x y = True
                        | otherwise = False
    leq _ _ = False


sort :: Order a => [a] -> [a]
-- Or we can write using a custom ordering function
-- sort :: (a -> a -> Bool) -> [a] -> [a]
-- But we replace this function with the default overriden function of Order a

-- Quicksort
sort [] = []
sort (x:xs) =
    ----- Same as (in python)
    -- smallerSorted = sort([a for a in xs if a <= x])
    -- biggerSorted = sort([a for a in xs if not a <= x])
    let smallerSorted = sort [a | a <- xs, leq a x]
        biggerSorted = sort [a | a <- xs, not (leq a x)]
    in  smallerSorted ++ [x] ++ biggerSorted

main = do
    print (leq (1::Int) 2)
    print (leq True False)

    let lst = [2::Int,5,1,2,3]
    putStrLn "Input list : "
    print lst
    putStrLn "Sorted list : "
    print (sort lst)
