---
title: Definitions and Variables
keywords: tutorial, variables
summary: An introduction to definitions and variables
sidebar: tutorial_sidebar
permalink: /variables/variables/
folder: tutorial
---
Every computer program requires the computer to store some form of data.  In
Grace, the simplest ways to store a value are either in a **variable**, or in a
**definition**.

A **definition** creates a name for a value.  This value can be anything,
from the number of sides of a polygon to the name of the city where you were
born.  To make a definition, simply do the following:

    def triangleSides = 3
    def city = "Portland"


A **variable** is like a definition, but it can be changed (hence the name “variable”).
Since the value of a variable can be changed, it doesn't make sense to use `=`
when declaring one (even though many other programming languages
do this; future programmers beware).  Instead, variables are assigned a
value using the _asignment symbol_ `:=` (pronounced "gets").  For instance:

    var weight := 140
    var favoriteSong := "You are my sunshine"

If a variable already exists, it can be reassigned a value.  Note that since it
has already been created, you need to specify only the name, and don't need to repeat
the `var`.  So an assinment looks like this:

    favoriteSong := "Somewhere over the rainbow"

Variables can store all kinds of data, including Numbers, Strings
(Grace's representation of text), and Booleans (`true` and `false`).

Look at the examplew below.  Now edit them and try changing the values.

<object id="example-1" data="{{site.editor}}?var_def" width="100%" height="550px"> </object>
