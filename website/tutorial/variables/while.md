---
title: While Loops
keywords: tutorial, while, loop, control structure
summary: An introduction to while loops
sidebar: tutorial_sidebar
permalink: /variables/while/
folder: tutorial
---
Sometimes when might want to execute a block of code an indefinite number
of times, as long as some condition is met. **While Loops** are designed exactly for
this purpose.

Here is the format:

```
while { condition } do {
  block of code
}
```

First Grace checks the condition. If the condition is `false`, Grace does _nothing_.
If the condition is true, Grace
executes the block of code after the `do`. Then it loops back to the top, checking
the condition again. 
If the condition is false, it does nothing and exits the loop. If the condition
is true, it executes the
block of code after the `do`. Then it loops back to the top, checking the ...

Notice that the condition is in braces, not parenthesis.  Why is this?  Because
it is essential to the behaviour of the while loop that the condition is re-evaluated
every iteration.  If it were in parenthesis, it would be evaluated once before the
start of the loop, which means that the loop would either not execute at all (if
the condition were `false`), or would execute forever (if it were `true`).
Using braces means that the while loop gets a block of code, 
rather than a simple Boolean value, and can _re-evaluate_ that block on each iteration.
Don't worry if you didn't quite follow that explanation: just remember to use
blocks for your conditions.  

Below is an example of a while loop that prints out numbers less than 30, counting
by threes. Feel free to explore it and change it to see the result.
<object id="example-1" data="{{site.editor}}?while" width="100%" height="550px"> </object>

Sometimes you want to execute the body of the loop at least once.  Then, depending
on the condition, you want to decide whether or not to execute it again. 
This can be accomplished with the `do(_)while(_)` loop:

```
do { 
    block of code 
} while { condition }
```

The block of code and the condition play the same roles as in the `while(_)do(_)` loop,
but here the block is executed _first_, and the condition checked _after_ the
block has been executed.

Want to know more?  Read [The Dangers of While Loops]({{site.baseurl}}/variables/while-dangers)
