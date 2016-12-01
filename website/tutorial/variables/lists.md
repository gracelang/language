---
title: Lists
keywords: tutorial, list
summary: An introduction to lists
sidebar: tutorial_sidebar
permalink: /variables/lists/
folder: tutorial
---
**Lists** are a kind of Object that can hold multiple values; these values
are called the a **elements** of
the list. A list is created like this:

```
def animals = list ["dog", "cat", "whale", "bird", "mouse"]
def sizes = list [52, 78, 45, 23]
```

The first declaration creates a list with five string elements, and binds
it to the name `animals`; the second declaration creates a list containing
four numbers, and bind it to the name `sizes`.
It doesn't matter how many elements you put between the `[ ]`; a list can contain
arbitrarily many things. Moreover, the ”things“ can be any kind of object.
We have used numbers 
and strings, but the elements can be anything — even other lists.
Also note that you can put _no_ elements in a list, creating an empty list.

```
def empty = list [ ]
```

## Basic Operations On lists

To get a specific element from a list, you
can use the method `at(_)`, like this: `animals.at(1)`, which returns `"dog"`
or `animals.at(4)`, which returns `"bird"`.

Lists are the first kind of *mutable* object that we have met in Grace.
What does “mutable” mean?  Simply that, after a list is created, you can _modify_ it.  
To add an element to the list, use `animals.addLast "squirrel"` or
`animals.addFirst "badger"`, depending on whether you want to make the
new element the last or the first one in the list. 
To remove an element from a list, use `animals.removeLast`, `animals.removeFirst`.
You can also say `animals.remove "whale"`.

Notice that adding or removing the `first` element of the list will change the
position of all of the elements in the list.  So, after `animals.addFirst "badger"`
`animals.at 1` will be "badger", and not "dog"; instead, `animals.at 2` will be "dog".

Try out some of these methods by modifying this example code.
<object id="example-1" data="{{site.editor}}?lists" width="100%" height="550px"> </object>

## Changing Individual Elements

In addition to adding elements to a list and and removing elements from it,
you can also _change_ the element stored at a specific index.  To do this, 
use the method `at (index) put (newValue)`.  Here, `index` must be an integer
between 1 and the size of the list, and `newValue` is the object that you want
to store there.  Try modifying these examples.


<object id="example-2" data="{{site.editor}}?lists-at-put" width="100%" height="550px"> </object>


## Additional List Operations

You can request many other methods on list.
Here are a few of the more common ones:

```

size -> Number
// returns the number of elements in this list.

++ (other) -> List
// returns a new list formed by concatenating this list and other; other can
// be any Collection, such as a string or another list.  

== (other) -> Boolean
// returns true if self and other contain the same elements, in the same order.

contains(soughtFor) -> Boolean
// returns true if this list contains the element soughtFor.

sort -> List
// Modifies this list by sorting it in-place.  Sorting uses the < and == methods
// on the elements of this list.

sorted -> List
// returns a new list that contains the same elements as this list, but in sorted 
// order, as determined by the < and == methods on the elements of this list.
```

Here are some examples; edit them and try some variations.  Make sure that you
understand _why_ you are seeing the results that you see.
<object id="example-3" data="{{site.editor}}?lists2" width="100%" height="550px"> </object>

## List Reference

Here is the documentation for all methods on [Lists]({{site.baseurl}}/dialects/standard/#list)

## Lists as Collections

Lists are a particular kind of collection.  Other collections include 
sets, ranges and strings.  Like all collections, if you need to do some operation 
to every element of the collection, you can use a [for loop]({{site.baseurl}}/control/for)
or the [`do` method]({{site.baseurl}}/variables/do).

In addition to `do`, there are several other useful methods on collections.
This tutorial discusses  [`fold(_)startingWith(_)`]({{site.baseurl}}/variables/fold)
and [`map(_)`]({{site.baseurl}}/variables/map).  The full list is in the
[specification of the standard dialect]({{site.baseurl}}/dialects/standard/#common-abstractions).
