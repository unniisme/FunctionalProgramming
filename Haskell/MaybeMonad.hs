
-- instance Monad Maybe where
--      (>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
--      (Just x) >>= k      = k x
--      Nothing  >>= _      = Nothing


-- It is not necessary to use the Monad as Maybe can be pattern matched with
-- (Unlike IO for example)
addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
addMaybe (Just a) (Just b) = Just (a+b)
addMaybe _ _ = Nothing 

-- But it is much, much simpler
addMaybeMonad :: Maybe Int -> Maybe Int -> Maybe Int
addMaybeMonad a b = (+) <$> a <*> b

-- Do works exactly the same
addMaybeDo :: Maybe Int -> Maybe Int -> Maybe Int
addMaybeDo a b = do
    x <- a
    y <- b
    return (x + y)
    