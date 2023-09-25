myRepeat :: a -> [a]
myRepeat a = a : myRepeat a

data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show)

onesTree :: Tree Int
onesTree = Node 1 onesTree onesTree

takeTree :: Int -> Tree a -> Tree a
takeTree 0 _ = Empty
takeTree _ Empty = Empty
takeTree n (Node a l r) = Node a (takeTree (n - 1) l) (takeTree (n-1) r)

zipWithTree :: (a -> b -> c) -> Tree a -> Tree b -> Tree c
zipWithTree _ Empty _ = Empty
zipWithTree _ _ Empty = Empty
zipWithTree f (Node a l_a r_a) (Node b l_b r_b) = Node (f a b) (zipWithTree f l_a l_b) (zipWithTree f r_a r_b)

levelTree :: Tree Int
levelTree = Node 1 (zipWithTree (+) onesTree levelTree) (zipWithTree (+) onesTree levelTree)

doubleTree :: Tree Int 
doubleTree = Node 1 (zipWithTree (+) doubleTree doubleTree) (zipWithTree (+) doubleTree doubleTree)


primList :: Int -> [Int]
