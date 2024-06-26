module Syntax where

import Parser ( (<|>), charSatisfy, many, many1, Parser, eofParser)
import Data.Char (isAlpha, isDigit)

data Expr = Number Double
        | Sub Expr Expr
        | Add Expr Expr
        | Mul Expr Expr
        | Div Expr Expr
        | Neg Expr
        deriving Show

alphaParser :: Parser Char
alphaParser = charSatisfy isAlpha
digitParser :: Parser Char
digitParser = charSatisfy isDigit
spaceParser :: Parser Char
spaceParser = charSatisfy (==' ')
indentParser :: Parser Char
indentParser = charSatisfy (=='\t')

whiteSpaceParser :: Parser String
whiteSpaceParser = many (spaceParser <|> indentParser)

-- Parse one or more digits and convert them into an integer
numberParser :: Parser Double
numberParser = read <$> many1 digitParser

numParser :: Parser Expr
numParser = Number <$> numberParser


opParsers :: [Parser (Expr->Expr->Expr)]
opParsers = [
                opToParser '/' Div,
                opToParser '*' Mul,
                opToParser '+' Add,
                opToParser '-' Sub
        ]

-- Parser for expressions
exprParser :: Parser Expr
exprParser = chainParsers factorParser opParsers

-- Parser for factors (handles numbers and parenthesized expressions)
factorParser :: Parser Expr
factorParser = parenParser <|> negExpParser <|> numParser

opToParser :: Char -> (Expr -> Expr -> Expr) -> Parser (Expr -> Expr -> Expr)
opToParser c op = charSatisfy (==c) >> return op


-- Parser for parentheses
parenParser :: Parser Expr
parenParser = do
    _ <- charSatisfy (=='(')
    expr <- exprParser
    _ <- charSatisfy (==')')
    return expr

negExpParser :: Parser Expr
negExpParser = do
        _ <- charSatisfy (=='-')
        Neg <$> exprParser


-- Chain left-associative binary operators of the given precedence level
chainl1 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainl1 p op = do
    x <- p
    rest x
  where
    rest x = (do
        f <- op
        y <- p
        rest (f x y))
      <|> return x

chainParsers :: Parser a -> [Parser (a -> a -> a)] -> Parser a
chainParsers = foldl chainl1

-- Leave this for main to access
parser = exprParser