---
title: Methods
keywords: tutorial, methods, parameters
summary: An introduction to methods
sidebar: tutorial_sidebar
permalink: /variables/methods/
folder: tutorial
---
Say you have a block of code that you want to execute more than once.
For example, let's look at our previous `spoonSize` program.
Suppose you have a set of several spoons and want to check all of their sizes.
Instead of writing out those five lines of code over and over again, you can
delegate it to a **method**.

Here is an example of a **method declaration**:

```
method checkSpoonSize(spoonSize) {
    if (spoonSize < 20) then {
        print "My spoon is too small!"
    } else {
        print "My spoon is too big!"
    }
}
```
The reserved word `method`  says that we are staring a method declaration.
Then comes the name of the method, and (optionally) a list of _parameters_.

Now that we have declared a method, we can **request** it.
Requesting that Grace execute this method
is as simple as writing `checkSpoonSize(15)`. We write the name of the method and give
it the appropriate **arguments**, in our case, 15.
When the method executes, the _parameter_ `spoonSize` takes on the value of the
argument, that is, 15.

## Multi-part method names

There are a variety of formats for method names and parameter lists.
You can have multiple parameters,
as in the method `multiply(a, b)` below.  The name of the method can also have
multiple parts, each
with its own list of parameters, as illustrated by `divide(a) by(b)` below.
Lastly, you can also
have a name with no parameters, shown by `pi` below.
<object id="example-1" data="{{site.editor}}?methods" width="100%" height="550px"> </object>

One form that is not allowed is a multipart name _without_ a parameter list after
the final part.  So <s>`method divide (a, b) by`</s> is not allowed.

## A word on terminology

The variables names in parenthesis in the method header,
like `spoonSize` in the method `checkSpoonSize`
are called _parameters_.  When you make a request of such a method, you
provide _values_ for those parameters by supplying _arguments_, like `5` or `15`.
So the parameter is a name, while the argument is a value, or an expression that
can be evaluated to yield a value.
