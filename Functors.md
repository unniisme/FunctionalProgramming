# Functors

- Functors represent an abstraction of mapping a function on a datatype.
```Haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
```
- They follow these identities
```Haskell
fmap id = id
fmap (f g) = (fmap f) (fmap g)
```
- Refer `Functor.hs`


## IO a
`IO a` is a special functor that represents tpye of input - output action that result in a value of type a

```Haskell
read :: Read a => String -> a
getLine :: IO String
```
- Refer `IO.hs`