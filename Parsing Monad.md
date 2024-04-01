# Parsing Monad

Build a library for constructing an LL parser.

- LL-parsing is Recursive descent parsing while LR(1) and LALR(1) are shift reduce parsing
- Shift reduce parsing is faster, but in modern compilers the difference is negligible
- LL(1) is pretty parsing and also helps in formatting errors

Refer [Parser.hs](Haskell/Compiler/Parser.hs)


### Side note
- yacc code to haskell code : happy
- lex code to haskell code : Alex