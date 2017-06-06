---
title: Examples of Simple for-loops
keywords: tutorial, for, do, control structure
summary: Examples of for-loops iterating over Strings, Ranges and Lists.
sidebar: tutorial_sidebar
permalink: /control/for-examples/
folder: tutorial
---


## The arguments to `for(_)do(_)`

It's easy to become confused about what your for loop is iterating over,
and what values the parameter to the _do-block_ body takes on.

 * The first argument to `for()do(_)` *must* to be a `Collection` of some kind.
   Remember, strings are `Collections`, as are lists, sequences, sets,
   dictionaries and ranges.

 * The second argument must be a block with a single parameter: the _do-block_.
   The block parameter (the variable before the `→`) will be given a
   different value each time the do-block is executed.

 * How many times will be do-block be executed?  As many times as there are
   elements in the collection.

 * What values will the parameter take on?  The elements of the collection (and
   *not* the indices of those elements).

Lets look at some simple examples.

## Iterating over a String

<object id="example-1" data="{{site.editor}}?for-string-trivial" width="100%" height="350px"> </object>

In the example above, the for loop is iterating over the string `"wombat"`; the values of `x` are
the single-character strings `"w"`, `"o"`, `"m"`, etc.  So that's what is printed,
one character to a line.
Change the body of the do-block to accumulate the characters of the string in
reverse order, or to count the number of vowels.

## Iterating over a Sequence or Range

<object id="example-1" data="{{site.editor}}?for-numbers" width="100%" height="350px"> </object>

In the example above, the first argument to the for loop is the sequence `1..6`.
So the values bound to `x` will be `1` on the first iteration, `2` on the second,
`3` on the third, and so on.  The `print` statement demonstrates this for you.
Change the do-block to calculate the sum of the elements in the sequence.

<object id="example-1" data="{{site.editor}}?for-list" width="100%" height="350px"> </object>

## Iterating over a List

In the example above, the first argument to the for loop is the list containing the thee elements `34`, `67`, `98`.
So the values bound to `x` will be `34` on the first iteration, `67` on the second, and `98` on the third.
Once again, the `print` statement demonstrates this for you.
Change the do-block to check that the elements are in sorted order.

Notice the difference between the above code and the final example:

<object id="example-1" data="{{site.editor}}?for-list-indices" width="100%" height="350px"> </object>

In the example above, the first argument to the for loop is the value
of `a.indices`.  What is that?  `a.indices` is the collection of valid indices
into the list `a` — in this case the range `1..3`, because `a.size` is `3`.

Hence, the values bound to `x` will be `1` on the first iteration,
`2` on the second, and `3` on the third.
If we want to access the _elements_ of a, then we need to use `a.at(_)`, as
demonstrated by the `print` statement, which prints out the element index,
a colon, and then the element itself.

Now modify the loop body to replace each element of the list `a` by its square.
