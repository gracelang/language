---
title: The random Module
keywords: random, pseudo-random, RNG, PRNG
sidebar: modules_sidebar
permalink: /modules/random/
toc: false
folder: Modules
author:
- 'Andrew P. Black'
---
## Pseudo-Random Numbers

The *random* module object can be imported using
`import "random" as rand`, for any identifier of your choice, e.g. `rand`. 
The
object `rand` responds to the following requests.

```
    between0And1 -> Number
    // returns a pseudo-random number in the interval [0..1)

    between (m: Number) and (n: Number) -> Number
    // returns a pseudo-random number in the interval [m..n)

    integerIn (m: Number) to (n: Number) -> Number
    // returns a pseudo-random integer in the interval [m..n]
```
