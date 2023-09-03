import Data.List
import System.IO

biggestInt, smallestInt :: Int
biggestInt  = maxBound
smallestInt = minBound

-- n :: Integer

reallyBig :: Integer
reallyBig = 2^(2^(2^(2^2)))

numDigits :: Int
numDigits = length (show reallyBig)
