Basic Haskell
-------------

Note This is a literate Haskell page: you can load it directly into ghci by following these steps.
Introduction
The following is based in part on https://www.haskell.org/tutorial/, other Haskell web resources, and the 2014 book Thinking Functionally in Haskell by Richard Bird.

Haskell is a purely functional programming language, where all expressions yield values, and all values have types. Haskell is similar in spirit to Lisp, in that both are inspired by the lambda calculus. However, there are some major differences:

Haskell syntax is generally more human reader-friendly than Lisp — the designers of the language made readability a priority. For instance, arithmetic expressions are written in regular infix notation, e.g. 2 * 3 + 4 instead of (+ (* 2 3) 4).

Haskell is statically type-checked, meaning that type errors can be found before the program runs (i.e. at compile-time). In contrast, Lisp type errors are usually only discovered at run-time.

In addition to being statically typed, Haskell uses type inference, so that in many cases it is not necessary to explicitly state types. Instead, Haskell can often infer correct types.

Haskell uses an evaluation strategy known as lazy evaluation. The basic idea is that an expression is not evaluated until it is needed. Often this strategy ends up being the same as regular non-lazy evaluation done in most other languages, but it does have a number of consequences, such as:

Potentially improved performance — expressions that are never evaluated run fast.

On the downside, it can be hard to predict the performance of lazy evaluation ahead of time. This could be a problem in, for instance, a real-time system where it is required that a calculation finish in a specific amount of time.

The possibility of infinite data structures. Interestingly, this has some practical uses and can simplify some kinds of code.

Control-flow abstractions can be written using ordinary functions. In Lisp, you can do this with macros, but macros dont work the same way as ordinary functions.

Haskell is purely functional, and does not have loops or assignment statements as found in most mainstream programming languages. Haskell encourages the use of functions, and higher-order functions, like map, filter, and fold.

While Haskell is not object-oriented, it has good support for abstraction, e.g. type classes and algebraic data types.

For programmers coming from traditional languages, Haskell can seem overwhelming at first because it has so many novel features. Plus it has mainly been developed by academics instead of practitioners, and so a lot of the discussion around Haskell is based on mathematics and theory.

Pure Functions
An important idea in Haskell is the notion of a pure function. In Haskell, a function is said to be pure if it satisfies these two properties:

It always returns the same result for the same arguments.

For example, suppose f 5 returns the value 2. If f is pure, you can be sure that f 5 will always return 2 no matter when it is called, or how many times you call it.

What a pure function f returns cannot depend upon anything except the input to f. If f is pure, it cannot depend upon any global variables or other internal state that might change from call to call.

This restriction rules out some useful functions. For example, in C/C++, the rand() function returns a randomly chosen non-negative integer. That means rand() is not pure: calling rand() doesn't always give the same result.

Another example is the input(prompt) function in Python, which gets input from the user. The string that input("What's your name? ") returns depends upon what the user types, and so it is not a pure function.

It has no side-effects.

Side-effects are things like printing to the screen, reading/writing files, or communicating to other computers on the Internet are example of side-effects. In other, most interactions with the outside world — nearly everything that makes computers useful! — involve side-effects.

Haskell encourages the use of pure functions, since they are easier to reason about than non-pure functions. Indeed, pure functions in Haskell are very similar to the functions used in mathematics. Mathematical functions are pure: they have no side effects, and no state.

But there's a big problem with pure functions: they disallow certain vital and useful functions. For instance, a function that opens a file on disk can't be pure because its results will depend on whether or not the file exists. A function returns input from a use is also non-pure because it could return different results every time it's called (i.e. the user can type different input).

So pure functions can't be the only kind of function in a useful programming language. Lisp deals with this problem by simply allowing pure and non-pure functions to work together, leaving it up to the programmer to deal with the consequences.

Haskell, however, has a different approach to impurity. Impure functions are permitted inside do-environments. The use and design of these environments is one of the most significant features of Haskell, and we'll have more to say about it later.

For now, we will stick to pure functions.

Basic Features of GHCI
Like Lisp, we often interact with Haskell through its interpreter. We'll uses "ghci" in these notes, e.g.:

GHCi, version 7.6.3: http://www.haskell.org/ghc/  :? for help
Loading package ghc-prim ... linking ... done.
Loading package integer-gmp ... linking ... done.
Loading package base ... linking ... done.

Prelude> 1 + 2 * 3
7
Prelude> (1 + 2) * 3
9
Prelude>
Right away you can see that Haskell uses regular infix notation for arithmetic expressions.

Here's a simple example of a Haskell function declaration:

> inc :: Integer -> Integer   -- type signature
> inc n = n + 1

The name of this function is inc. It takes one input, n, of type Integer, and returns one value, also of type Integer. The token :: can be read "has type".

Source code comments in Haskell start with --, and continue to the end of the line.

To call inc, write its function name followed by its input. For example:

> inc 5

> inc 8

