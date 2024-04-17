module Calculator.Types where

import qualified Data.Map as Map


data Expr = Con Double
        | Var String
        | Add Expr Expr 
        | Sub Expr Expr
        | Mul Expr Expr
        | Div Expr Expr 
        | Neg Expr
        deriving Show

data Stmt = Eval Expr
            | Assign String Expr
            | EmptyStmt
            deriving Show

type CalcResult a = Either String a


eval :: Expr -> CalcResult Double
eval (Con c) = return c
eval (Add e1 e2) = (+) <$> eval e1<*>  eval e2
eval (Mul e1 e2) = (*) <$> eval e1<*>  eval e2
eval (Sub e1 e2) = (-) <$> eval e1<*>  eval e2
eval (Neg e1) = (0-) <$> eval e1
eval (Div e1 e2) = do
                a <- eval e1
                b <- eval e2
                if b == 0 then Left "Divide by zero error"
                        else Right (a/b)
                


