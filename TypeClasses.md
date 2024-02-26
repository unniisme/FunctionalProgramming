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
- `Equal.hs` : A parametrised, general equality function
- `Ord.hs`  : Class for order functions (<=, >= etc)