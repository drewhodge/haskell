---
title:      "Haskell Introduction"
date:       2023-08-24T14:40:57-04:00
tags:       ["haskell"]
identifier: "20230824T144057"
---

---
short-name:    haskell-intro
date:          24.Aug.2023
tags:          haskell, programming
identifier:    20230824T144057
---

# Haskell introduction

## Characteristics

  - Lazy
  - Functional

## Functional programmes

  - Functions are _first class_: they act as values that can be passed to other
    functions. 
  - Haskell programmes are centred around _evaluating expression_ rather than
    executing sequential instructions.

## Pure functions

Haskell functions are always _referentially transparent_:

  - Everything (data structures, variables, etc.) is _immutable_--not mutation.
  - Expressions never have side effects.
  - Calling the same function with the same arguments results in the same output
    every time.

Benefits of Haskell's 'purity':

   - _Equational reasoning and refactoring_--(replace equals with equals, as in algebra).
   - _Parallelism_-- evaluation in parallel is easy, there is no effect
     on other expressions.
   - _Fewer issues_--unrestricted effects in other programming paradigms result
     in code that can be hard to debug, maintain, and understand.

## Lazy

In Haskell, expressions are not evaluated until they are needed. The benfits of
this include the following:

  - Defining a new control structure is easy--just define a new function.
  - It is possible to have code with infinite data structures.
  - It enables a compositional programming stye, see [[#Wholemeal programming]].
  
## Statically typed

Every Haskell expression has a type. Types are checked at compile-time.
Programmes with type-errors will not compile.

## Wholemeal programming

A quotation from Ralf Hinze:

> Functional languages excel at wholemeal programming, a term coined by Geraint Jones. Wholemeal programming means to think big: work with an entire list, rather than a sequence of elements; develop a solution space, rather than an individual solution; imagine a graph, rather than a single path. The wholemeal approach often offers new insights or provides new perspectives on a given problem. It is nicely complemented by the idea of projective programming: first solve a more general problem, then extract the interesting bits and pieces by transforming the general program into more specialised ones.

## Abstraction

Haskell's features help to prevent repetition: parametric polymorphism,
higher-order functions, type classes. Compare the following code samples:

```java
int acc = 0;
for (int i = 0; i < lst.length; i++) {
  acc = acc + 3 * lst[i];
}
```

```haskell
sum (map (3*) lst)
```

Functional 
: The basic building blocks of programs are functions. Functions can return
functions and take functions as arguments. Also, the only looping construct in
Haskell is recursion.

Pure
: Haskell functions are pure, that is, they don't have side effects. Side
effects mean things like reading a file, printing out text, or changing global
variables. All inputs to a function must be in its arguments, and all outputs
from a function in its return value. This sounds restricting, but makes
reasoning about programs easier, and allows for more optimizations by the
compiler.

Lazy
: Values are evaluated only when they are needed. This makes it possible to work
with infinite data structures, and also makes pure programs more efficient.

Strongly typed
: Every Haskell value and expression has a type. The compiler checks the types
at compile-time and guarantees that no type errors can happen at runtime. This
means no AttributeErrors (a la Python), ClassCastExceptions (a la Java) or
segmentation faults (a la C). The Haskell type system is very powerful and can
help design better programs.

Type inferred
: In addition to checking the types, the compiler can deduce the types for most
programs. This makes working with a strongly typed language easier. Indeed, most
Haskell functions can be written completely without types. However programmers
can still give functions and values type annotations to make finding type errors
easier. Type annotations also make reading programs easier.

Garbage-collected 
: Like most high-level languages these days, Haskell has automatic memory
management via garbage collection. This means that the programmer doesn't need
to worry about allocating or freeing memory, the language runtime handles all of
it automatically.

Compiled
: Haskell is a compiled language. Haskell programs can be compiled to very
efficient binaries, and the GHC compiler is very good at optimising functional
code into performant machine code.

---
