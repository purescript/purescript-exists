module Main where

import Console 
import Data.Exists

data Tuple a b = Tuple a b

snd :: forall a b. Tuple a b -> b
snd (Tuple _ b) = b

data StreamF a s = StreamF s (s -> Tuple s a) 

type Stream a = Exists (StreamF a)

nats :: Stream Number
nats = mkExists $ StreamF 0 (\n -> Tuple (n + 1) n)

head :: forall a. Stream a -> a
head = runExists head'
  where
  head' :: forall s. StreamF a s -> a
  head' (StreamF s f) = snd (f s) 

main = print $ head nats
