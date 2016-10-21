---
title: Using variables to count
keywords: tutorial, variables, counting, adding 1, assignment
summary: Using variables to count
sidebar: tutorial_sidebar
permalink: /variables/counting/
folder: tutorial
---
One of the useful things that you can do with a variable is to use it to count.
Here is a method that uses a variable in this way.

```
method numberOf(letter:String) in (str:String) → Number {
    // returns the number of occurrences of letter in str
    var count := 0
    for (str) do { each →
        if (letter == each) then { count := count + 1 }
    }
    return count
}
```

The fact that the variable is called `count` is convenient, but doesn't affect what the program does.

Notice the statement in the `then` on line 6:
```
count := count + 1
```
Read this “count gets (count + 1)”.  
It's vitally important to understand that the expression `count + 1`
on the right-hand-side of the assignment symbol `:=` is evaluated first.   
So if count was `7`, `count + 1` is `8`.  
Assignment causes `count` to “forget” its old value, and assigns it a new 
value — in this example, `8`.  So, if count was `7`, it is now `8`.  
Similarly, it it was `0`, it's now `1`.  If it was `1`, it's now `2`.  
The assignment doesn't happen until _after_ the right-hand-side has been 
evaluated, using the _old_ value of the variable `count`.

Thus, the value of `count` is increased by 1 every time the loop 
finds that `letter == each`.

Notice that we are _not_ changing the number 7 into 8; that would be really 
weird!  We are _re-binding_ the variable `count` to 8 (assuming that 
it was bound to 7).

