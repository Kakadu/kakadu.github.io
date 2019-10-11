{-# LANGUAGE TypeFamilies, FlexibleContexts, AllowAmbiguousTypes #-}
{-# LANGUAGE ExplicitForAll #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
module Main where

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

import Heap
import LeftistHeap

instance (Show e) => Show (LeftistHeap e) where
  show E = "E"
  show (T r n E E) = printf "(T  _ %s)"  (show n)
  show (T r n x y) = printf "(T  _ %s %s %s)"  (show n) (show x) (show y)

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

viz :: forall e . (Show e) => LeftistHeap e -> G
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
