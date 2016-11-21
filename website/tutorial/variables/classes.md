---
title: Classes
keywords: tutorial, object, class, encapsulation, method request
summary: An introduction to classes
sidebar: tutorial_sidebar
permalink: /variables/classes/
folder: tutorial
---
An object constructor makes a new object each time it is executed. 
So, if we want to make 10 objects all the same, all we need do is put the
object constructor in a loop:

```
def cats = list [ ]
repeat 4 times {
    cats.add ( object {
        def name = "Culver"
        var miceEaten := 0
        method eatMouse {
            miceEaten := miceEaten + 1
        }
        ...
    } )
}
```
This adds 4 identical but distinct cat objects, all named `"culver"`, to the list `cats`.
What do we mean whne we say “distinct”?  We mean that each has its own fields;
when one of them eats a mouse, its 
`miceEaten`variable will change, but those of the other 3 will not.

It's more common to want to give each cat its own name.  To do this, we can use a 
method with a parameter:

```
method catNamed (name:String) {
    object {
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
}
```
All we have done here is wrapped the whole object constructor in a method.
We no longer need to declare a field `name`, becuase we gave the method a
parameter `name` instead; this parameter will get its value from the argument 
provided when the method is requested.

<object id="example-1" data="{{site.editor}}?objects" width="100%" height="550px"> </object>

Let‘s use this method to make 4 cats:
```
def cats = list [ ]
for [ "Macavity", "Growltiger", "Jennyanydots", "Old Deuteronomy"] do { each ->
    cats.add ( catNamed (each) )
}
```    
## Classes

Now we can finally tell you what a class is in Grace: it's a shorthand for
a method that has nothing but an object constructor in it's body.  Thus, a 
class will always return a new object whenever it is executed.


