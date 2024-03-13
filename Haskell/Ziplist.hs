newtype Ziplist a = Ziplist [a]

instance Functor Ziplist where
    fmap f (Ziplist xs) = Ziplist (fmap f xs)

instance Applicative Ziplist where
    -- pure :: a -> Ziplist a
    pure a = Ziplist [a]
    
    -- (<*>) :: Ziplist (a->b) -> Ziplist a -> Ziplist b
    (<*>) Ziplist (f:fs) (Ziplist (x:xs)) = 

instance Monad Ziplist where
    -- writee