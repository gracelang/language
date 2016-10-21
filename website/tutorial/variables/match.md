---
title: Match
keywords: tutorial, match, case
summary: An introduction to match
sidebar: tutorial_sidebar
permalink: /variables/match/
folder: tutorial
---
A match statement is useful for when you want to do a different action depending
on the value of some expression. Here's an example where the match statement
does something different for **cases** 1, 2, and 3:

```
def num = 3
match (num)
  case { 1 -> print "One" }
  case { 2 -> print "Two" }
  case { 3 -> print "Three" }
  case { _ -> "No case for this"}
```
The value that you want to match goes in the parentheses after `match`, and for every
case you want to consider, there is a `case`, followed by a block with the value,
then `->`, and the code that should be executed.

The last case is for when `num` doesn't match with any of the other cases.

In the following example, try changing the value of `x` and seeing how the program
runs differently.

<object id="example-1" data="{{site.editor}}?match" width="100%" height="550px"> </object>
