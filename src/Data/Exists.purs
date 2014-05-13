module Data.Exists where

foreign import data Exists :: (* -> *) -> *
 
foreign import mkExists
  "function mkExists(fa) {\
  \  return fa;\
  \}" :: forall f a. f a -> Exists f
  
foreign import runExists
  "function runExists(f) {\
  \  return function(fa) {\
  \    return f(fa);\
  \  };\
  \}" :: forall f r. (forall a. f a -> r) -> Exists f -> r
