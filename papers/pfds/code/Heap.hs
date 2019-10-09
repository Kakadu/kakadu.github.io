{-# LANGUAGE TypeFamilies, FlexibleContexts, AllowAmbiguousTypes #-}
module Heap where

import Data.Text.Lazy
import Data.GraphViz hiding (rank)
import Data.Graph.Inductive.Example
import Data.Graph.Inductive.Graph
import Data.Graph.Inductive.PatriciaTree (Gr)
import Data.GraphViz.Printing (renderDot)
import System.IO.Temp (withSystemTempFile)
import GHC.IO.Handle
import System.Process (callProcess)

class HEAP h where
  empty       :: Ord a => h a
  isEmpty     :: Ord a => h a -> Bool

  insert      :: Ord a => a -> h a -> h a
  merge       :: Ord a => h a -> h a -> h a

  findMin     :: Ord a => h a -> a
  deleteMin   :: Ord a => h a -> h a

-- А не является ли ML более синтаксически чистым?
-- А то тут по идее надо везде Ord (Elem h a) писать

data Heap e = E | T Int e (Heap e) (Heap e)


rank E = 0
rank (T r _ _ _) = r

makeT x a b | rank a >= rank b = T (rank b + 1) x a b
makeT x a b                    = T (rank a + 1) x b a

instance HEAP Heap where
  empty  = E
  isEmpty E = True
  isEmpty _ = False

  merge h E = h
  merge E h = h
  merge h1@(T _ x a1 b1) h2@(T _ y  _  _) | x<y = makeT x a1 (merge b1 h2)
  merge h1@(T _ x  _  _) h2@(T _ y a2 b2)       = makeT y a2 (merge h1 b2)

  insert x h  = merge (T 1 x E E) h
  findMin   (T _ x _ _) = x
  deleteMin (T _ _ a b) = merge a b

showSVG contents =
  withSystemTempFile "zzzz" $ \ _path h -> do
    print _path
    hPutStr h contents
    hFlush h
    callProcess "dot" ["-Tsvg", _path, "-o", "/tmp/1.svg"]
    callProcess "xdg-open" ["/tmp/1.svg"]


shit :: Heap Int -> Gr String String
shit E           = Data.Graph.Inductive.Graph.empty
shit (T _ x l r) =
  let startG = (insNode (1, show x) Data.Graph.Inductive.Graph.empty) in
  helper startG   1   1 l $ \ lg last1 ->
  helper lg     last1 1 r $ \ ans _ -> ans

  where
    helper gr     id     _ E              k = k gr id
    helper gr lastId parId (T _ root l r) k =
      let withRoot = insEdge (parId,lastId+1,"") $ insNode (lastId+1, show root) gr in
      helper withRoot (lastId+1) (lastId+1) l $ \ lg lastId ->
      helper lg       lastId     (lastId+1) r $ k


main = do
  -- let s = unpack $ renderDot $ toDot $ graphToDot nonClusteredParams clr479
  -- asdf s

  -- g :: Graph String String
  let g = shit h0
  showSVG $ unpack $ renderDot $ toDot $ graphToDot nonClusteredParams g
  putStrLn "Hello, World."
  where
    h0 :: Heap Int
    h0 = insert 1 $ insert 2 $ insert 3 $ insert 4 $ insert 5 $ insert 6 $ insert 7 $ Heap.empty
