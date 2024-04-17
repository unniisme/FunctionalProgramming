import TreeModule

main = do
    let t = empty (0::Int) 
    putStrLn "Initialized empty integer tree"

    let t1 = insert t 1  -- Cannot visualize tree as show is not implemented
    putStrLn "Inserted 1 into tree"

    let t2 = insert (insert (insert t1 5) (-2)) 7
    putStrLn "Inserted 5, -2 and 7 into tree"

    putStrLn ("search 12 = " ++ show (search t2 12))
    putStrLn ("search 7 = " ++ show (search t2 7))
    putStrLn ("search 0 = " ++ show (search t2 0))
    putStrLn ("search -2 = " ++ show (search t2 (-2)))

