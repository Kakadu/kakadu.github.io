data Stack a = Nil | Cons a (Stack a)

instance Stack Stack where
  empty    = Nil
  isEmpty Nil = true
  isEmpty _  = false
  cons   x xs = Cons x xs
  
  head       Nil   = Nothing
  head (Cons x xs) = Just x
  tail       Nil    = Nothing
  tail (Cons _ xs) = Just xs