We'll often want to know an expression's type, and for that we'll use the :type operator (:t for short). For example:

> :type inc

> :type inc 4

The types of some expressions can be more complex types than you expect. For example:

> :type 5

> :type 5.3

For the moment we will ignore these complexities. But the basic idea is that a is any type of value that implements all the requirements of a Num.

Here are a couple more sample functions:

-- calculate the length of the hypotenuse of a right-triangle
-- with leg lengths a and b
hyp a b = sqrt (a*a + b*b)

-- calculate the distance between points (x, y) and (a, b)
dist x y a b = hyp (x - a) (y - b)
Usually you type functions into a file and load the file with :load (:l for short).

Negative Numbers
Haskell has a small problem with negative numbers:

> inc -1

    <interactive>:12:5:
    No instance for (Num (Integer -> Integer))
      arising from a use of `-'
    Possible fix:
      add an instance declaration for (Num (Integer -> Integer))
    In the expression: inc - 1
    In an equation for `it': it = inc - 1
To deal with this, you often need to write negative numbers inside brackets:

> inc (-1)

Sometimes you need the brackets, sometimes you don't, e.g.:

> -2      -- ok

> -2 + 1  -- ok
1
> 1 + -2  -- oops: -2 doesn't work here!

<interactive>:16:1:
    Precedence parsing error
        cannot mix `+' [infixl 6] and prefix `-' [infixl 6] in the same infix expression

> 1 + (-2)   -- need () around -2
1
The problem is caused by a parsing ambiguity that Haskell has with -. In Haskell, the expression x-1 could mean "subtract 1 from variable x", or it could mean "apply function x to -1". The brackets are needed to avoid this ambiguity in some cases.

Languages like C don't have this problem because the expression x-1 only has one meaning: subtract 1 from x. In C, function calls always use (), and so the expression x(-1) is what you must write to call x when it's a function.

Calling Functions
Consider these two expressions:

> inc 3       -- ok

> inc inc 3   -- oops: error!

<interactive>:21:1:
    Couldn't match expected type `a0 -> t0' with actual type `Integer'
    The function `inc' is applied to two arguments,
    but its type `Integer -> Integer' has only one
    In the expression: inc inc 3
    In an equation for `it': it = inc inc 3

<interactive>:21:5:
    Couldn't match expected type `Integer'
                with actual type `Integer -> Integer'
    In the first argument of `inc', namely `inc'
    In the expression: inc inc 3
    In an equation for `it': it = inc inc 3
The expression inc inc 3 is an error because Haskell first evaluates inc inc. This is a type error: inc requires a parameter of type Integer, but we've passed it inc which has type Integer -> Integer.

One solution is to use brackets:

> inc (inc 3)

Another solution is to use the $ operator:

> inc $ inc 3

$ is the low-priority application operator, and is often used to reduce the number of brackets in expressions. Once you get used to it, it can be quite handy. However, many newcomers to Haskell find it confusing, so use the brackets if you prefer.

Polymorphic Types
The Haskell type Integer is an example of a concrete type that mirrors the mathematical notion of an integer. However, Haskell functions are often written using polymorphic types, where the exact types are not specified.

To understand Haskell's polymorphic types, lets first look at lists. In Haskell, lists are written using square-brackets, and elements are separated by commas. For example, the list ['a', 'b', 'c'] has the type [Char], i.e. it's a list of Char values.

The elements on a list must all be of the same type. For example, you could have a list of functions:

> :type [inc, inc, inc]

But the following list is not allowed because it has two different types of values:

> [1, 2, 'a']

<interactive>:54:2:
    No instance for (Num Char) arising from the literal `1'
    Possible fix: add an instance declaration for (Num Char)
    In the expression: 1
    In the expression: [1, 2, 'a']
    In an equation for `it': it = [1, 2, 'a']
Thus, in Haskell, if L is a list, then you know for certain that all the elements of L have the same type.

Now lets look at a list function. len uses recursion to calculate the length of a list:

> len :: [a] -> Integer      -- type signature: [a] is a list of any type
> len []     =  0            -- base case
> len (x:xs) =  1 + len xs   -- recursive case

len consists of two equations. The first equation defines the base case: [] is the empty list, and it has length 0. The second equation applies the recursive case to any non-empty list. It uses pattern matching to extract the head and rest of the list.

The expression x:xs is a nice syntax for getting the first element, and the rest of the elements, of a list. For example, when you evaluate len [1, 2, 3], [1, 2, 3] gets matched by x:xs, and x is bound to 1 and xs is bound to [2, 3]. In Lisp, we would have to use a let environment with car and cdr functions to do the same thing.

The names in the expression x:xs are just a convention. The x refers to the first element of the list, while xs is the plural of x because it refers to the rest of the list elements. You could, if you prefer, write first:rest, a:b, or even car:cdr.

Haskell also provides standard functions head and tail that work like this:

> head [1, 2, 3]

> tail [1, 2, 3]

Note that it's an error to call head` or `tail` on an empty list:

