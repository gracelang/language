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

Both Numbers and Strings are also Objects, which means that they have methods  
that are already associated with them.

```
var a := -7.6
print "{a.abs}" // this gets absolute value
var b := "hello"
print "{b.at(1)}" // this gets the first letter of b
```

Try experimenting with other methods for Numbers and Strings below (like `rounded` for Numbers and `asUpper` for Strings).
<object id="example-1" data="{{site.editor}}?numstring" width="100%" height="550px"> </object>

A complete list of all methods for: [Numbers](http://gracelang.org/documents/grace-prelude-0.7.0.html#number)
and [Strings](http://gracelang.org/documents/grace-prelude-0.7.0.html#string)
