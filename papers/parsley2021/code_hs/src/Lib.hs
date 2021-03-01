{-# LANGUAGE RankNTypes #-}

module Lib
    ( someFunc
    ) where

import Text.Parsec
import Control.Applicative ( (<**>) )

someFunc :: IO ()
someFunc = putStrLn "someFunc"

type Parser a = forall t s m u . (Stream s m t) => ParsecT s u m a

chainr1 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainr1 p op = scan
  where
    scan     = do { x <- p; rest x }
    rest x   = do { f <- op
                  ; y <- scan
                  ; return (f x y)
                  }
              <|> return x

chainr1_2 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainr1_2 p op = p >>= rest
  where
    rest x = (op >>= \f ->
              chainr1_2 p op >>= \y ->
              pure (f x y))
            <|> pure x

-- сложный переход

chainr1_3 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainr1_3 p op = p <**> rest
  where
    -- rest :: ParsecT s u m (a -> a)
    -- N.B. argumnet must go away
    rest =  (flip <$> op <*> chainr1_3 p op)
          <|> pure id


-- -------------------------------------------------------------------------------------------------

chainl1 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainl1 p op = do { x <- p; rest x }
  where
    rest x   = do { f <- op
                  ; y <- p
                  ; rest (f x y)
                  }
                <|> return x

chainl1_2 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainl1_2 p op        = p >>= rest
  where
    rest x  = op >>= \f ->
              p  >>= \y ->
              rest (f x y)
              <|> return x

chainl1_3 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainl1_3 p op        = p <**> rest
  where
    -- сложнее из-за рекурсии
{-     rest    =
      op >>= \f ->
        p >>= \y ->
        rest (f x y)
      <|> return id
 -}
    rest    =
      op >>= \f ->
        p >>= \y ->
        (\g x -> g (f x y)) <$> rest
      <|> return id

chainl1_4 :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m (a -> a -> a) -> ParsecT s u m a
chainl1_4 p op        = p <**> rest
  where
    -- Превращаем (\g x -> g (f x y)) в парсер, чтобы вытолкнуть rest наружу от байндов
    rest    =
      (op >>= \f ->
        p >>= \y ->
        pure (\g x -> g (f x y))) <*> rest
      <|> return id

chainl1_5 :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m (a -> a -> a) -> ParsecT s u m a
chainl1_5 p op        = p <**> rest
  where
    -- Превращаем (\g x -> g (f x y)) в парсер, чтобы вытолкнуть rest наружу от байндов
    rest    =
      (op >>= \f ->
        p >>= \y ->
        pure (\g x -> g (flip f y x))) <*> rest
      <|> return id

chainl1_6 :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m (a -> a -> a) -> ParsecT s u m a
chainl1_6 p op        = p <**> rest
  where
    -- Превращаем (\g x -> g (f x y)) в парсер, чтобы вытолкнуть rest наружу от байндов
    rest    =
      (op >>= \f ->
        p >>= \y ->
        pure (\g -> g . flip f y )) <*> rest
      <|> return id

chainl1_7 p op        = p <**> rest
  where
    -- flippаем .
    rest    =
      (op >>= \f ->
        p >>= \y ->
        pure (flip (.) (flip f y) )) <*> rest
      <|> return id

chainl1_8 p op        = p <**> rest
  where
    -- По закону функторов
    rest    =
      (op >>= \f ->
        p >>= \y ->
        flip (.) <$> pure (flip f y)) <*> rest
      <|> return id

chainl1_9 p op        = p <**> rest
  where
    -- fmap толкаем наружу байнда
    rest    =
      flip (.) <$>
        (op >>= \f ->
          p >>= \y ->
          pure (flip f y)) <*> rest
      <|> return id

chainl1_10 p op        = p <**> rest
  where
    -- fmap толкаем наружу байнда
    rest    =
      flip (.) <$>
        (flip <$> op <*> p) <*> rest
      <|> return id
