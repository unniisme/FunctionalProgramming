
-- read :: Read a => String -> a
-- (read "123" :: Int) -- gives 123 :: Int

-- getLine :: IO String
-- also, there exists
--  instance Functor IO where ...

getIntLine :: IO Int
 -- getIntLine = read getLine 
    -- Nope, getLine is IO String no String

-- IO is a function, ie :. fmap :: (a->b) -> IO a -> IO b
-- fmap read :: (Read a, Functor t) => t String -> t a 
getIntLine = fmap read getLine


-- Take the `person` type from Datatypes.hs, take input and make a person
---- GetPerson :: IO Person

-- Person :: String -> Person
newtype Person = Person String

getPerson :: IO Person
getPerson = fmap Person getLine 



-- AgedPerson :: String -> Int -> AgedPerson
data AgedPerson = AgedPerson String Int

getFoo :: IO (Int -> AgedPerson)
getFoo = fmap AgedPerson getLine


getAgedPersonGivenAge ::  Int -> (Int -> AgedPerson) -> AgedPerson
getAgedPersonGivenAge n f = f n

getAgedPerson :: Int -> IO AgedPerson
getAgedPerson n = fmap (getAgedPersonGivenAge n) getFoo

-- But now, assume you have
--  getLine :: IO String
--      and
--  getIntLine :: IO Int
-- Can you write IO String -> IO Int -> IO AgedPerson
-- ??????

-- NOPEEE
-- For more info, refer Applicative.md