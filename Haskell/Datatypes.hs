data Tuple a b = T a b
-- Generally you can use the same name for the constructor and function (ie. T could just be "Tuple")
-- Constructors (as well as types) are in Pascal case

fst :: Tuple a b -> a
fst (T x _) = x
lst :: Tuple a b -> b
lst (T _ y) = y