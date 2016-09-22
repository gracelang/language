---
title: Lists
keywords: tutorial, list
summary: An introduction to lists
sidebar: tutorial_sidebar
permalink: /variables/lists/
folder: tutorial
---
**Lists** are a type of Object that can hold multiple values, each of which is an **element** of  
the list. A list is declared like this:

```
def animals = list ["dog", "cat", "whale", "bird", "mouse"]
```

It doesn't matter how many elements you put between the `[ ]`, a list can hold arbitrarily  
many things. Also note that you can put no items in a list, creating an empty list.  
After a list is created, you can modify the contents. To get a specific element from a list, you  
can use `list.at(index)`, where replacing `index` with 1 would get the first element,  
2 would get the second, and so on. To add an element to the list, use `list.add(element)`.  
To remove an element from a list, use `list.remove(element)`.

<object id="example-1" data="{{site.editor}}?lists" width="100%" height="550px"> </object>

A complete list of all methods for: [Lists](http://gracelang.org/documents/grace-prelude-0.7.0.html#list)
