-- sugnum
sign x | x < 0     = -1
       | x > 0     = 1
       | otherwise = 0

-- absolute value
abs' x | sign x == -1 = -x 
       | otherwise    = x 

-- add, mul
(add, mul) = (add', mul') where
  add' x | x == 0    = id
         | x >  0    = inc . (add' $ dec x)
         | otherwise = (add' $ inc x) . dec 
  mul' x 0 = 0
  mul' x y | y > 0     = add x . mul' x . dec $ y
           | otherwise = negate . mul' x . negate $ y
  inc   = (+1)
  dec   = (subtract 1)

-- sub
sub x = (x `add`) . negate

-- quot
quot' x y = s x . s y $ abs x `quot` abs y where
  quot x 1 = x
  quot x y | x == y    = 1
           | y <  x    = 1 + quot (x `sub` y) y
           | otherwise = 0
  s x = if x < 0 then negate else id

-- reminder
rem' x y = (x `sub`) . (y `mul`) . (x `quot'`) $ y

-- gcd
gcd' x 0 = abs x
gcd' x y = gcd' y $ rem x y

-- lcm
lcm' x y = abs $ (x `mul` y) `quot'` (x `gcd'` y)

-- nd
(nd, sd) = (nd', sd') where
  nd' x = accu x (\ _ -> (+1)) 0
  sd' x = accu x (\ x -> (+x)) 0
  accu x f = accu' 1 where
    x' = abs x
    accu' n | n == x'   = f n
            | otherwise = accu' (n+1) . if 0 == (x' `rem'` n) then f n else id

-- prime
is_prime = (2==) . nd

-- coprime
coprime x = (==1) . gcd x

add
sub
mul
quot
rem
gcd
sd
nd
isPrime
areComprime
euler
