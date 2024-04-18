module Calculator.Syntax (parser) where

import Parser
import Calculator.Types

----- Expressions ---------------
wordParser = many1 alphaParser

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

varParser :: Parser Expr
varParser = Var <$> wordParser

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
factorParser = parenParser <|> negExpParser <|> numParser <|> varParser

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


--- Statements ------------------------

exprStmtParser :: Parser Stmt
exprStmtParser = Eval <$> exprParser
assignStmtParser :: Parser Stmt
assignStmtParser =
    do
        name <- wordParser
        whiteSpaceParser
        _ <- charSatisfy (=='=')
        whiteSpaceParser
        Assign name <$> exprParser
emptyStmtParser :: Parser Stmt
emptyStmtParser = many1 (spaceParser <|> indentParser) >> return EmptyStmt 

stmtParser :: Parser Stmt
stmtParser = assignStmtParser <|> exprStmtParser <|> emptyStmtParser

-- Leave this for main to access
parser = stmtParser