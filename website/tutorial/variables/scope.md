---
title: Scope of Declarations
keywords: tutorial, scope, declaration, declarations, variables, identifiers, evaluation order
summary: Where are variables and methods visible?  And when are definitions evaluated?
sidebar: tutorial_sidebar
permalink: /variables/scope/
folder: tutorial
---

## Declarations and Statements

When you write a Grace module, it normally contains a mixture of _declarations_
and _statements_.

A _declaration_ introduces a new name.  That obviously includes `var`, `def` and
`method` declarations.  It also includes `import` declarations, since they
introduce a _nickname_ for the imported module object, and `dialect` declarations,
since they introduce a whole bunch of names by logically enclosing the current
module with the dialect module.

All of these names are meaningful throughout the whole of the module that you
are writing.  We say that the _scope_ of each of these names is the whole module.
This includes any nested methods or blocks (unless that nested scope re-declares the 
name as something else).

## Order of Initialization

After all of these names have been _declared_, the code in the module is _executed_,
starting at the top, and proceeding in the order in which the statements and declarations are written.
Executing a `method` declaration does nothing; the method's name has already been defined,
so there is nothing more to be done.  Executing a `def`, however, means work:
the expression on the right-hand-side of the `def` has to be evaluated, and
the result bound to the new name.
The same is true for a `var` declaration.

Here is an example:

<!--def radius = 4-->
<!--def circumference = circumOfCircleWithRadius(radius)-->
<!---->
<!--print "the circumference of a circle with radius {radius} is {circumference}"-->
<!---->
<!--method circumOfCircleWithRadius(r) { 2 * π * r }-->


<object id="example-1" data="{{site.editor}}?scope" width="100%" height="550px"> </object>

The names `radius`, `circumference`, and `circumOfCircleWithRadius` are valid 
throughout the whole module, but before the module is executed, the names
`radius` and `circumference` are _uninitialized_.
Try moving the print statement to before the `def` of `radius` 1 and see what happens.
Now move it after the `def` of `radius`, but before the `def` of `circumference`.

In contrast, the _method_ `circumOfCircleWithRadius` was defined when it was declared.
So, once `radius` has been initialized to `4`, it is possible to evaluate
`circumOfCircleWithRadius(radius)`, and bind the result to `circumference`.
It doesn't matter that the declaration of the method comes after the request.

## Summary

 1. All names come into existence together, at the start of a module
 2. The name of a method is bound to its body when the method is declared.
 3. `var`s and `def`s are created at the start of the module, but are at first _uninitialized_.
 4. The code in the module is executed in the order written, top to bottom.  This code includes the
right-hand-sides of `var`s and `def`s, and any statements at the top level.
During the excecution process, it's an error to try to access a variable 
before it has been initialized.

## Consequences

 1. The order in which you write your method declarations doesn't matter to Grace.
Arrange them in a way that makes sense to you as a programmer,
e.g., group related methods together.
 1. The order of `var`s, `def`s, and top-level method requests, _does_ matter.
It is the programmer's job to make sure that variables are defined before they
are used.
