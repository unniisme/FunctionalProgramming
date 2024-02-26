
-- We want to define
-- eq :: a -> a -> bool

-- We make a class so that we can implement Eq for different types a
class Equality a where
    eq :: a -> a -> Bool
    neq :: a -> a -> Bool
    neq a b = not (eq a b)



instance Equality Bool where
    eq True b = b
    eq False b = not b

instance Equality Int where
    eq = (==)

instance Equality Char where
    eq = (==)

instance (Equality a, Equality b) => Equality (a,b) where
    eq (a1,b1) (a2, b2) = eq a1 a2 && eq b1 b2 

instance Equality a => Equality [a] where
    eq [] [] = True
    eq (x:xs) (y:ys) = eq x y && eq xs ys
    eq _ _ = False

-- Now, eq will already have type
-- eq :: Equality a => a -> a -> Bool

-- foo :: Equality a => a -> a -> String
-- Will be infered by compiler
foo x y = if eq x y then "yup" else "nope"

main = do
    print (eq "asd" "dsa")
    print (eq "asd" "asd")
    print (eq "a" "aaaaaaaa")
    print (eq ["a"] ["a"])

------Note------
-- The implemented type class for Equality in Haskell is Eq
-- THe implemented function for eq is (==)
-- class Eq a where
--      (==) :: a -> a -> Bool

-- To override :
data Tree a = NullNode | Node (Tree a) a (Tree a)

instance Eq a => Eq (Tree a) where
    (==) NullNode NullNode = True
    (==) (Node l1 v1 r1) (Node l2 v2 r2) = l1 == l2 && v1 == v2 && r1 == r2 
    (==) _ _ = False