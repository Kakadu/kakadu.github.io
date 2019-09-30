{-# LANGUAGE TypeFamilies #-}
module SearchTree where







data Tree a = E | T (Tree a) a (Tree a)

class SET (s:: * -> *) where 
  type Elem s a :: * 
  empty :: s a
  insert :: (Ord a) => a -> s a -> s a
  member :: (Ord a) => a -> s a -> Bool
  
instance SET Tree where
  type Elem Tree a = a
  empty = E

  member _ E = False
  member x (T l y _) | x<y = member x l
  member x (T _ y r) | x>y = member x r
  member _ _                 = True
  
  insert x E = T E x E
  insert x s@(T l y r) | x<y = T (insert x l) y r
  insert x s@(T l y r) | x>y = T l y (insert x l) 
  insert _ t                 = t
  
{-
Чтобы можно было и хэшмапу сделать
Alexander Vershilov, [01.10.19 00:44]
class SET s where
  type Elem s a :: *
  type C s a :: Constraint
  empty :: s a
  insert :: C s a => Elem s a -> s a -> s a
  member :: C s a => Elem s a -> s a -> Bool

Alexander Vershilov, [01.10.19 00:44]
instance SET Tree where
  type Elem Tree a = a
  type C Tree a = (Ord a)
  empty = E
  insert e E = T E e E
  insert e (T l x r) = case compare e x of
    LT -> T (insert e l) x r
    EQ -> T l x r
    GT -> T l x (insert e r)
  member e E = False
  member e (T l x r) = case compare e x of
    LT -> member e l
    EQ -> True
    GT -> member e r
-}
