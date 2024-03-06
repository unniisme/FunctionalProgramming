# Applicative


Defined as
```Haskell
class Functor t => Applicative t where
    pure :: a -> t a
    (<*>)  :: t (a -> b) -> t a -> t b


-- Identities:
pure f <*> ta = fmap f ta
```

Now observe this problem
```Haskell
data Person = Person String Int

getLine :: IO String
getIntLine :: IO Int

getPerson :: IO Person
-- Is this obtainable from the above 2 functions??
-- Not trivially
-- Can be done using Applicatives
```

- Refer [Applicative.hs](Haskell/Applicative.hs)