---
title: Do
keywords: tutorial, do, for, control structure
summary: An introduction to do methods
sidebar: tutorial_sidebar
permalink: /variables/do/
folder: tutorial
---
**Do** is a method associated with **collection** objects. It iterates over every element  
of the list and executes some action. Here is the format:  

```
«listExpression».do { «parameter» ->
  «action»
}
```
Where the quoted components, `«listExpression»`, `«parameter»` and
`«action»`, are replaced by Grace program elements.  `«listExpression»` is any 
expression that evaluates to a list, and `«action»` is any sequence of Grace
statements.

`«parameter»` is a fresh variable name, the parameter of the block.
You can use whatever name you wish; the name `each` is a good one if you can't
think of soemthing more specific.
The parameter is declared just by writing its name between the opening brace `{` 
and the arrow `->`.  Normally, `«action»` will involve the use of `«parameter»`;
if you don't use `«parameter»`, ask yourself why you are using `do`.

The **do** method acts in exactly the same way as a
[for loop]({{site.baseurl}}/control/for);
for compatibility with other languages, Grace also has
[for loop]({{site.baseurl}}/control/for), 
although `do` methods are more concise.
Both the [for loop]({{site.baseurl}}/control/for) and the `do` method execute a
block of code once for each
element of the collection.  That element is bound to the parameter of the block.

<object id="example-1" data="{{site.editor}}?do" width="100%" height="550px"> </object>
