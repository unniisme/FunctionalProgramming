_foldr :: (a -> s -> s) -> [a] -> s -> s
_foldr f [] s = s
_foldr f (x:xs) s = f x rec
                    where rec = _foldr f xs s


_foldl :: (s -> a -> s) -> s -> [a] -> s
_foldl f s [] = s
_foldl f s (x:xs) = _foldl f s1 xs
                    where s1 = f s x