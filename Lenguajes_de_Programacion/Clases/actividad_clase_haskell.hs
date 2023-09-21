mapRep :: (a -> a) -> a -> [a]
mapRep f x = x : map f (mapRep f x)


