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

-- Environment for saving variables
type Env = Map.Map String Double

emptyEnv :: Env
emptyEnv = Map.empty

setVar :: String -> Double -> Env -> Env
setVar = Map.insert

getVar :: String -> Env -> CalcResult Double
getVar name env = case Map.lookup name env of
                Just d -> Right d
                Nothing -> Left ("Variable " ++ name ++ " not found")



eval :: Expr -> Env -> CalcResult Double
eval (Con c) env = return c
eval (Add e1 e2) env = (+) <$> eval e1 env <*>  eval e2 env 
eval (Mul e1 e2) env = (*) <$> eval e1 env <*>  eval e2 env 
eval (Sub e1 e2) env = (-) <$> eval e1 env <*>  eval e2 env 
eval (Neg e1) env = (0-) <$> eval e1 env 
eval (Div e1 e2) env = do
                a <- eval e1 env 
                b <- eval e2 env 
                if b == 0 then Left "Divide by zero error"
                        else Right (a/b)
eval (Var str) env = getVar str env

