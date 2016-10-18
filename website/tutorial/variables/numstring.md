---
title: Numbers and Strings
keywords: tutorial, number, string
summary: An introduction to Numbers and Strings
sidebar: tutorial_sidebar
permalink: /variables/numstring/
folder: tutorial
---
One of the basic types of data in Grace and everywhere else are **Numbers**. You  
can use operators like +, -, *, /, etc on them as you might expect.

Another one of the basic types of data in Grace and other programming languages  
is text. The representation of text in Grace is called a **String**, and  
is shown through the use of quotes. For example, `"I am a string"`.  
You can add, or **concatenate**, two Strings together using `++`, as shown  
here `"string1" ++ "string2"` to make `"string1string2"`.

Both Numbers and Strings are _Objects_ which means that they have methods  
associated with them, and that you can request that they execute those methods
using _dot notation_.  

```
var a := -7.6   // requsts the prefix - method on 7.6
print "{a.abs}" // requests the absolute value method on a
var b := "hello"
print "{b.first}" // requests the `first` method of b, which returns its first letter
```

Try experimenting with other methods for Numbers and Strings below (like `rounded` for Numbers and `asUpper` for Strings).
<object id="example-1" data="{{site.editor}}?numstring" width="100%" height="550px"> </object>

Here are the complete lists of all the methods on [Numbers]({{site.baseurl}}/doc-landing/#number)
and [Strings]({{site.baseurl}}/doc-landing/#string)
