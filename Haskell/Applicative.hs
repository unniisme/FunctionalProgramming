
getIntLine :: IO Int
getIntLine = fmap read getLine


-- Person :: String -> Int -> Person
data Person = Person String Int

getIntPerson :: IO (Int -> Person)
getIntPerson = fmap Person getLine

-- IO has instance of Applicative,ie
-- instance Applicative IO where
--      pure :: a -> IO a
--      (<*>):: IO (a->b) -> IO a -> IO b

getPerson :: IO Person
getPerson = getIntPerson <*> getIntLine



-------------
add3 :: Int -> Int -> Int -> Int
add3 x y z = x+y+z

-- Write IO Int
getAdd3 :: IO Int
getAdd3 = fmap add3 getIntLine <*> getIntLine <*> getIntLine

-- fmap shorthand
-- f <$> tx = fmap f tx
-- (<$>) :: (a -> b) -> t a -> t b

add2 :: Int -> Int -> Int
add2 = (+)

getAdd2 :: IO Int
getAdd2 = add2 <$> getIntLine <*> getIntLine


-- FullNamePerson :: String -> String -> Int -> FullNamePerson
data FullNamePerson = FullNamePerson String String Int 

getFullNamePerson :: IO FullNamePerson
getFullNamePerson = FullNamePerson <$> getLine <*> getLine <*> getIntLine

instance Show FullNamePerson where  
    show :: FullNamePerson -> String
    show (FullNamePerson name surname age) = name ++ " " ++ surname ++ " " ++ show age 
