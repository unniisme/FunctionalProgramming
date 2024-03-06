# Evaluation
The process of finding the final value of an expression

### Eager evaluation
Each argument is evaluated first before a function is evaluated

### Lazy evaluation
The function is evaluated as is, arguments are evaluated (recursively) only when they are used.

### Uses
- Can sometimes cut down number of traversals over datastructures required
    - refer [ListPadding.hs](Haskell/ListPadding.hs)

### Problems
- Folds have to be reiterated, with cerain parts (called thunk) kept in memory to evaluate later
    - refer [FoldProblem.hs](Haskell/FoldProblem.hs)

Thunk : {a, ()->a}, a is kept as invalid. If a is forced, it is evaluated and stored.



Refer [Lazy.hs](Haskell/Lazy.hs)
- Fibonacci sequence as an infinte list