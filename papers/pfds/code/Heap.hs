{-# LANGUAGE TypeFamilies, FlexibleContexts, AllowAmbiguousTypes #-}
module Heap (Heap(..)) where

class HEAP h where
  type Elem h a :: * 
  empty       :: Ord (Elem h a) => h a
  isEmpty     :: Ord (Elem h a) => h a -> Bool

  insert      :: Ord (Elem h a) => Elem h a -> h a -> h a
  merge       :: Ord (Elem h a) => h a -> h a -> h a

  findMin_exn :: Ord (Elem h a) => h a -> Elem h a
  deleteMin   :: Ord (Elem h a) => h a -> h a

-- А не является ли ML более синтаксически чистым?


datatype Heap e = E | T Int e Heap Heap

instance HEAP heap where
  type Elem Heap e = e
  
  merge h E = h
  merge E h = h
  merge h1@(T _ x a1 b1) h2@(T _ y a2 b2) | x<y = makeT x a1 (merge b1 h2)
  merge h1@(T _ x a1 b1) h2@(T _ y a2 b2)       = makeT y a2 (merge h1 b2)



rank E = 0
rank (T (r , _, _, _)) = r

makeT (x, a , b) = 
  if rank a >= rank b 
  then T (rank b + 1, x, a, b)
  else T (rank a + 1, x, b, a)

  
  