---
title: For loops
keywords: tutorial, for, do, control structure
summary: An introduction to for loops
sidebar: tutorial_sidebar
permalink: /control/for/
folder: tutorial
---
Like most other languages, Grace has a `for ... do` statement that allows you to repeat
a block of code a fixed number of times — very much like a `repeat ... times` statement.
It looks like this:
```
for («collection») do { «variable» → 
    «statements»
}
```
where the quoted components `«collection»`, `«variable»`, and `«statements»` 
must be replaced by Grace program elements.

Compared to _repeat_, there are two important differences.

 1. The first argument to `for(_)do(_)` is not a single number, but some kind of _collection_
of objects. One of the simplest kinds of collection is a range of numbers, like `2..6`, 
which contains the five numbers `2`, `3`, `4`, `5` and `6`.  
The block of code that follows `do` will be executed as many times as there are elements in
this collection. So, for this example, 
```
for (2..6) do { «variable» → 
    «statements»
}
```
it will be executed five times.

 2. The second argument — the block of code after `do` — must declare a single variable
to play the role of  *parameter* to the block.
The `«variable»` comes
immediately after the opening brace, and is separated from the body of the block
by an arrow `→` (or `->`), like this:
```
for (2..6) do { num → 
    «statements»
}
```
Here the variable `num` is used as the parameter.  On each 
execution of the block, the `«variable»` `num` takes on a new value: _the next element of the collection_.
The variable `num` is like a parameter in a method, because each time the block is executed,
`num` takes on a potentially different value.
So, in the example above, on the first execution the `num` will have the value `2`, on the second 
execution `num` will be `3`, and so on, until on the last execution, `num` will be 6.

We say that the for loop _iterates over_ the collection.

Like any other variable, you can call the variable anything you want, but it's wise
to use a name that reminds the reader of what it is.  So if you are iterating over numbers,
`num` or `n` might be a good choice; for characters in a string, `ch` might be good.
For indexes in a list, you might use `i` or `ix`, and so on.  I often use the name
`each` if no better name suggests itself.

Of course, to make this example runnable, you have to replace `«statements»` by the 
Grace statements that you want to execute repeatedly.  These statements make
up what is called the _body_ of the for loop, and they will normally mention the
loop variable — if they don't mention it, you might not want to use a for loop!

Here is the complete example:

<object id="example-1" data="{{site.editor}}?forRange" width="100%" height="550px"> </object>


Another kind of _collection_ object, which you have already met, is a [`String`]({{site.baseurl}}/variables/numstring). 
You can think of a string as a single piece of text, but you can _also_ think  
of it as a sequence of individual letters, digits and symbols.  A for loop that 
uses a string as the first argument is said to _iterate over_ the string.

Here is an example using a string:

<object id="example-1" data="{{site.editor}}?forString" width="100%" height="550px"> </object>

If you are still confused about the rôles of the two arguments to `for(_)do(_)`, 
look at some [for loop examples]({{site.baseurl}}/control/for-examples).
