--ghc 8.0.2

-- P1 --
data Natural = Zero |Succ Natural deriving (Show);

-- P1.1 --
int2Nat :: Int -> Natural
int2Nat 0 = Zero
int2Nat n = Succ (int2Nat (n - 1))

nat2Int :: Natural -> Int
nat2Int Zero = 0
nat2Int (Succ nat) = 1 + (nat2Int nat)

-- P1.2 --
sumNatural :: Natural -> Natural -> Natural
sumNatural Zero     m = m
sumNatural (Succ n) m = sumNatural n (Succ m)

-- P1.3 --
multNatural :: Natural -> Natural -> Natural
multNatural Zero m = Zero
multNatural (Succ n) m = sumNatural m (multNatural n m)

factNatural :: Natural -> Natural
factNatural Zero = (Succ Zero)
factNatural (Succ Zero) = (Succ Zero)
factNatural (Succ nat) = multNatural (Succ nat) (factNatural nat)

-- P2 --
ones = 1 : ones -- Racket (cons 1 ones)

-- P2.1 --
myRepeat :: a -> [a]
myRepeat a = a : (myRepeat a)

-- P2.2 --
myCycle :: [a] -> [a]
myCycle l = l ++ (myCycle l)

-- P3 --
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show)

-- P3.1 --
onesTree :: Tree Int
onesTree = Node 1 onesTree onesTree

-- P3.2 --
takeTree :: Int -> Tree a -> Tree a
takeTree 0 _ = Empty 
takeTree n (Node a l r) = Node a (takeTree (n - 1) l) (takeTree (n - 1) r)

-- P3.3 --
zipWithTree :: (a -> b -> c) -> Tree a -> Tree b -> Tree c
zipWithTree _ Empty Empty = Empty
zipWithTree f (Node a al ar) (Node b bl br) = Node (f a b) (zipWithTree f al bl) (zipWithTree f ar br)

-- P3.4 --
levelTree :: Tree Int
-- Node 1 (Node 2 ... ...) (Node 2 ... ...)
levelTree = Node 1 (zipWithTree (+) levelTree onesTree) (zipWithTree (+) levelTree onesTree)

-- P3.5 --
doubleTree :: Tree Int
-- Node 1 (Node 2 (Node 4 ... ...) ...) (Node 2 ... ...)
doubleTree = Node 1 (zipWithTree (+) doubleTree doubleTree) (zipWithTree (+) doubleTree doubleTree)

main = do
    print (nat2Int (sumNatural (int2Nat 10) (int2Nat 17)))
    print (nat2Int (factNatural (int2Nat 10)))
    print (take 10 (myRepeat 1))
    print (take 30 (myCycle [1,2,3]))
    print (takeTree 3 onesTree)
    let a = Node 1  (Node 1 Empty Empty) Empty
    let b = Node 2  (Node 1 Empty Empty) Empty
    print (zipWithTree (+) a b)
    print (takeTree 3 levelTree)
    print (takeTree 5 doubleTree)