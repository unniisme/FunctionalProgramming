
firstN :: Int -> [a] -> [a]
firstN n [] = []
firstN 0 xs = []
firstN n (x:xs) = x:firstN (n-1) xs 

-- The list except for the first elemet
tl :: [a] -> [a]
tl (x:xs) = xs

-- An infinte fibonacci sequence
fib :: [Int]
fib = 1 : 1 : zipWith (+) fib (tl fib)
    -- Add the list to itself but offset the first element
    -- Note, this is an infinte list


main = do
    print (firstN 10 fib) 

