module NaiveQueue where

import Prelude (reverse)

data Queue a = Queue [a] [a]




checkf ([], r) = (reverse r, [])
checkf q       = q

snoc (f,  r) x = checkf (f, x:r)
tail (x:f,r)   = checkf (f, r)
