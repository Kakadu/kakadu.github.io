data Stack a = Nil | Cons a (Stack a)

instance STACK Stack where
  empty       = Nil
  isEmpty Nil = True
  isEmpty _   = False
  cons   x xs = Cons x xs
  
  head Nil         = error "empty"
  head (Cons x _)  = x
  tail Nil         = error "empty"
  tail (Cons _ xs) = xs