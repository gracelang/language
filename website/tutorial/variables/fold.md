---
title: Fold
keywords: tutorial, fold, accumulator, fold(_)startingWith(_)
summary: The Accumulator Pattern and Fold methods
sidebar: tutorial_sidebar
permalink: /variables/fold/
folder: tutorial
---

## Context
Suppose you want to find the sum of the elements of a collection.
You might write some code like this:
```
def input = [3, 5, 7, 9, 11, 13, 15, 17]

var accumulator := 0

for (input) do { each → 
    accumulator := accumulator + each 
}
```
This leaves the sum in the variable `accumulator`.

If instead you wanted to compute the product, you might write:
```
var accumulator := 1

for (input) do { each → 
    accumulator := accumulator * each 
}
```
If you wanted to concatenate the strings in a collection, you might write:
```
var accumulator := ""

for (input) do { each → 
    accumulator := accumulator ++ each 
}
```
This code pattern is very common; it's called the accumulator pattern.
You probably noticed that these examples were quite similar to each other.
In fact, the _only_ differences are
 1. the _operation_ that is applied to the accumulator and each element — addition, multiplication, and concatenation
 1. the _initial value_ of the accumulator — 0, 1 and the empty string.

## What is fold?

The method `fold (op) startingWith (initial)` captures this pattern. `fold(_)startingWith(_)`
is defined on all collections, including strings, sequences, lists and sets.
The first argument is a block with two parameters; it is a _block_ that describes the operation
to be performed on the accumulator and the elements.
The second argument is the initial value of the accumulator.

Let's re-write our three examples using fold:

<object id="example-1" data="{{site.editor}}?fold" width="100%" height="550px"> </object>

## Understanding fold

The general pattern for using fold is as follows:  

```
«collection».fold { «a», «b» → 
    «function»
} startingWith («initialValue»)
```
where `«collection»` is an expression that evaluates to any collection, 
`«a»` and `«b»` are any names you choose for the accumulator and the
current element, and `«function»` is some Grace code, normally using
the variables that you chose for `«a»` and `«b»`.
`«initialValue»` is the initial value of the accumulator.

Another way of thinking about folds, especially useful when the combining function can 
be written as an operator like `*`, is that it replaces the commas in the list
by the operator.  So
`fold { acc, each → acc * each } startingWith 1` transforms
`list [3, 5, 7, 9, 11, 13, 15, 17]` into `1 * 3 * 5 * 7 * 9 * 11 * 13 * 15 * 17`.

## Fold on Sets

Notice that we said that `fold(_)startingWith(_)` is defined on sets.  This is 
true even though sets have no defined ordering.  Consequently, the order in which the 
elements are folded is indeterminate.  This doesn't matter for operations like
`+` and `*`, which are themselves commutative.  For an operation like `++`, which
is _not_ commutative, the result of the fold with be concatenation in 
an arbitrary order.


