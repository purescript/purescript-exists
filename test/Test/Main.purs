module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Console (logShow)

import Data.Exists (Exists, mkExists, runExists)

data Tuple a b = Tuple a b

snd :: forall a b. Tuple a b -> b
snd (Tuple _ b) = b

data StreamF a s = StreamF s (s -> Tuple s a)

type Stream a = Exists (StreamF a)

nats :: Stream Int
nats = mkExists $ StreamF 0 (\n -> Tuple (n + 1) n)

head :: forall a. Stream a -> a
head = runExists head'
  where
  head' :: forall s. StreamF a s -> a
  head' (StreamF s f) = snd (f s)

data Maybe a = Nothing | Just a

count :: forall a. Maybe a -> Int
count Nothing = 0
count _ = 1

data FooF f = FooF (forall a. f a -> Int) (f String)

type Foo = Exists FooF

foo :: Foo
foo = mkExists $ FooF count (Just "test")

x :: Int
x = runExists runFooF foo
  where
  runFooF :: forall f. FooF f -> Int
  runFooF (FooF f fStr) = f fStr

main :: Effect Unit
main = logShow $ head nats
