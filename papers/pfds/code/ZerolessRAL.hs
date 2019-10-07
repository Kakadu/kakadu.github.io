module DenseFullTreeRAL where

data Tree  a = Leaf a | Node Int (Tree a)
data Digit a = Zero | One (Tree a)
type RList a = [Digit a]

inc []          = [One]
inc (Zero : ds) = One  : ds
inc (One  : ds) = Zero : (inc ds)