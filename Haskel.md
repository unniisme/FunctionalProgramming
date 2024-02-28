# Haskell

Haskell is
- Strongly typed (Type restrictions are there)
- Statically typed (typing is done before compile time and not runtime)

Haskell has **Parametric polymorphism** : Allows type variables.  
Function definition is unique but works for different types

Haskell also has **principled ad hoc polymorphism**


## Haskel types
1. Int, Char, Bool
2. if 𝜏 is a type then [𝜏] is a type (list of 𝜏)
3. if 𝜏₁ and 𝜏₂ are types then 𝜏₁ -> 𝜏₂ is a type (function)
4. if 𝜏₁ and 𝜏₂ are types then (𝜏₁, 𝜏₂) is a type (cartesian product)

// All type names start with capital letters (Pascal case)  
// All variables are camel case
// Functions are also variables  

## Haskell functions
1. functions definitions are notationless

```haskell
f x = y

x :: t1
y :: t2
f :: t1 -> t2 
```

2. All function are unary
- Multiple arguments are made using function composition or tuple argument
 
```haskell
f x y = z

x :: t1
y :: t2
z :: t3
f x :: t2 -> t3
f :: t1 -> (t2 -> t3)
```

```haskell
f (x,y) = z

x :: t1
y :: t2
z :: t3
f :: (t1, t2) -> t3
```

#### Operators
Just pretty functions
```
(+) :: Int -> Int -> Int
```
Syntactically, write an operator in brackets to convert it into a function 

write a function in backticks to make it an operator

```
mod :: Int -> Int -> Int

mod 5 2
5 `mod` 2
```
This goes a lil beyond, for example
```
(+2) :: Int -> Int

(+2) = \x -> x+2

(2+) :: Int -> Int

(2+) = \x -> 2+x
```


### List Stuff

List comprehension  
```haskell
xs :: [a]
x :: a

x:xs :: [a]
```
```
li = [1,2,3]
```

is shorthand for
```
1 : 2 : 3 : []
```

The cons operator
```
(:) :: (a -> [a]) -> [a]
```

### Other functions

```haskell
map :: (a -> b) -> [a] -> [b]
foldr :: ((a -> s) -> s) -> s -> [a] -> s
```

```
foldl f s = foldr f (reverse s)
```
