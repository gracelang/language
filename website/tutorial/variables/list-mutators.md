---
title: List Mutator Methods
keywords: tutorial, list, mutators, mutation
summary: An introduction to methods that change lists
sidebar: tutorial_sidebar
permalink: /variables/list-mutators/
folder: tutorial
---


As we discussed in the [introduction to lists]({{site.baseurl}}/variables/lists),
lists are the first kind of *mutable* object that we have met in Grace.
What does “mutable” mean?  Simply that, after a list is created, you can _modify_ it.
You can add elements to either end of the list, remove elements from either end,
or chaneg the element stored at a particular index. 

To add an element to the list, use `animals.addLast "squirrel"` or
`animals.addFirst "badger"`, depending on whether you want to add the
new element at the end or the start of the list. 
To remove an element from a list, use `animals.removeLast`, `animals.removeFirst`.
You can also say `animals.remove "whale"`; this will search the list `animals` for
an element equal to `"whale"`, and if one is found, remove it.

Notice that adding or removing the `first` element of the list will change the
position of all of the elements in the list.  So, after `animals.addFirst "badger"`
`animals.at 1` will be "badger", and not "dog"; instead, `animals.at 2` will be "dog".

You can also _change_ the element stored at a specific index.  To do this, 
use the method `at (index) put (newObject)`.  Here, `index` must be an integer
between 1 and the size of the list, and `newObject` is the object that you want
to store there.  Try modifying these examples.


<object id="example-2" data="{{site.editor}}?lists-at-put" width="100%" height="550px"> </object>


The following methods all mutate the object that receives them.  In the descriptions,
`T` is the type  of the elements of the list.  By convention, many of these methods return self, 
that is, in addition to mutating the list that receives the request, they _also_ return it.

```
at(n: Number) put(new:T) -> List⟦T⟧
// mutates this list so that my element at index n is new.  Returns self.
// Requires 1 ≤ n ≤ size+1; when n = size+1, it is equivalent to addLast(new).

addLast(new:T) -> List⟦T⟧
// adds new to end of this list.

add(new:T) -> List⟦T⟧
// adds new to end of this list — the same as add(new)

addFirst(new:T) -> List⟦T⟧
// adds new as the first element(s) of this list.  Changes the index of all of the existing elements.

addAllFirst(news: Collection⟦T⟧) -> List⟦T⟧
// adds all the elements of news as the first elements of this list.  If news is not empty,
// this method changes the index of all of the existing elements.

removeFirst -> T
// removes and returns first element of this list.  Changes the index of the remaining elements.

removeLast -> T
// removes and returns last element of this list.

removeAt(n:Number) -> T
// removes and returns n th element of this list

remove(element:T) -> List⟦T⟧
// removes element from this list.  Raises NoSuchObject if this list does not contain element.
// Returns self

remove(element:T) ifAbsent(action:Function0⟦Unknown⟧) -> List⟦T⟧
// removes element from this list; executes action if it is present.  Returns self

removeAll(elements:Collection⟦T⟧) -> List⟦T⟧
// removes elements from this list. Raises NoSuchObject exception if any  of 
// them is not contained in this list. Returns self

removeAll(elements:Collection⟦T⟧) ifAbsent(action:Function0⟦Unknown⟧) -> List⟦T⟧
// removes elements from this list; executes action if any of them is not contained in this list. 
// Returns self

clear -> List⟦T⟧
// removes all the elements of this list, leaving this list empty.  Returns self

addAll(extension:Collection⟦T⟧) -> List⟦T⟧
// extends this list by appending the contents of extension; returns self.

reverse -> List⟦T⟧
// mutates this list in-place so that my elements are in the reverse order.  Returns self.
// Compare with reversed, which creates a new collection.

sort -> List⟦T⟧
// sorts this list in place, using the ≤ method on my elements.  Returns self.
// Compare with sorted, which constructs a new list.

sortBy(sortBlock:Function2⟦T, T, Number⟧) -> List⟦T⟧
// sorts this list according to the ordering determined by sortBlock, which should return -1 if its first 
// argument is less than its second argument, 0 if they are equal, and +1 otherwise.  Returns self.
// Compare with sortedBy, which constructs a new list.


```
