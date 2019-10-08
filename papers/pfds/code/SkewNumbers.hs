module SkewNumbers where

type Nat = [Int]

inc ws@(w1 : w2 : rest) | w1 == w2 = (1 + w1 + w2) : rest 
inc ws                             = 1 : ws

dec :: Nat -> Nat
dec (1:ws) = ws 
dec (w:ws) = (w `div` 2) : ((w `div` 2) : ws)