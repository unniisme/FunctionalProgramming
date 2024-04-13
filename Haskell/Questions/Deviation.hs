-- Write deviation :: [Double] -> [Double] 
-- that calculates the devialtion of each element in the input list
-- Using only one pass

_helper :: Double -> Double -> [Double] -> ([Double], Double, Double)
_helper mean l (x:xs) = ((x-mean):xss, meanSoFar + (x/l), lSoFar + 1.0)
                    where (xss, meanSoFar, lSoFar) = _helper mean l xs
_helper _ _ [] = ([], 0, 0)

deviation :: [Double] -> [Double]
deviation xs = xxs
    where (xxs, mean, l) = _helper mean l xs