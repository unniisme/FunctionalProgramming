module Main where

import Parser
import Syntax (parser, Expr)
import Data.Char (isAlpha, isDigit)

main = do
    input <- getLine
    print (runParser parser input)
    main