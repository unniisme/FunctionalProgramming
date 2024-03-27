
data Exp v = Var v
            | Plus (Exp v) (Exp v)
            | Mul (Exp v) (Exp v)
            | Const Int

instance Functor Exp where
  fmap :: (v1 -> v2) -> Exp v1 -> Exp v2
  fmap vt (Var x) = Var (vt x)
  fmap vt (Plus e1 e2) = Plus (fmap vt e1) (fmap vt e2)
  fmap vt (Mul e1 e2) = Mul (fmap vt e1) (fmap vt e2)
  fmap vt (Const i) = Const i 

instance Applicative Exp where
  pure :: v -> Exp v
  pure = Var
  
  (<*>) :: Exp (v1 -> v2) -> Exp v1 -> Exp v2
  (Var f) <*> e = fmap f e
  (Plus f1 f2) <*> e = Plus (f1 <*> e) (f2 <*> e)
  (Mul f1 f2) <*> e = Mul (f1 <*> e) (f2 <*> e)
  (Const f) <*> _ = Const f


join :: Exp(Exp v) -> Exp v
join (Var e) = e
join (Plus v1 v2) = Plus (join v1) (join v2) 
join (Mul v1 v2) = Mul (join v1) (join v2)
join (Const i) = Const i

instance Monad Exp where
  return :: v -> Exp v
  return = pure
  
  (>>=) :: Exp v1 -> (v1 -> Exp v2) -> Exp v2
  (>>=) ma f = join (fmap f ma)


