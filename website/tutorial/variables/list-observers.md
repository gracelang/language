---
title: List Observer Methods
keywords: tutorial, list, observers
summary: An introduction to methods that let us observe lists and their elements
sidebar: tutorial_sidebar
permalink: /variables/list-observers/
folder: tutorial
---



To get a specific element from a list, you
can use the method `at(_)`, like this:

```
dialect "beginningStudent"
def animals = list("dog", "cat", "whale", "bird", "mouse")
print (animals.at 1)
print (animals at 4)

```
`animals.at 1`, returns `"dog"`, and
`animals.at 4`, returns `"bird"`.

```
size -> Number
// returns the number of elements in this list.

isEmpty -> Boolean
// returns true if this list is empty

first -> ElementType
// returns the first element of this list.  It's an error to request this method on an empty list

last -> ElementType
// returns the last element of this list.  It's an error to request this method on an empty list

at(n:Number) -> ElementType
// returns the n th element of this list.  It's an error if n is not between 1 and the size of this list. 

== (other) -> Boolean
// returns true if self and other contain the same elements, in the same order.

indices -> Sequence⟦Number⟧
// returns the sequence of this list's indices.   So, if `xs.size` is 5, 
// `xs.indices` is the sequence 1, 2, 3, 4, 5, which is written in Grace as `1..5`.

indexOf(sought:T)  -> Number
// returns the index of the first element v in this list such that v == sought.
// Raises NoSuchObject exception if there is no such element.

indexOf⟦W⟧(sought:T) ifAbsent(action:Block) -> Number
// returns the index of the first element v in this list such that v == sought.
// In that way, it's just like indexOf(_).  However, if there is no such
// element, this method executes the block of code action, and returns the
// resulting value.
```

Try out some of these methods by modifying this example code.
<object id="example-1" data="{{site.editor}}?lists" width="100%" height="550px"> </object>