> head []

> tail []

What are the type signatures for head and tail? For head, the input is any list, and the result is the first element of the list. A general list has the type [a], where a is any type. So, the type signature of head must be [a] -> a, i.e. it takes a list of values of type a, and returns a value of type a.

Similarly, tail takes a list of values of type a as input, and returns a list of values of type a. So its type signature is [a] -> [a].

You can verify these type signatures using :type:

> :type head

> :type tail

You might think that the function tail has the type a -> a, i.e. it takes a value of type a as input and gives an output of type a. But that's too general. It's an error, for example, to evaluate tail 5 because tail requires a list type as input.

Similarly, you might think that tail has the type [Integer] -> [Integer]. But that type is too specific: it says that tail would only work with Integer lists.

Haskell uses type inference at compile time to do this type checking, and is careful to get just the right type, i.e. not too general and too specific. This turns out to be a non-trivial task, and Haskell uses the Hindley-Milner type system to figure out the correct types for expressions.

When len [1, 2, 3] is evaluated, Haskell checks the equations of len in the order they are written. So first it tries to match len [] = 0. This fails, because [] doesn't match [1, 2, 3]. Then it moves on to the second equation, which it does match.

len works with any type of list, e.g.:

> len [1, 2, 3]          -- [1, 2, 3] :: [Integer]

> len ['a', 'b', 'c']    -- ['a', 'b', 'c'] :: [Char]

> len [[1], [2], [3]]    -- [[1], [2], [3]] :: [[Integer]]

> len [len, len, len]    -- [len, len, len] :: [[a] -> Integer]

Some Useful List Functions
Haskell provides a number of helper functions for lists. For example, you can create a range of numbers like this:

> [1..5]

> [4..9]

You can also have an increment, e.g.:

> [2,4..10] [2,4,6,8,10]

> [0,5..20] [0,5,10,15,20]

++ concatenates lists:

> [1,2,3] ++ [4..8]

> [1,2,3] ++ [-1,-2,-3]

> [1] ++ [2,3] ++ [4,5,6]

> [1..3] ++ [2..6]

++ is an example of an infix operator, and some places you must put it in round brackets:

> :type ++    -- oops!

> :type (++)  -- brackets required

Strings
Haskell strings are lists of characters, i.e. a string has the type [Char]:

> :type "apple"

Haskell pre-defines the type String like this:

type String = [Char]   --- String is a synonym for [Char]
Since strings are just lists of characters, all list functions work with strings. For example:

> head "apple"

> tail "apple"

> len "apple"

> "apple" ++ "s"

> ['r', 'a', 'c', 'e'] ++ "car"

Curried Functions
Consider the following function:

> add :: Integer -> Integer -> Integer  -- type signature
> add x y =  x + y

add sums two integers, x and y. It's type signature is a bit strange: it says that add takes two Integer values as input, and returns an Integer as output.

The type Integer -> Integer -> Integer is the same as Integer -> (Integer -> Integer). The bracketed version highlights a basic feature of Haskell: if you call add with a single Integer (instead of two) then it returns a value of type Integer -> Integer, i.e. a function that takes one Integer and returns an Integer.

For example, add 3 evaluates to a function. You could use it like this:

> inc3 = add 3

Now inc3 is a function that takes one input and returns that input incremented by 3:

> inc3 4

inc3 takes an Integer and returns an Integer:

> :type inc3

Notice that we did not need to write a type signature for inc3 — Haskell was able to infer it automatically.

Curried functions can be useful in practice. For example, Haskell has a map function: map f lst applies function f to every element of lst. If we wanted to add 1 to every element of a list of integers, we could do it like this:

> map (add 1) [1,2,3]

This also works with the built-in +:

> map (+ 1) [1,2,3]

Here's another example. Recall that ++ concatenates two lists:

> [1, 2] ++ [6, 8, 6]

Here's its type:

> :type (++)

The type [a] -> [a] -> [a] is equivalent to [a] -> ([a] -> [a]), and so if we were to pass ++ a single input, it would return a value of type [a] -> [a], i.e. a function that takes any list of a values and returns another list of a values.

++ is an infix operator, which means that it is normally put between its inputs. Alternatively, you can use ++ (and many other infix operators) in prefix style by putting brackets around it:

> (++) "ab" "cd"

So we could write this function, which adds "- " to the start of a string:

> dash = (++) "- "

For instance:

> dash "apples"

> map dash ["apples", "oranges", "grapes"]

Or you could use currying to defined this function:

> dashed = map dash

Then:

> dashed ["apples", "oranges", "grapes"]

Look carefully at the definition of dashed: it's a function that was defined without using any if-statements, loops, recursion, variables, or lambda. This kind of function definition is generally looked upon as a good thing in Haskell. It is short, easy to understand (once you get used to Haskell at least!), consists of previously made functions, and is type-checked.