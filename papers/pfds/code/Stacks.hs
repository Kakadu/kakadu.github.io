{-# LANGUAGE GADTs #-}
import Prelude hiding ( (++) )






-- a la interface
class STACK s where
  empty    :: s a
  isEmpty  :: s a -> Bool
  cons     :: a -> s a -> s a
  head     :: s a -> a
  tail     :: s a -> s a
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
  
  head       Nil   = Nothing
  head (Cons x xs) = Just x
  tail       Nil    = Nothing
  tail (Cons _ xs) = Just xs
  head_exn Nil = error "empty list"
  head_exn (Cons x _) = x
  tail_exn Nil = error "empty list"
  tail_exn (Cons _ xs) = xs

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
update (_:xs) n y = x : (update xs (n-1) y)

main :: IO ()
main = return ()