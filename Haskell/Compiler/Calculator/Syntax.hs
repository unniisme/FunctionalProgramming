module Calculator.Syntax (parser) where

import Parser
import Calculator.Types


doubleParser :: Parser Double
doubleParser = 
    do
        integerPart <- many1 digitParser
        _ <- oneChar '.'
        fractionalPart <- many1 digitParser
        let numberStr = integerPart ++ "." ++ fractionalPart
        return (read numberStr)
    <|>
    do
        integer <- many1 digitParser
        return (read integer) 


numParser :: Parser Expr
numParser = Con <$> doubleParser


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