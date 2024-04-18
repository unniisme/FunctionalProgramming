import Parser
import Calculator.Types
import Calculator.Syntax

main :: IO()
main = mainLoop emptyEnv
    

mainLoop env =
        do
                input <- getLine
                let stmt = runParser parser input
                let (newEnv, res) = doParserRes stmt env
                putStrLn (showRes res)
                mainLoop newEnv

showRes :: CalcResult Double -> String
showRes (Left err) = err
showRes (Right d) = show d

doParserRes :: ParseResult Stmt  -> Env ->  (Env, CalcResult Double)
doParserRes (Ok stmt left) env = doStatement stmt env
doParserRes (Err err) env = (env, Left (show err))

doStatement :: Stmt -> Env -> (Env, CalcResult Double)
doStatement (Assign var exp) env = doAssign var env (eval exp env)
doStatement (Eval exp) env = (env, eval exp env)
doStatement EmptyStmt env = (env, Left "Empty Statement")

doAssign :: String -> Env -> CalcResult Double -> (Env, CalcResult Double)
doAssign name env (Right d) = (setVar name d env, Right d)
doAssign name env (Left er) = (env, Left er)