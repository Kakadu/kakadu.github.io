{-# LANGUAGE TypeFamilies, FlexibleContexts, AllowAmbiguousTypes #-}
module Heap (Heap(..)) where

class HEAP h where
  empty       :: Ord a => h a
  isEmpty     :: Ord a => h a -> Bool

  insert      :: Ord a => a -> h a -> h a
  merge       :: Ord a => h a -> h a -> h a

  findMin     :: Ord a => h a -> a
  deleteMin   :: Ord a => h a -> h a
  type Elem h a :: * 

-- А не является ли ML более синтаксически чистым?
-- А то тут по идее надо везде Ord (Elem h a) писать

data Heap e = E | T Int e Heap Heap

instance HEAP heap where
  type Elem Heap e = e
  
  merge h E = h
  merge E h = h
  merge h1@(T _ x a1 b1) h2@(T _ y  _  _) | x<y = makeT x a1 (merge b1 h2)
  merge h1@(T _ x  _  _) h2@(T _ y a2 b2)       = makeT y a2 (merge h1 b2)



rank E = 0
rank (T r _ _ _) = r

makeT x a b | rank a >= rank b = T (rank b + 1) x a b
makeT x a b                    = T (rank a + 1) x b a

insert x h  = merge (T 1 x E E) h
findMin   (T _ x _ _) = x
deleteMin (T _ _ a b) = merge a b

  