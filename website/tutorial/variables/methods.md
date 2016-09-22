---
title: Methods
keywords: tutorial, methods
summary: An introduction to methods
sidebar: tutorial_sidebar
permalink: /variables/methods/
folder: tutorial
---
Say you have a block of code that you want to execute more than once.  
For example, let's look at our previous `spoonSize` program. Suppose you  
have a set of several spoons and want to check all of their sizes. Instead  
of writing out those five lines of code over and over again, you can  
delegate it to a **method**. Here is an example of a **method declaration**:

```
method checkSpoonSize(spoonSize) {
    if (spoonSize < 20) then {
        print "My spoon is too small!"
    } else {
        print "My spoon is too big!"
    }
}
```

Now that we have declared a method, we should **call** it. Calling a method  
is as simple as `checkSpoonSize(15)`. We use the name of the method and send  
it the appropriate **parameters**, in our case, 15.  
There are different formats for methods. You can have multiple parameters,  
such as `multiply(a, b)` below. You can also have multiple names, each  
taking its own parameters, shown by `divide(a) by(b)` below. Lastly, you can  
have a name with no parameters, shown by `pi` below.
<object id="example-1" data="{{site.editor}}?methods" width="100%" height="550px"> </object>
