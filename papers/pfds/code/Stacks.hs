{-# LANGUAGE GADTs, NoImplicitPrelude #-}
module Stacks where

import Stack
import Prelude hiding ((++), tail, head)














-- a la interface implementation
instance STACK [] where
  empty      = []
  isEmpty [] = True
  isEmpty _  = False
  cons   x xs = x:xs

  head [] = error "empty list"
  head (x:_) = x
  tail [] = error "empty list"
  tail (_:xs) = xs






data Stack a = Nil | Cons a (Stack a)

instance STACK Stack where
  empty    = Nil
  isEmpty Nil = True
  isEmpty _   = False
  cons   x xs = Cons x xs

  head Nil = error "empty list"
  head (Cons x _) = x
  tail Nil = error "empty list"
  tail (Cons _ xs) = xs

(++) :: STACK l => l a -> l a -> l a
(++) xs ys =
  if isEmpty xs
  then ys
  else cons (head xs) (tail xs ++ ys)

_ = (++) where
  (++) []     ys = ys
  (++) (x:xs) ys = x:(xs ++ ys)

update :: [a] -> Int -> a -> [a]
update []     _ _ = error "subscript"
update (x:xs) 0 y = y : xs
update (x:xs) n y = x : (update xs (n-1) y)
