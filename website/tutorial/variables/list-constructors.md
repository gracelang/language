---
title: List Constructor Methods
keywords: tutorial, list, constructors, new lists
summary: An introduction to methods that let us construct new lists
sidebar: tutorial_sidebar
permalink: /variables/list-constructors/
folder: tutorial
---

The simplest constructors are those that you have already seen:
the methods `list.empty` and `list.with(_)` in _standardGrace_, and the methods
`list`, `list(_)`, `list(_,_)`, `list(_,_,_)`, etc. in _beginningStudent_.
These methods create lists containing the given elements in the given order.

More interesting are methods on lists that construct other lists.
One that should look familiar is the concatenation operator `++`,
because it works on
lists in the same way that it works on strings.

<object id="example-1" data="{{site.editor}}?lists-concat" width="100%" height="550px"> </object>

Notice that `snacks` is a new list, quite separate from `cheeses` and `fruits`,
although its initial contents comes from `cheeses` and `fruits`.

Here are some other methods on lists that construct new lists:

```
reversed -> List⟦ElementType⟧
// returns a List containing my values, but in the reverse order.

sorted -> List⟦ElementType⟧
// returns a List containing my values, but in an order determined by
// the ≤ method on the elements.

sortedBy(sortBlock:Function2⟦ElementType, ElementType, Number⟧) -> List⟦ElementType⟧
// returns a List containing my values, but in an order determined by
// the sortBlock argument.  The sortBlock is a piece of code that determines what it
// means for one element to be less than or greater than another.
// The sortBlock must return 0 when two elements are equal, -1
// if the first is "less than" the second, and +1 if the first is "greater than" the second.
```

`sorted` is simple to use:

<object id="example-2" data="{{site.editor}}?lists-sorted" width="100%" height="550px"> </object>

Notice that generating a sorted list of cheeses doesn't change the original list;
`sorted` is a constructor, not a mutator method.  Don't confuse it with `sort`! 

The `sorted` method  won't work for the next example,
in which the list elements are themselves lists.
That's because there is no ordering method `≤` on list.  We can solve this problem by using 
`sortedBy(sortBlock)`; the sortBlock that we use here compares the _second_ elements of
the component lists, so the result is sorted by the cheese, not the fruit.
Experiment!  Can you sort in the reverse order, or by the fruit?


<object id="example-2" data="{{site.editor}}?lists-sortedBy" width="100%" height="550px"> </object>


Once again, notice that `snacks.sortedBy` does not change `snacks`. 

<!--- filter(condition:Function1⟦T, Boolean⟧) -> Collection⟦T⟧
// returns a new collection containing only those elements of self for which
// condition holds.  The result is ordered if self is ordered.

map⟦R⟧(unaryFunction:Function1⟦T, R⟧) -> Collection⟦T⟧
// returns a new collection whose elements are obtained by applying unaryFunction to
// each element of self.  If self is ordered, then the result is ordered.

```
`map` is one of the most powerful operations on lists; we use it
to request an existing list to generate a new list for us, 
according to a rule expressed as a block of code.  
Map has its own tutorial page:
[map]({{site.baseurl}}/tutorial/variables/map/)

-->
