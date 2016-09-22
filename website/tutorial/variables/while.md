---
title: While Loops
keywords: tutorial, while, loop, control structure
summary: An introduction to while loops
sidebar: tutorial_sidebar
permalink: /variables/while/
folder: tutorial
---
There are times when you might want to execute a block of code indefinitely,  
as long as some condition is met. **While Loops** are designed exactly for that.  
Here is the format:

```
while (condition) do {
  block of code
}
```

First it checks the condition. If it is false, it does nothing. If it is true, it  
executes the block of code after the `do`. Then it loops back to the top, checking  
the condition again. If it is false, it does nothing and exits the loop. If it is true, it executes the  
block of code after the `do`. Then it loops back to the top, checking the...

Below is an example of a while loop that prints out numbers less than 30, counting  
by threes. Feel free to explore it and change it to see the result.
<object id="example-1" data="{{site.baseurl}}/embedded-web-editor/?while" width="100%" height="550px"> </object>
