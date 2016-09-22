---
title: Conditionals
keywords: tutorial, conditionals, if, else, then, boolean
summary: An introduction to conditionals
sidebar: tutorial_sidebar
permalink: /variables/conditionals/
folder: tutorial
---
Of course, the use of definitions and variables extends far, far beyond printing their
values to the console.  One such use is within conditional statements, which are
useful if you want something to happen only when certain conditions are met.
For example, **if** it's warmer than 68 degrees outside, **then** you might want to go for a
jog; otherwise, you might want to stay indoors and play cards.  

```
if (temperature > 68) then {
    print "Go jogging!"
} else {
    print "Play cards instead."
}
```

Note the structure here.  In Grace, **if statements** start with `if` followed by
an expression that evaluates to true or false (also known as a **boolean** expression),
followed by `then` and a section of code that only runs if the boolean expression is true.  
The `else` statement is optional, and is followed by a section that only runs if the expression is false.  

Note that boolean expressions can be used outside of conditionals, just as any other `def` or `var` can  
be used. For example, you can declare `var b := false`.

Feel free to change the value of `spoonSize` in the example program below, and see
the results for yourself.  

<object id="example-1" data="{{site.editor}}?if" width="100%" height="550px"> </object>
