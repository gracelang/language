---
title: Objects
keywords: tutorial, objects, encapsulation, method request
summary: An introduction to objects
sidebar: tutorial_sidebar
permalink: /variables/objects/
folder: tutorial
---
We mentioned in our introduction that Grace is an Object-Oriented programming
language, so it makes sense that we talk about what an **object** is! Objects let us
encapsulate `def`s, `var`s, and `method`s within a single structure.  

We make an object by wrapping some declarations with `object {` and `}`.
This is called an “object constructor”.
Here is an object representing a cat:

```
def culver = object {  // make a new object
    def name = "Culver"
    var miceEaten := 0
    method eatMouse {
        miceEaten := miceEaten + 1
    }
    method miceConsumption {
        miceEaten
    }
    method greeting {
        "{name} says meow"
    }
}
```

This cat has a `name`, which cannot be changed (since it is a `def`), and `miceEaten`, a variable to
keep track of how many mice she has eaten. Furthermore, she has a method
`eatMouse` that increments `miceEaten` by one each time it is executed.
To request execution of a method inside of an object, we use the syntax `_object.method_`.
For instance, `culver.eatMouse`
requests that the object `culver` execute the `eatMouse` method inside it.
Requesting the method `miceConsumption` will return the current value of `miceEaten`,
and the method greeting will return a suitable string.

What does “encapsulate” mean?  Essentially, it means to “draw a box around”.
These boxes help to limit the amount of stuff we have to keep in our heads at 
one time, and also limit the effect of any changes that we make to the code 
in the box.

Encapsulation means that there is no way to access the variable `miceEaten` 
other than through the two methods `eatMouse` and `miceConsumption`.
And there is no way to access the cat's `name` at all — although it is used
to vary the response from `greeting`.

Below is another example of a cat object, with a few more bells and whistles.

<object id="example-1" data="{{site.editor}}?objects" width="100%" height="550px"> </object>

## Statements in a Method

In addition to `var`s and `def`s (collectively called _fields_), an object 
can contain statements at the “top-level” — that is, directly inside the 
object constructor.  These statements are executed when the constructor is 
executed.  Any expressions used to initialize the fields are executed at the
same time, in the order written, from top to bottom.

## Making fields visible

Sometime you actually want a field to be visible from the outside.  
For example, it would be quite reasonable for `culver`'s name to be visible. 
One way to achieve this is to define a method:

```
def culver = object {  // make a new object
    def myName = "Culver"
    method name { name' }
    ...
    
}
```
Notice that we have changed the name of the field to `myName', and declared
a method that will return its value.
The method `name` is visible from outside the object, while `myName` is visible
only inside the object.

There is a shorter way of achieving the same end:

```
def culver = object {  // make a new object
    def name is public = "Culver"
    ...

}
```

Adding the annotation `is public` after the declaration of `name` makes
it visible from the outside, just as if `name` were a method.  Indeed, from the
_outside_, it is impossible to tell a public field from a method.  If you annotate
the declaration of `var thing` with `is public`, the object effectively acquires
_two_ additional methods, `thing` and `thing:=(_)`; the first is
called a reader method, and returns the current value of the `var`, while
the second is called a writer method, and changes the value of the `var`.

## Creating several similar objects

If you want to make several objects, for example, several cats, then you can
wrap your object constructor in a `method` declaration.  The object can then 
use the parameters of the method to set ist fields.  This is quite a common
pattern: read about it in the page on [classes](/variables/classes).
    
    

