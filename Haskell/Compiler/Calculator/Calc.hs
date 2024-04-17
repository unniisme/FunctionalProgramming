import Parser
import Calculator.Types
import Calculator.Syntax

main :: IO()
main = do
    input <- getLine
    let parseRes = runParser parser input
    let res = case parseRes of
            Ok e s -> (case eval e of
                        Right d -> show d
                        Left s -> s)
            Err e -> show e
    putStrLn res
    main