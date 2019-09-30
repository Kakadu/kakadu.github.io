instance Stack [] where
  empty    = []
  isEmpty [] = true
  isEmpty _  = false
  cons   x xs = x:xs
  
  head   []    = Nothing
  head  (x:xs) = Just x
  tail   []    = Nothing
  tial  (_:xs) = Just xs