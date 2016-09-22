---
title: Fold
keywords: tutorial, fold
summary: An introduction to fold methods
sidebar: tutorial_sidebar
permalink: /variables/fold/
folder: tutorial
---
Fold is a method that lists have that returns a value that is created by applying some  
function to the elements in the original list. The format of calling the fold method is as follows:  

```
list.fold { a, b ->
    function
} startingWith (startingValue)
```

<object id="example-1" data="{{site.editor}}?fold" width="100%" height="550px"> </object>
