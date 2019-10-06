module RandomAccessList (RandomAccessList(..)) where

import Prelude hiding (head, tail, lookup)

class RandomAccessList r where
  empty   :: r a
  isEmpty :: r a -> Bool

  cons    :: a -> r a -> r a
  head    :: r a -> a          -- head and tail raise error
  tail    :: r a -> r a        -- if list is empty

  lookup  :: Int -> r a -> a         -- lookup and error raise error
  update  :: Int -> a -> r a -> r a  -- if index is out of bounds
