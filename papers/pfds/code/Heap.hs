{-# LANGUAGE TypeFamilies, FlexibleContexts, AllowAmbiguousTypes #-}
module Heap (Heap(..)) where

class Heap h where
  type Elem h a :: * 
  empty       :: Ord (Elem h a) => h a
  isEmpty     :: Ord (Elem h a) => h a -> Bool

  insert      :: Ord (Elem h a) => a -> h a -> h a
  merge       :: Ord (Elem h a) => h a -> h a -> h a

  findMin_exn :: Ord (Elem h a) => h a -> a
  deleteMin   :: Ord (Elem h a) => h a -> h a

-- А не является ли ML более синтаксически чистым?