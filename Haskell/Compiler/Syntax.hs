module Syntax where

import Parser
import Data.Char (isAlpha, isDigit)

-- Person :: String -> Int -> Person
data Person = Person String Int
    deriving Show

alphaParser :: Parser Char
alphaParser = charSatisfy isAlpha
digitParser :: Parser Char
digitParser = charSatisfy isDigit

nameParser :: Parser [Char]
nameParser = many1 alphaParser

ageParser :: Parser Int
ageParser = read <$> many1 digitParser

personParser :: Parser Person
personParser = Person <$> nameParser <*> ageParser




-- Leave this for main to access
parser = personParser