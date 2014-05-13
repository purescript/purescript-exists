module Main where

import Debug.Trace
import Data.Exists

data Example a = Example a (a -> String)
 
runExample :: Exists Example -> String
runExample = runExists (\(Example a f) -> f a)
 
test = runExample (mkExists (Example "Done" show))

main = trace test
