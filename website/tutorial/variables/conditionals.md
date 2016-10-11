---
title: Conditionals
keywords: tutorial, conditionals, if, else, then, boolean, Boolean
summary: An introduction to conditionals
sidebar: tutorial_sidebar
permalink: /variables/conditionals/
folder: tutorial
---
Conditional statements let you choose to execute a block of code, or
only when certain conditions are met.
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
an expression that evaluates to true or false. This is called a **Boolean expression**,
or sometimes a just a **condition**.
The Boolean expression is
followed by `then`, and a block of code that runs _only_ if the Boolean expression is true.  
The `else` statement is optional, and is followed by a code block that runs _only_ if the expression is false.  

Note that Boolean expressions can be also used outside of conditionals. 
For example, you can declare `var b := false`.

Feel free to change the value of `spoonSize` in the example program below, and see
the results for yourself.  

<object id="example-1" data="{{site.editor}}?if" width="100%" height="550px"> </object>

## Conditional Expressions

The `spoonSize` example illustrates the conditional _statement_; one of the two print statements
is executed, depending on the condition.  You can also use an `if(_)then(_)else(_)` as an 
expression, that is, so that it returns a value rather than executing a statement. 
Here is the same program using a conditional expression.

<object id="example-1" data="{{site.editor}}?if-expn" width="100%" height="550px"> </object>

Notice that the `else(_)` part of the conditional is compulsory in a conditional _expression_,
even though it was optional in the conditional _statement_.  This makes sense, if you
think about it.  Omitting the `else(_)` in a conditional statement is equivalent to saying "do nothing".
But a conditional expression has to return a _value_, so both the `then(_)` and `else(_)`
must also return values.

## `elseif(_)`

If you want to check more conditions, the simplest way is to use an extended form of `if(_)then(_)else(_)`
that contains one or more `elseif(_)` clauses.  The condition after an `elseif`
must be in braces; it is evaluated only when the preceding conditions are _all_ `false`.
Here is an example.

<object id="example-1" data="{{site.editor}}?elseif" width="100%" height="550px"> </object>