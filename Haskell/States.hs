module States where


newtype State s a = State {runState :: s -> (a,s)}
-- This is called a record
-- Same as
-- newtype State s a = State (s -> (a,s))
-- runState (State fn) = fn

newtype ReaderState s a = ReaderState {runReaderState :: s -> a}
    -- Used for example, to write a log
newtype WriterState s a = WriterState {runWriterState :: (a,s)}



instance Functor (State s) where
    fmap :: (a -> b) -> State s a -> State s b
    fmap f sa = State fn
            where fn s0 = (f a, s1) 
                    where 
                        (a,s1) = runState sa s0


--          s0 --- a ---> s1
-- fmap             f
-------------------------------
--          s0 ---f a---> s1



instance Applicative (State s) where
    pure :: a -> State s a
    pure a = State fn
        where fn s0 = (a,s0)

    (<*>) :: State s (a->b) -> State s a -> State s b
    sf <*> sa = State fn
            where fn s0 = (f a, s2)
                    where 
                        (f, s1) = runState sf s0
                        (a, s2) = runState sa s1


--          s0 --- a ---> s1
-- <*>      s1 --- f ---> s2
------------------------------
--          s0 ---f a---> s2



instance Monad (State s) where
    
    (>>=) :: State s a -> (a -> State s b) -> State s b
    sa >>= f = State fn
            where fn s0 = runState (f a) s1
                    where
                        (a, s1) = runState sa s0



--          s0 --- a ---> s1
-- >>=          f
-------------------------------
--          s0 --- a ---> s1 --- b ---> s2
-- 
-- Where definition of the second transition is dependant on a




----- Helpers -----
-- State that emits and transitions to itself
get :: State s s
get = State fn
        where fn s = (s,s)

-- State that always transitions to s, and emits nothing
put :: s -> State s ()
put s = State fn
        where fn _ = ((),s)