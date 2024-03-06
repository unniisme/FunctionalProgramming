# Haskell Datatypes
Algebraic datatypes
- Constructors are lazily evaluated

`newType` : 
Single constructor single argument datatypes which are evaluated lazily on definition

Refer [Datatypes.hs](Haskell/Datatypes.hs) and [Tree.hs](Haskell/Tree.hs)


## Some interesting Datatypes
```Haskell
data Maybe a = Just a
            | Nothing
```
Nullable. A File pointer for example, can either return a `Just (file)` if file has been read properly, or `Nothing` if file failed to be read
- refer [Maybe.hs](Haskell/Maybe.hs)

```Haskell
data Either a b = Left a
                | Right b
```
Usually either an error or a return
- refer [Either.hs](Haskell/Either.hs)