---
title: While Loops
keywords: tutorial, while, loop, control structure, infinite loop, non-terminating loop, stopping a loop
summary: The Dangers of while loops
sidebar: tutorial_sidebar
permalink: /variables/while-dangers/
folder: tutorial
---
## Safe Looping

A while loop will keep on executing as long as the `condition` after the `while` 
is true.  This is sometimes invaluable, but comes with a danger:
sometimes your while loop will never stop!  This is called an “infinite loop”.

If the condition stays true, the while loop will keep on executing the block — until
the end of the universe, if need be.  This is usually not what you want!

There are a few ways you can avoid this problem.

    1. Don't use while unless you need to!  If possible, use a for-loop.

    2. Review the loop body to make sure that you are changing something that will
eventually change the `condition` from `true` to `false`

    3. If you aren't sure, print out the condition at the end of the loop body.
In the Grace web IDE, if you think that you might have written an infinite loop
you can stop it by refreshing the IDE page in your web browser.  

Let‘s look at this advice more closely.

## Choosing between `for` and `while`
For-loops are better if you know, or can
easily calculate, the maximum number of time you might want to execute the loop body.
You can exit a for-loop *early* using a `return` statement, which will return from 
the method containing it.

The example from the [previous page]({{site.baseurl}}/variables/while), which 
executes the loop body for `x` = 0, 3, 6, 9, ... , 27 is one that need not use 
while at all.  We could have written it like this:
```
for (0..9) do { n ->
    def x = n * 3  // count by threes
    print "{x}"
}

```
This is shorter, and because it uses `for(_)do(_)`, *obviously* terminates after 
10 iterations.  Moreover, because the variables `n` and `x` are visible *only* in the
body of the loop, and can't be changed inadvertently, the loop can be understood 
in isolation.  This is in contrast to the while loop, where `x` had to be a 
variable, and had to be initialized outside of the loop.

## An Example Using While

Here is a problem where while seems more useful: finding the first even number 
in a list of numbers:
<object id="example-1" data="{{site.editor}}?while-odd" width="100%" height="550px"> 
</object>
Notice how we are using a Boolean variable `notFound` for the condition;
`notFound` is initialized to `true`, but is assigned `false` as soon as we 
detect an even number.  A variable used in this way is often called a “flag”;
think of a referee raising a flag to signal a rule violation.

But what happens if the given list of numbers doesn't contain an even number?
Change the `6` to an odd number and see.

* * * *

You should get an error like this:
```
BoundsError on line 647 of collectionsPrelude: index 7 out of bounds 1..6
raised at Exception.raise(_) at line 647 of collectionsPrelude
called from object.at(_) at line 6 of main
...
```
This error message is telling you that in the `at(_)` request on line 6, you were
asking for element 7 of a list that has only 6 elements.  Can you see why?

Yes!  The _only_ way we can exit from the while loop is by assigning `false` to
`notFound`.  We make that assignment (on line 7) as soon as we find an even number.
But if there *is no even number*, we never make this assignment, `notFound` stays
`true`, and the while loop keeps on looping.
Eventually, the assignment `ix := ix + 1` on line 9 will cause `ix` to reach a 
value larger than the highest valid index to `nums`, and next time around
the loop, Grace raises `BoundsError`.

To safeguard against this, we must change the program to terminate the while
loop under _two_ conditions:

 1. When we find an even number in `nums`
 2. When `ix` exceeds `nums.size`

Or, to put it the other way around, we keep on looping _while_ we have not found 
an even, and _while_ `ix` does not exceed the size of `nums`. 

We can accomplish this by changing the `while` condition to `notFound && (ix ≤ nums.size)`.
Go ahead and make this change, and run the program again.  What happens?

Yes, you get a `BoundsError` again, but this time on line 13. 
Try and figure out why for yourself, before you read further.

* * * *

The condition `(ix ≤ nums.size)` will indeed terminate the while loop as soon as 
`ix` takes on the value 7.  But what happens then?  Grace executes the code that 
follows the while loop, which once again asks for `num.at(7)`.

