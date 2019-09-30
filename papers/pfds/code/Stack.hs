class Stack s where
  empty   :: s a
  isEmpty :: s a -> Bool
  cons    :: a -> s a -> s a
  head    :: s a -> Maybe a         
  tail    :: s a -> Maybe a