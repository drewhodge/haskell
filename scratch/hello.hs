main :: IO ()
main = putStrLn "Hello Haskell"

greet :: String -> String -> String
greet "England" name = "Hello " ++ name

factorial :: Int -> Int
factorial 1 = 1
factorial n = n * factorial (n-1)
