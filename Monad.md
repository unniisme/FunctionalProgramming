# Monad
Basic idea: Do an action dependant on the first action  
Allows application of a function on the data enclosed in a datatype

```Haskell
class Applicative t => Monad t where
    return :: a -> t a
    (>>=) :: t a -> (a -> t b) -> t b
        -- Called 'bind' operator 
    
    
    (>>) :: t a -> t b -> t b
        -- sequencing (simply execute actions one after the other)
    (>>) ta tb = ta >>= (\_ => tb)
```

Created to capture IO  

Apply written using bind:
```Haskell
(<*>) tf ta = tf >>= (\f -> ta >>= (\a -> return (f a)))
```


### Do-notation
Syntactic sugar for Monads  
Particularly useful for IO

```Haskell
action :: t a
stmt = do action ; stmt         -- action >> stmt
    | do x <- action ; stmt     -- action >>= \x -> stmt
    | action                    -- action
```

```Haskell
(<*>) tf ta = do f <- tf
                x <- ta
                return (f x)
```
Basically converts this section of code into an imperative language