module ZerolessNumbers where

data Digit   = One | Two
type Nat = [Digit]

inc []         = [One]
inc (One : ds) = Two : ds
inc (Two : ds) = One : (inc ds)