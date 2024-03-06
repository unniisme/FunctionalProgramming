# Type Classes

A principle approach to ad-hoc polymorphism.

Parametrized polymorphism : Polymorphism of types

Haskell supports functions which can be defined using type parameters
```Haskell
hd :: [a] -> Maybe a
```
Here, `hd` is parametrised by `a`

```
Just y = hd xs
```
Here, `y` is guaranteed to be an element of `xs` (regardless of implementation of hd) because since the type `a` is variable, the function doesn't have a way of generating a new element of type `a`.


- Other kind of polymorphism (like the ones used in OOP langs such as Java) is called ad-hoc polymorphism
- ppk is a purist. All terminology has to be as per it's first definition.

## Examples:
#### Eq
- A parametrised, general equality function
```Haskell
class Eq a where
    (==) :: a -> a -> Bool
```
- Refer [Equal.hs](Haskell/Equal.hs)

#### Ord
- Class for order functions (<=, >= etc)
```Haskell
class Eq a => Ord a where
    compare :: a -> a -> Ordering
    (<) :: a -> a -> Bool
    (<=) :: a -> a -> Bool
    (>) :: a -> a -> Bool
    (>=) :: a -> a -> Bool
    max :: a -> a -> a
    min :: a -> a -> a
```
- Refer [Ord.hs](Haskell/Ord.hs)

#### Deriving Keyword
- [Deriving.hs](Haskell/Deriving.hs) : deriving keyword

#### Functors
- Refer `Functors.md`

#### Applicative
- Refer `Applicative.md`


## Problem
Type classes have the problem of **coherence** of instance definition.  
ie. Multiple code blocks may have defined an instance for the same Type Class, possibly in multiple modules, and possibly conflicting.  
- To fix, compiler has to decide on using only one of these instances globally, bad idea.

```Haskell
-- Module 1
instance Foo where
    bar (Foo a) = "something"

-- Module 2
instance Foo where
    bar (Foo a) = "something else"


-- Main code
bar (Foo a)
    -- What will bar be resolved to here?
```