module SparseByWeight where

type Nat = [Int] -- increasing number of weight, each is power of two

carry w [] = [w]
carry w ws@(w_:ws_) = if w<w_ then w:ws else carry (2*w) ws_
borrow w ws@(w_:ws_) = if w==w_ then ws_ else w : borrow (2*w) ws

inc ws = carry 1 ws
dec ws = borrow 1 ws

add ws [] = ws
add [] ws = ws
add m@(w1:ws1) n@(w2:ws2) =
  if w1 < w2 then w1 : add ws1 n
  else if w2<w1 then w2 : add m ws2
  else carry (2*w1) (add ws1 ws2)