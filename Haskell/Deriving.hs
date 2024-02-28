
data Day = Sunday
        | Monday
        | Tuesday
        | Wednesday
        | Thursday
        | Friday
        | Saturday

instance Eq Day where
    (==) Sunday Sunday = True
    (==) Monday Monday = True
    (==) Tuesday Tuesday = True
    (==) Wednesday Wednesday = True
    (==) Thursday Thursday = True
    (==) Friday Friday = True
    (==) Saturday Saturday = True
    (==) _ _ = False
    
-- Now how do you do Ord??
--- Extremely tedious
--- One option is to define an enum function that converts Day to int and compares that
--- enum :: Day -> Int

-- But we have a better option

data FooBar = Foo String | Bar Int
                deriving Eq
                -- Automatically implements Eq assuming the simplest case
                -- Here
                -- (==) (Foo a) (Foo b) = a == b
                -- (==) (Bar a) (Bar b) = a == b
                -- (==) _ _ = False

-- data FooFunc a b = FooF (a -> b)
                -- deriving Eq
                -- Cant use deriving here as (a -> b) doesn't have an Eq instance


data OrderedDay = Sun
        | Mon
        | Tue
        | Wed
        | Thu
        | Fri
        | Sat  
            deriving (Eq, Ord)
    -- Will be ordered in the order of definition


main = do
    putStr "(Sunday == Monday) \n\t= "
    print (Sunday == Monday)
    putStr "(Sunday == Sunday) \n\t= "
    print (Sunday == Sunday)
    -- print (Sunday > Monday) -- Throws error because not defined

    putStr "(Foo \"asd\" == Foo \"asd\") \n\t= "
    print (Foo "asd" == Foo "asd")
    putStr "(Foo \"asd\" == Foo \"a\") \n\t= "
    print (Foo "asd" == Foo "a")
    putStr "(Bar 2 == Foo \"asd\") \n\t= "
    print (Bar 2 == Foo "asd")
    putStr "(Bar 2 == Bar 2) \n\t= "
    print (Bar 2 == Bar 2)
    putStr "(Bar 2 == Bar 3) \n\t= "
    print (Bar 2 == Bar 3)

    putStr "(Sun == Mon) \n\t= "
    print (Sun == Mon)
    putStr "(Sun > Mon) \n\t= "
    print (Sun > Mon)
    putStr "(Sat <= Wed) \n\t= "
    print (Sat <= Wed)
    putStr "(compare Sun Mon) \n\t= "
    print (compare Sun Mon)
