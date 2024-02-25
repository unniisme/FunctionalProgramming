
words :: String -> [String]  
length :: [a] -> Int  
 - a is a type variable

<pre>
words "Potato Potahto"
>>> ["Potato", "Potahto"]
</pre>

wc :: String -> Int  
wc x = length (words x)  
wc = length . words  
 - "." is function composition