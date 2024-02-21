-- A dummy error type
data Error = ParseError | RuntimeError

-- Dummy function
parse :: String -> Either Error Char
parse "" = Left ParseError
parse (x:_) = Right x