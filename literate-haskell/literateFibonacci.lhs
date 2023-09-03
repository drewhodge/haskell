This ia a literate Haskell file.

> module Fib where

The following section of code consists of one-line comments.

> -- | Compute Fibonacci numbers
> -- Examples:
> --
> -- >>> fib 10
> -- 55
> --
> -- >>> fib 5
> -- 5

The following lines comprise the Fibonacci programme.

> fib :: Int -> Int
> fib 0 = 0
> fib 1 = 1
> fib n = fib (n - 1) + fib (n - 2)