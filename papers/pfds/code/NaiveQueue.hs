module NaiveQueue where 



data Queue a = Queue [a] [a]
  



checkf ([], r) = (rev r, [])
checkf q       = q

snoc (f,  r) x = checkf (f, x:r)
tail (x:f,r)   = checkf (f, r)
