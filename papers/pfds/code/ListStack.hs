instance STACK [] where
  empty       = []
  isEmpty []  = True
  isEmpty _   = False
  cons   x xs = x:xs
  
  head []     = error "empty"
  head (x:_)  = x
  tail []     = error "empty"
  tial (_:xs) = xs