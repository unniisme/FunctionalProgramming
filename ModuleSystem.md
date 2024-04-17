# Module System

## Name spacing
Controlling name value binding  
Haskel module system is simpler than that of SML/Ocaml
- Nesting of module is only indirect
- No "Functor" parameter modules

```Haskell
-- Foo.hs
module Foo where
    
    
type Bar = Int
x = 100
```
```Haskell
-- a.hs
import Foo

a :: Bar
a = x
```
```Haskell
-- b.hs
import Foo (Bar)

a :: Bar
-- a = x  -- Not possible since x is not imported
```
Refer the [Tree module](Haskell/Trees/)

## Exposing
By default everything in a module is exported. But selective export is possible
```Haskell
module Foo(x,y) where

x = 10
y = 100
z = 1000
```
Now z is not accessable to import but x and y are.  