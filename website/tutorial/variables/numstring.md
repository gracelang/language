---
title: Numbers and Strings
keywords: tutorial, number, string
summary: An introduction to Numbers and Strings
sidebar: tutorial_sidebar
permalink: /variables/numstring/
folder: tutorial
---
One of the basic kinds of data in Grace (and everywhere else) are **Numbers**. You
can use operators like +, -, *, /, etc., on them, as you might expect.

Another one of the basic kinds of data in both Grace and other programming languages
is text. The representation of text in Grace is called a **String**, and
is shown through the use of double quotes. For example, `"I am a string"`.
You can add, or **concatenate**, two Strings together using `++`, as shown
here `"string1" ++ "string2"` to make `"string1string2"`.

Both Numbers and Strings are _Objects_; this means that they have methods
associated with them, and that you can request that they execute those methods.
`+`, `-`, `*` etc are actually methods in Grace; you request them by writing
expressions using operator symbols, like `(3 + 4) * 2`, very much as in mathematics.

Other method have names, like `isEven`, `floor`, `truncated`, or `abs`; you request
these
using _dot notation_.

```
var a := -7.6   // requsts the prefix - method on 7.6
print (a.abs) // requests the absolute value method on a
var b := "hello"
print (b.first) // requests the `first` method of b, which returns its first letter
```

Try experimenting with other methods for Numbers and Strings below (like `rounded` for Numbers and `asUpper` for Strings).
<object id="example-1" data="{{site.editor}}?numstring" width="100%" height="550px"> </object>

Two usful but slightly unusual methods on numbers are `÷`, which performs
integer division, and `%`, which returns the remainder after integer division.
For any Divident `D and divisor `d`, it's always true that

```
def q = D ÷ d
def r = D % d
D == ((d*q) + r)
```

Here are the complete lists of all the methods on [Numbers]({{site.baseurl}}/dialects/standard/#number)
and [Strings]({{site.baseurl}}/dialects/standard/#string).

