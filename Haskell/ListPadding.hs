type Row = [String]
type Table = [[String]]

-- Helper functions
duplicate string n = concat $ replicate n string -- repeate a string n times
zeroes = 0 : zeroes -- repeat 0
printTable [] = return ()
printTable (row:tab) = do
   print row
   printTable tab



-- Problem: Define a method that goes through a table and pads every string in it so that every cell has the same "width"

-- Pads a table to the given list of padding lengths
padTable :: [Int] -> Table -> Table
padTable padding = map (padRows padding)

-- Pads one row given the list of padding lengths
padRows :: [Int] -> Row -> Row
padRows = zipWith align

-- Pads a single string
align :: Int -> String -> String
align n s = s ++ duplicate " " (n - length s)


-- Find the padding required for one row
findRowPadding :: Row -> [Int]
findRowPadding r = map length r ++ zeroes

-- Find the padding required for one table
findPadding :: Table -> [Int]
findPadding = foldr combf zeroes

-- combine function
combf :: Row -> [Int] -> [Int]
combf r  = zipWith max (findRowPadding r)

method1 :: Table -> IO()
method1 table = do
   putStrLn " "
   putStrLn "Method 1"
   printTable (padTable (findPadding table) table)

-- Problem : Define the same method such that only 1 iteration over the table will have to be done if evaluated lazily
tableHandler :: [Int] -> Table -> (Table, [Int])
tableHandler padding = foldr (rowFoldHandler padding) ([], zeroes)
rowFoldHandler :: [Int] -> Row -> (Table, [Int]) -> (Table, [Int])
rowFoldHandler initialPadding r (table, padding) = (padRows initialPadding r : table, combf r padding)
   -- Not entirely correct right now since multiple passes are still made
   -- But lets assume it is for now



padOnePass :: Table -> Table
padOnePass table = paddedTable
         where (paddedTable, padding) = tableHandler padding table

method2 :: Table -> IO()
method2 table = do
   putStrLn " "
   putStrLn "Method 2"
      -- Megik!!
      -- If tableHandler is implemented correctly, this application will ensure that 
      -- lazy evaluation will only make 1 pass
   printTable (padOnePass table)



main = do
   let table = [["asdsad", "asd"],["ds", "ddss"],["1", "1"]]
   putStrLn "Input table: "
   printTable table
   method1 table
   method2 table



padList lst = map (const x) lst
      where x = minimum lst