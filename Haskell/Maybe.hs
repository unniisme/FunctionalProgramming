-- Returns the first element of the list
hd :: [a] -> a
hd (x:_) = x
    -- Function is not safe as function thrown error if input is []

hdSafe :: [a] -> Maybe a
hdSafe (x:xs) = Just x
hdSafe [] = Nothing
    -- Function is safe. Returns Nothing if list is empty


printListHead :: [Int] -> IO()
printListHead l = do 
    putStrLn ""
    putStr "Input list : "
    print l
    putStr "hdSafe : "
    print (hdSafe l)
    putStr "hd : "
    print (hd l)

main = do
    printListHead [0,1]
    printListHead []

