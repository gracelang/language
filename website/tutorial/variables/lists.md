---
title: Lists
keywords: tutorial, list, mutable, collection
summary: An Introduction to Lists and their operations
sidebar: tutorial_sidebar
permalink: /variables/lists/
folder: tutorial
---
**Lists** are a kind of Object that can hold multiple values; these values
are called the a **elements** of
the list, and can be any other objects.
Lists let us access individual elements using the method `at(_)`, and 
iterate over their contents using the method `do`, or using `for(_)do(_)`. 

In _standardGrace_, a list is created like this:

```
def animals = list ["dog", "cat", "whale", "bird", "mouse"]
def sizes = list [52, 78, 45, 23]
```
and in dialect _beginningStudent_, which does not use square brackets, like this:

```
dialect "beginningStudent"
def animals = list("dog", "cat", "whale", "bird", "mouse")
def sizes = list(52, 78, 45, 23)
```

The first declaration creates a list with five string elements, and binds
it to the name `animals`; the second declaration creates a list containing
four numbers, and binds it to the name `sizes`.
It doesn't matter how many elements you put into the list; a list can contain
arbitrarily many things. Moreover, the “things” can be any kind of object.
We have used numbers 
and strings, but the elements can be anything — even other lists.
Also note that you can put _no_ elements in a list, creating an empty list.

```
def empty = list [ ]
```

or, in _beginningStudent_

```
dialect "beginningStudent"
def empty = emptyList
```

## Lists are Mutable

One of the most confusing things about list to beginners is thatthey aer _mutable_.
What does that mean?  Lets' explain.

Simple objects like Numbers, Strings, Points, and Booleans are _immutable_: 
they don't change.  The number `3` is always `3`; it never becomes 4!  If the
variable `x` is bound to `3`, when you write an expression like `x + 1`, you are
not changing `3`: you are creating a new number `4`, leaving `3` unchanged.
The same is true of Strings:  the expression `"Hello " ++ "World!"` does not
change the string `"Hello "` or the string `"World!"`; it creates a third string.

In contrast, lists are mutable: they can be changed.  Try running this program;
then we will discuss what it does. 

<object id="example-1" data="{{site.editor}}?lists-mutable" width="100%" height="550px"> </object>

There is just one list here; `a` and `b` both name this list.
It's initially empty.
The method requests `addLast` and `addFirst` _mutate_, i.e., change, this list.
The request `a.addLast 17` adds the new element `17` at the end;
the request `a.addFirst` adds `3` at the beginning.
The `print` statements show how the value of the list changes; 
the square brackets in the output are the way that lists depict themselves as 
strings.

Notice that it makes no difference whether we access this list through the variable `a` 
or the variable `b`.
There is just one list, so we see the same object both ways.

Now try using `removeFirst` to change the list `a` again.


## Operations on Lists

There are three broad categories of methods that operate on lists.
 * [**Observers**]({{site.baseurl}}/variables/list-observers): methods that let us examine, or observe, the contents of the list.
   Examples are methods such as `at(_)`, which returns a particular element of the list,
   and asString, which returns a string representation of the list and its contents.
 * [**Constructors**]({{site.baseurl}}/variables/list-constructors): methods that make new lists.  Examples are `copy` and `++(_)`
 * [**Mutators**]({{site.baseurl}}/variables/list-mutators): methods that change the list.  Examples include `at(_)put(_)` and `addLast(_)`.
 
There is a separate tutorial page for each of these categories: [**Observers**]({{site.baseurl}}/variables/list-observers),  [**Constructors**]({{site.baseurl}}/variables/list-constructors), and [**Mutators**]({{site.baseurl}}/variables/list-mutators).  And here is the [documentation for all methods on Lists]({{site.baseurl}}/dialects/standard/#list)

## Lists as Collections

Lists are a particular kind of _collection_; a collection is just an object that
can store and provide access to other objects.  Other collections include 
sets, sequences, ranges and strings.

Like all collections, if you need to do some operation 
to every element of the collection, you can use a [for loop]({{site.baseurl}}/control/for)
or the [`do` method]({{site.baseurl}}/variables/do).

In addition to `do`, there are several other useful methods on collections.
This tutorial discusses [ `fold(_)startingWith(_)`]({{site.baseurl}}/variables/fold)
and [`map(_)`]({{site.baseurl}}/variables/map).  The full list is in the
[specification of the standard dialect]({{site.baseurl}}/dialects/standard/#common-abstractions).
