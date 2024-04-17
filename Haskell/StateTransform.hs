
newtype StateT s m a = StateT {runStateT :: s -> m (a,s)} 



newtype Identity a = Identity {runIdentity :: a}

type State s a = StateT s Identity
    -- State can be redifined in this manner



instance Functor m => Functor (StateT s m) where
    fmap :: (a -> b) -> StateT s m a -> StateT s m b
    fmap f sma = StateT fn
            where fn s0 = fmap foo mas
                    where 
                        foo (a,s) = (f a, s)
                        mas = runStateT sma s0


instance Monad m => Applicative (StateT s m) where
    pure :: a -> StateT s m a
    pure a = StateT fn
        where fn s0 = pure (a,s0)

    (<*>) :: StateT s m (a -> b) -> StateT s m a -> StateT s m b
    smf <*> sma = StateT fn
            where fn s0 = do
                    (f,s1) <- runStateT smf s0
                    (a,s2) <- runStateT sma s1
                    return (f a, s2)
    

instance Monad m => Monad (StateT s m) where
    (>>=) :: StateT s m a -> (a -> StateT s m b) -> StateT s m b
    sma >>= f = StateT fn
            where fn s0 = do
                    (a,s1) <- runStateT sma s0
                    runStateT (f a) s1



---- Helpers -----
get :: (Applicative m) => StateT s m s
get = StateT fn
    where fn s0 = pure (s0, s0)

put :: (Applicative m) => s -> StateT s m ()
put s = StateT fn
    where fn s0 = pure ((), s0)


-- State that transitions to itself and emits the value in the monad
lift :: (Functor m) => m a -> StateT s m a
lift ma = StateT fn
    where fn s0 = (\x -> (x,s0)) <$> ma




---- Example
