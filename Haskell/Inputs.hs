--Helpers--
getIntLine :: IO Int
getIntLine = fmap read getLine
-----------

------ Example 1.1 -------
-- This is an example where Monad bind is not required
concatInputs :: IO String
concatInputs = do
    x <- getLine
    y <- getLine
    return (x ++ y)

inputConcatFunc :: IO String
inputConcatFunc = (++) <$> getLine <*> getLine


------ Example 1.2 -------
-- Similar example with bind required
-- Bind is required as there is a side effect
concatInputsBind :: IO String
concatInputsBind = do
    x <- getLine
    putStrLn (x ++ " ++ ?")
    y <- getLine
    return (x ++ y)

-- Same function without do-notation
-- Extremely ugly
inputConcatFuncBind :: IO String
inputConcatFuncBind = getLine >>= 
    (\x -> putStrLn (x ++ " ++ ?") >> 
        (getLine >>= 
            (\y -> return (x ++ y))
        )
    )



------ Example 2 -------
-- Return is not the same as the return from an imperative programming language
foo :: IO String
foo = do 
    return "Hello"
    return "World"

-- In Monad form
fooDash :: IO String
fooDash = return "Hello" >> return "World"

-- Both only return "World"
        


main :: IO()
main = do
    putStrLn "Input Concatnation function"
    conc1 <- concatInputs
    putStrLn conc1
    conc2 <- inputConcatFunc
    putStrLn conc2


    putStrLn "\n Input Concatnation (with bind)"
    concBind1 <- concatInputsBind
    putStrLn concBind1
    concBind2 <- inputConcatFuncBind
    putStrLn concBind2


    putStrLn "\nFake Hello World"
    returnProblem1 <- fooDash
    putStrLn returnProblem1
    returnProblem2 <- fooDash
    putStrLn returnProblem2
    
