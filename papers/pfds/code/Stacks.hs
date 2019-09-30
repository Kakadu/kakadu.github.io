{-# LANGUAGE GADTs #-}
import Prelude hiding ( (++) )







class STACK s where
  empty    :: s a
  isEmpty  :: s a -> Bool
  cons     :: a -> s a -> s a
  head     :: s a -> Maybe a
  tail     :: s a -> Maybe (s a)
  head_exn :: s a -> a
  tail_exn :: s a -> s a

instance STACK [] where
  empty    = []
  isEmpty [] = True
  isEmpty _  = False
  cons   x xs = x:xs
  
  head   []    = Nothing
  head  (x:xs) = Just x
  tail   []    = Nothing
  tail  (_:xs) = Just xs
  head_exn [] = error "empty list"
  head_exn (x:_) = x
  tail_exn [] = error "empty list"
  tail_exn (_:xs) = xs
  
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
  else cons (head_exn xs) (tail_exn xs ++ ys)

_ = (++) where 
  (++) [] ys = ys
  (++) (x:xs) ys = x:(xs ++ ys)

update_exn :: ([] ~ l) => l a -> Int -> a -> l a
update_exn [] _ _ = error "subscript"
update_exn (x:xs) 0 y = y:xs
update_exn (_:xs) n y = update_exn xs (n-1) y

main :: IO ()
main = return ()