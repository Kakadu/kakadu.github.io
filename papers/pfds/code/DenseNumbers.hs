module DenseNumbers where
data Digit = Zero | One 
type Nat = [Digit] -- increasing order of significance

inc [] = [One]
inc (Zero: ds) = One : ds
inc (One : ds) = Zero : (inc ds)   -- carry
dec [One] = []
dec (One : ds) = Zero : ds
dec (Zero : ds) = One : (dec ds) -- borrow

add ds [] = ds
add [] ds = ds
add (d : ds1)  (Zero : ds2) = d : (add ds1 ds2)
add (Zero : ds1)  (d : ds2) = d : (add ds1 ds2)
add (One : ds1) (One : ds2) = Zero : (inc (add ds1 ds2)) -- carry