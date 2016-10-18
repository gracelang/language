---
title: For loops
keywords: tutorial, for, do, control structure
summary: An introduction to for loops
sidebar: tutorial_sidebar
permalink: /control/for/
folder: tutorial
---
Like most other languages, Grace has a `for ... do` statement that allows you to repeat
a block of code a fixed number of times — quite like a `repeat ... times` statement.
Compare to _repeat_, there are two important differences.


 1. The first argument to `for(_)do(_)` is not a single number, but some kind of _collection_
of objects. One of the simplest kinds of collection is a range of numbers, like `2..6`, 
which contains the five numbers `2`, `3`, `4`, `5` and `6`.  
The block of code that follows `do` will be executed as many times as there are elements in
this collection. So, for this example, it will be executed five times.
 2. The second argument — the block of code after `do` — must have a *parameter*.
The parameter to a block is declared
immediately after the opening brace, and is separated from the body of the block
by an arrow `→` (or `->`).  On each 
execution of the block, the parameter takes on a new value: _the next member of the collection_.
So, in the example below, on the first execution the parameter will be `2`, on the second 
execution it will be `3`, and so on.

We say that the for loop _iterates over_ the range.

For example:

<object id="example-1" data="{{site.editor}}?forRange" width="100%" height="550px"> </object>


Another kind of _collection_ object that you have already met is a [`String`]({{site.baseurl}}/variables/numstring). 
A string can be though of as a single piece of text, but it can _also_ be thought 
of as a sequence of individual letters, digits and symbols.  A for loop that 
uses a string as the first argument is said to _iterate over_ the string.

For example:

<object id="example-1" data="{{site.editor}}?forString" width="100%" height="550px"> </object>
