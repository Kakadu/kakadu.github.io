{-# LANGUAGE TypeFamilies, FlexibleContexts, AllowAmbiguousTypes #-}
{-# LANGUAGE ExplicitForAll #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
module Heap where

import Data.Text.Lazy
import Debug.Trace
import Text.Printf (printf, PrintfArg)
import Data.GraphViz hiding (rank)
import Data.Graph.Inductive.Example
import Data.Graph.Inductive.Graph
import Data.Graph.Inductive.PatriciaTree (Gr)
import Data.GraphViz.Attributes.Complete
import Data.GraphViz.Printing (renderDot)
import System.IO.Temp (withSystemTempFile)
import GHC.IO.Handle
import System.Process (callProcess)

class HEAP h where
  empty       :: Ord a => h a
  isEmpty     :: Ord a => h a -> Bool

  insert      :: (Show a, Ord a) => a -> h a -> h a
  merge       :: (Show a, Ord a) => h a -> h a -> h a

  findMin     :: (Show a, Ord a) => h a -> a
  deleteMin   :: (Show a, Ord a) => h a -> h a

-- А не является ли ML более синтаксически чистым?
-- А то тут по идее надо везде Ord (Elem h a) писать

data Heap e = E | T Int e (Heap e) (Heap e) 
  -- deriving Show
  
instance (Show e) => Show (Heap e) where 
  show E = "E"
  show (T r n E E) = printf "(T  _ %s)"  (show n)
  show (T r n x y) = printf "(T  _ %s %s %s)"  (show n) (show x) (show y)

rank E = 0
rank (T r _ _ _) = r

makeT x a b | rank a >= rank b = 
  trace (printf "makeT case 1: x=`%s` a=`%s` b=`%s`" (show x) (show a) (show b)) $ 
  T (rank b + 1) x a b
makeT x a b                    = 
  trace (printf "makeT case 2: x=`%s` a=`%s` b=`%s`" (show x) (show a) (show b)) $ 
  T (rank a + 1) x b a

instance HEAP Heap where
  empty  = E
  isEmpty E = True
  isEmpty _ = False

  merge h E = h
  merge E h = h
  merge h1@(T _ x a1 b1) h2@(T _ y  _  _) | x <= y = 
    trace (printf "merge case 1: h1=`%s` h2=`%s`" (show h1) (show h2)) $
    makeT x a1 (merge b1 h2)
  merge h1@(T _ x  _  _) h2@(T _ y a2 b2)          = 
    trace (printf "merge case 2: h1=`%s` h2=`%s`" (show h1) (show h2)) $
    makeT y a2 (merge h1 b2)

  insert x h  = merge (T 1 x E E) h
  findMin   (T _ x _ _) = x
  findMin   E           = error "empty heap"
  deleteMin (T _ _ a b) = merge a b
  deleteMin E           = error "empty heap"

showSVG contents =
  withSystemTempFile "zzzz" $ \ _path h -> do
    putStrLn contents
    print _path
    hPutStr h contents
    hFlush h
    callProcess "dot" ["-Tsvg", _path, "-o", "/tmp/1.svg"]
    callProcess "xdg-open" ["/tmp/1.svg"]

type G = Gr String String 
type LastID = Int 

viz :: forall e . (Show e) => Heap e -> G
viz E           = Data.Graph.Inductive.Graph.empty
viz (T _ root l r) =
  let startG = insNode (1, show root) Data.Graph.Inductive.Graph.empty in
  helper startG   1   1 l $ \ lg last1 ->
  helper lg     last1 1 r $ \ ans _ -> ans

  where
    -- helper :: forall a . G -> LastID -> Int -> Heap e -> (G -> LastID -> a) -> a
    helper gr     id     _ E              k = k gr id
    helper gr lastId parId (T _ root l r) k =
      let withRoot =  insEdge (parId,lastId+1,"")   $ 
                      insNode (lastId+1, show root) $ gr in
      helper withRoot (lastId+1) (lastId+1) l $ \ lg leftLast ->
      helper lg       leftLast   (lastId+1) r $ k

ofList xs = Prelude.foldl (\h x -> insert (show x) h) Heap.empty xs

wrap xs = do
  let h = ofList xs
  let g = viz h
  print h
  showSVG $ unpack $ renderDot $ toDot $ graphToDot myParams g
  where 
    fmtNode (n,l) = [Label $ StrLabel $ pack l]
    myParams = case nonClusteredParams of
      Params a b c d e f _ h -> Params a b c d e f fmtNode h

main = do
  wrap [1..4]
  putStrLn "Hello, World."
  