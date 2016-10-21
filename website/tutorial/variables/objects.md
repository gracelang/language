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
encapsulate defs, vars, and methods within a single structure.
Here is an object representing a cat:

```
def culver = object {  // make a new object
    def name = "Culver"
    var miceEaten := 0
    method eatMouse {
        miceEaten := miceEaten + 1
    }
}
```

This cat has a `name`, which cannot be changed (since it is a `def`), and `miceEaten`, a variable to
keep track of how many mice she has eaten. Furthermore, she has a method
`eatMouse` that increments `miceEaten` by one each time it is executed.
To request execution of a method inside of an object, we use the syntax `_object.method_`.
For instance, `culver.eatMouse`
requests that the object `culver` execute the `eatMouse` method encapsulated inside it.

Below is another example of a cat object, with a few more bells and whistles.

<object id="example-1" data="{{site.editor}}?objects" width="100%" height="550px"> </object>
