---
title: Definitions and Variables
keywords: tutorial, variables
summary: An introduction to definitions and variables
sidebar: tutorial_sidebar
permalink: /variables/variables/
folder: tutorial
---
Traditionally, programming tutorials start with a "Hello world" program that
simply prints out the phrase "Hello, world!".  `print` statements are pretty
self explanatory though, so we'll just go ahead and skip that.  

Every computer program requires the computer to store some form of data.  In
Grace, the simplest way to store a value is either within a **variable** or a
**definition**.  

A **definition** serves as a name for a value.  This value can be anything,
from the number of sides of a polygon to the name of the city where you were
born.  To create a definition, simply do the following:  
`def triangleSides = 3`  
`def city = "Portland"`  

A **variable** is a definition that can be changed (hence the name variable).
Since the value of a variable can be changed, it doesn't make sense to use `=`
when assigning one (even though the majority of other programming languages
require this; future programmers beware).  Instead, variables can be assigned a
value using `:=` (pronounced "gets").  For instance:  
`var weight := 140`  
`var favoriteSong := "You are my sunshine"`  

If a variable already exists, it can be reassigned a value.  Note that since it
has already been created, you only need to specify the name.  
`favoriteSong := "Somewhere over the rainbow"`  

Variables can store all kinds of data, including Numbers, Strings (Grace's representation of text), and many more.  

Take a look at the example program below.

<object id="example-1" data="{{site.baseurl}}/embedded-web-editor/?var_def" width="100%" height="550px"> </object>