This teaches us an important lesson.  When a while loop terminates, we *know*,
as sure as death and taxes, that the `while` condition is `false`!  Why?
Because if it's not `false`, we would still be going around the loop!
In this example, we _know_ that either `notFound` is false, or that `ix ≤ nums.size`
is `false`.  We can use this to decide what to do:

<object id="example-2" data="{{site.editor}}?while-improved" width="100%" height="550px"> 
</object>

But wait a minute!  Our first rule was

 1. Don't use while unless you need to!  If possible, use a for-loop.

In this example, there *is* an up-front bound on the number of times that we might
execute the loop, because the size of `nums` is known. So we can use `for(_)do(_)`
instead of `while(_)do(_)`, like this:
```
def nums = list [3, 7, 5, 1, 9, 1]
var notFound := true
var firstEven

for (nums) do { n →
    if (notFound) then {
        if (n.isEven) then {
            notFound := false
            firstEven := n
        }
    }
}

if (notFound) then {
    print "there are no even numbers"
} else {
    print "the first even number is {firstEven}"
}
```
We still need the flag `notFound`.  Why?  What happens if there are two or three 
even numbers in the list?

The presence of the flag `notFound` and the variable `firstEven` make this 
code more complicated than is necessary.  Another deficiency is that it
iterates over _every_ element of
`nums`, even if the even number is found right at the start.  We can fix this 
by wrapping the loop in a method, and using `return` to terminate both the loop
and the method
once we have found what we are looking for:

<object id="example-3" data="{{site.editor}}?findEven-method" width="100%" height="550px"> 
</object>

This is the best solution for this problem.  It is easily modified, for example,
to return the found number rather than printing it.  The method can also
be changed to take an additional parameter which is the action to take if there
is no even number — but that's a lesson for another day.

Using a method also gives you the opportunity to choose an _intention-revealing name_
for the method, which will help you and others who read this code to understand what
it is intended to do.

## When do we _need_ a while loop?

A while loop is often the best solution when:

 1. You are processing input. You know that the input is finite, but there is no 
_a priori_ bound on its size.
 1. You know that something is bounded, but computing the bound is difficult or 
impossible. 
 1. The data you are processing is randomized, or pseudo-random. 
Statistics tell you that something 
will happen eventually, but you can't know how long it will take if you are unlucky.

Typical of the first situation might be requesting input from 
a user.  For example:
```
while {io.ask "Do you want to play again".asLower.startsWith "y"} {
    playOneRound
}
print "Thanks for playing.  Goodbye."
```
We know that they user will eventually want to stop, but we have no idea how 
many times they will want to play.  Hence, a while loop is the right tool.

An example of the second situation might be filling a line of text.  You want 
to put as many words as possible on the current line.  So something like
```
while { 
    nextWord := words.next
    ((xPosition + nextWord.width + space.width) ≤ rightMargin)) 
} do {
    currentLine.addLast(nextWord)
    xPosition := xPosition + nextWord.width + space.width
}
```
The third situation is exemplified by selecting a set of random numbers of
a given size.
```
def column = set []
while { column.size < limit } do {
    def candidate = random.integerIn 1 to 100
    column.add(candidate)
}
```
When the loop terminates, we know that `column.size == limit`, because
`column.size` increases by at most one on each iteration.  This code will work 
fine if `limit` is 5.  But as limit approaches 100, it will take longer and 
longer to find a pseudo-random integer in the interval 1..100 that is not 
already in column.  If `limit` is greater than 100, it will never terminate!

This particular problem can be better-solved using a for loop.
Start with a `list (1..100)`, select an element at random, _remove_ it, 
and then add that element to column.  Repeat this `limit` times — which 
can be accomplished using `repeat(_)times(_)` or `for(_)do(_)`.
If `limit` is greater than 100, this approach will lead to a `BoundsError`
when the list from which you are choosing an element becomes empty.




