{- ............................................................................ 
File name: goldenRation.hsLex

Purpose: A simple Haskel file that does some arithmetic and prints some values.
...............................................................................
Hostory:
29.Aug.2023    Created. (Haskell-MOOC, University of Helsinki)
               https://haskell.mooc.fi/part1#the-structure-of-a-haskell-program
-}

module Gold where

-- The golden ratio
phi :: Double
phi = (sqrt 5 + 1) / 2

polynomial :: Double -> Double
polynomial x = x^2 - x - 1

f x = polynomial (polynomial x)

main = do
  print (polynomial phi)
  print (f phi)