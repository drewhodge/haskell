{- ............................................................................ 
File name: goldenRation.hsLex

Purpose: A simple Haskel file that does some arithmetic and prints some values.
...............................................................................
Hostory:
29.Aug.2023    Created. (Haskell-MOOC, University of Helsinki)
               https://haskell.mooc.fi/part1#the-structure-of-a-haskell-program
-}

}A simple Haskell programme that does some arithmetica and prints some values.

There is one Haskel module per source file.

> module Gold where

Single line comments begin with '--'.
The comment is followed by a definition of the constant phi, with an accompanying type annotation (also known as a type signature) phi :: Double. The type annotation means that phi has type Double. The line with a equals sign (=) is called an equation. The left hand side of the = is the expression we are defining, and the right hand side of the = is the definition.

In general a definition (of a function or constant) consists of an optional type annotation and one or more equations.

> -- The golden ratio
> phi :: Double
> phi = (sqrt 5 + 1) / 2

The following definition is of a function called polynomial. It has a type annotation and an equation. Note how an equation for a function differs from the equation of a constant by the presence of a parameter x left of the = sign. Note also that ^ is the power operator in Haskell, not bitwise xor like in many other languages.

> polynomial :: Double -> Double
> polynomial x = x^2 - x - 1

The following code defines a function called f. Note the lack of type annotation. (f :: Double -> Double)

> f x = polynomial (polynomial x)

> cube :: Double -> Double
> cube x = x^3

> g x = cube (cube x)

The following code describes what happens when we run the program. It uses do-syntax and the IO Monad.

> main = do
>   print (polynomial phi)
>   print (f phi)