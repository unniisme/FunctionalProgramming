-- in main
-- class Functor t where
--      fmap :: (a->b) -> t a -> t b

class FunctorClass t where
    mapf :: (a->b) -> t a -> t b


instance FunctorClass Maybe where
    mapf f (Just x) = Just (f x)
    mapf f Nothing = Nothing

instance FunctorClass [] where
    -- mapf = map
    mapf f [] = []
    mapf f (x:xs) = f x:mapf f xs

data Tree a = NullNode | Node (Tree a) a (Tree a)

instance FunctorClass Tree where
    mapf f (Node t1 a t2) = Node (mapf f t1) (f a) (mapf f t2)
    mapf f NullNode = NullNode