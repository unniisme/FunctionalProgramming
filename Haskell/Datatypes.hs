data Tuple a b = T a b
-- Generally you can use the same name for the constructor and function (ie. T could just be "Tuple")
-- Constructors (as well as types) are in Pascal case

fst :: Tuple a b -> a
fst (T x _) = x
lst :: Tuple a b -> b
lst (T _ y) = y



--  Type aliasing
type AlsoInt = Int
    -- Just same type differnt name

-- Single constructor type
newtype Person = Person String
    -- Note, the constructor Person has to be single arg
    -- Newtype is eagerly evaluated on definition

-- Multiple on
data Group = Group String Int | EmptyGroup
    -- Multiple constructors, which can support multiple arguments
    -- Evaluated lazily