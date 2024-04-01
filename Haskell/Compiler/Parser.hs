module Parser where


data Error = CharacterError Char 
            | EOFError
            deriving Show

data Result a = Ok a String | Err Error
            deriving Show

newtype Parser a = Parser (String -> Result a)
    -- If you fail you get some error
    -- Else you get a, and a string which is the rest of the input

-- Char satisfy
-- Checks if each character satisfies a predicate
charSatisfy :: (Char -> Bool) -> Parser Char
charSatisfy pr = Parser fn
        where 
            fn :: String -> Result Char
            fn (x:xs) = if pr x
                            then Ok x xs
                            else Err (CharacterError x)
            fn [] = Err EOFError


-- Example : Checks if each letter is a certain letter
oneChar :: Char -> Parser Char
oneChar x = charSatisfy (== x) 

-- Run the praser on the input
runParser :: Parser a -> String -> Result a
runParser (Parser fn) = fn

-- OR
(<|>) :: Parser a -> Parser a -> Parser a
p1 <|> p2 = Parser fn
            where fn input = case runParser p1 input of
                        Err _ -> runParser p2 input 
                        x -> x
            -- This is backtracking parsing
            -- very inefficient (exponential time)
            -- Implement lookahead and stuff if required to optimize


-- a*
many :: Parser a -> Parser [a]
many p = many1 p <|> pure []

-- a* + a
many1 :: Parser a -> Parser [a]
many1 p = (:) <$> p <*> many p


            

-- Now, lets see what classes we can fit Parser to

instance Functor Result where
    fmap :: (a -> b) -> Result a -> Result b
    fmap f (Ok a s) = Ok (f a) s
    fmap f (Err x) = Err x

-- instance Applicative Result where
--     pure :: a -> Result a
--     pure a = Ok a ""

--     (<*>) :: Result (a -> b) -> Result a -> Result b
--     Ok f _ <*> Ok a s2 = Ok (f a) s2
--     _ <*> Err e = Err e
--     Err e <*> _ = Err e
------- Doesn't make sense as we want the parser to run on the result of the first parser


instance Functor Parser where
    fmap :: (a -> b) -> Parser a -> Parser b
    fmap f pa = Parser fn
            where
                -- fn :: String -> Result b
                fn input = f <$> runParser pa input 

instance Applicative Parser where
    -- Trivial parser that Oks eveything and returns the entire string
    pure :: a -> Parser a
    pure a = Parser (Ok a)

    (<*>) :: Parser (a -> b) -> Parser a -> Parser b
    pf <*> pa = Parser fn
            where
                fn input = case runParser pf input of
                        Err x -> Err x
                        Ok f rest -> f <$> runParser pa rest

instance Monad Parser where
  (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  pa >>= f = Parser fn
        where
            fn input = case runParser pa input of
                Err x -> Err x
                Ok a rest -> runParser (f a) rest
    

