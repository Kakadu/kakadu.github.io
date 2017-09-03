add' 0 = id
add' x | x > 0 = add' (x-1) . (+1)
       | x < 0 = add' (x+1) . (subtract 1)
 
mul' 0 _ = 0
mul' x y | x > 0 = add' y $ mul' (x-1) y
         | x < 0 = negate $ mul' (negate x) y

sub' x = add' x . negate

quot' x y = s x . s y $ quot'' (abs x) (abs y) where
   quot'' x y | x < y     = 0
              | otherwise = 1 + quot'' (sub' x y) y
   s x | x < 0     = negate
       | otherwise = id

rem' x y = (x `sub'`) . (y `mul'`) . (x `quot'`) $ y
    
gcd' x 0 = abs x
gcd' x y = gcd' y $ rem x y

(nd, sd) = (nd', sd') where
  nd' x = accu x (\ _ -> (+1)) 0
  sd' x = accu x (\ x -> (+x)) 0
  accu x f = accu' 1 where
    x' = abs x
    accu' n | n == x'   = f n
            | otherwise = accu' (n+1) . if 0 == x' `rem'` n then f n else id

isPrime n = iterate 2 where
  n' = abs n 
  iterate i | i*i > n'  = True
            | otherwise = rem' n' i /= 0 && iterate (i+1) 

areCoprime x = (==1) . gcd x

euler n = iterate 0 1 where
  n' = abs n
  iterate acc i | i >  n-1  = acc
                | otherwise = iterate (acc + (fromEnum $ areCoprime n' i)) (i+1) 