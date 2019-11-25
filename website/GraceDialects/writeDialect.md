---
title: Writing a Dialect
keywords: Dialect Checker
summary: "This page explains how to write a Grace dialect."
sidebar: dialects_sidebar
permalink: /dialects/writeDialect/
toc: false
folder: Dialects
---

Grace dialects can both extend and restrict the language.  For example,
the _logo_ dialect extends the language with commands for turtle graphics,
while the _requireTypes_ dialects restricts the language to require that
all identifiers are given explicit type annotations.

Most users of Grace will be concerned with using dialects that have already
been written.  Course instructors, and those wanting to try out new language
features, may want to write their own dialects.  This page is a guide to
writing dialects.

## Dialects and Modules

Dialects are also modules.  What, then, is the difference between **import**ing
a module and declaring that your code is written in a **dialect**?

 1. An import statement such as
```
    import "myStuff" as ex
```
    makes the module object declared in the file `"myStuff"` available under
    the name `ex`.  No names are introduced implicitly into the current module.
    There can be several import statements, which make available several modules,
each under its own name.
 2. A dialect statement such as
```
    dialect "myStuff"
```
    nests the current module (called the dialectic module)
    _inside_ the module object `"myStuff"`.
    As a consequence, all of the _public_ attributes of this object are accessible on
    the object `outer`.  Because requests without an explicit receiver are
    sent to `outer` (assuming that they are not defined on `self`), this has
    the effect of making the methods defined in the dialect available to the
    dialectic module without any need to prefix them with
    an object name.
    Note that _confidential_ attributes of the dialect are not available.
 3. Dialects can restrict the language available to the dialectic module,
    and change the error messages that
    programmers see.   They do this by including a checker that examines the
    source program.
 4. A dialect can also ensure that certain code is run
    before the dialectic module is loaded, or after its initialization has
    executed.

Feature (3) allows an instructor to make certain language features
unavailable to their students, and to write tools such as type-checkers.
Feature (4) can be used to "wrap" student code. For example, the
statements of the _logo_ dialect build up an in-memory structure representing
the path that the turtle is to take; the dialect's `atEnd` method causes the
turtle to follow this path.

## Non-transitivity of Dialects

Since dialects are just modules, they themselves must be written in some
dialect.  For example, most dialects will be written in
```
dialect "standard"
```
However, this does _not_ automatically make all of the _standard_ dialect
available to dialectical programs.  This is because the outer dialect is not
visible to programs written in the inner dialect.

This means that if you _want_ to make all of _standard_ available to
dialectical program, you will have to take special action.  

## Combining Dialects

The obvious way to combine an existing dialect with your new dialect
is to import the module _standard_, and then **use** it: 
```
import "standard" as standard   
use standard                    // this won't work
```
However, as the comments indicates, this won't work.
Grace modules are singleton objects, not methods that generate objects, so they cannot be **`use`**d (or **`inherit`**ed) because of the freshness constraint. 

To avoid this problem, dialect modules are defined in an idiomatic way.
Here is the definition of _standard_:

```
dialect "none"
import "standardBundle" as standardBundle

use standardBundle.open
```

As you can see, all of the content of the dialect module is actually in a method
`open` defined in abother module called [_standardBundle_](https://github.com/gracelang/minigrace/blob/master/standard.grace).
All that _standard_ need do is import that module, and request its `open` method;
this generates a new object that can be **`use`**d.
The **`use`** statement makes all of the definitions in `standardBundle.open`
available locally, and thus also available to
any modules written in your dialect.

Because the `open` method is actually a trait, muliple dialects can be "opened" and 
then **`use`**d in this way.
This is how you write a dialect that combines two or more exiting dialects. 

If you think that anyone in the future might want to combine your dialect with another dialect, you should follow the same idiom:
1. Put the methods and types that you want in your dialect into a **`trait`** called `open` in a module called _myDialectBundle_.  Because you are definiing a trait, you will not be able to put **`def`**s in your dialect; use **`once method`**s instead.  If you need module-wide shared state, you can put **`var`** declarations at the top-level of the _Bundle_ module.  You can, of course, put **`def`**s and **`var`**s inside classes and objects defined in your trait.
1. In module _myDialect_, write **`dialect`**, **`import`** and **`use`** statement in a similar way to that shown above:

```
dialect "none"
import "standardBundle" as standardBundle
import "myDialectBundle" as myBundle

use standardBundle.open
use myBundle.open
```

Alternatively, if you do _not_ want to make your dialect a superset of _standard_, then 
do _not_ `use standardBundle.open`.
Instead, write your dialect _in_ "standard", and write "pass-through" definitions for the specific parts of _standard_ that you want your users to be able to access.

## Defining `thisDialect`

A dialect that implements a checker (feature 3 above), or wants to wrap the
dialectical module (feature 4 above), should declare an object `thisDialect`.
The form of the definition should be as follows:
```
def thisDialect is public = object {

    method parseChecker (moduleNode) {
        // do parse tree checks here
    }
    method astChecker (moduleNode) {
        // do AST checks here
    }
    method atStart (moduleName:String) {
        // code here will run before the dialectical module is executed
    }
    method atEnd (moduleObj) {
        // code here will run after the dialectical module is executed
    }
}
```
Any of these methods that will do nothing can be omitted.

The `parseChecker` and the `astChecker` need to run when the dialectical module
is _compiled_; to make this possible, the dialect must be loaded dynamically
at compile time.
If your dialect does not define `thisDialect`, the compiler will not even
try to load it at compile time.  (Use the compiler flag `--verbose 50` or higher
if you want to see a message saying whether or not the compiler loaded your
dialect module.)

Note that the `thisDialect` object must be defined in the dialect itself.
If you use the [idiom described above](#combining-dialects), this will mean that 
`thisDialect` will be a method in the `open` trait defined in your _Bundle_.

If you **`use`** two traits defined in bundles from two separate dialect modules,
and both of them define `thisDialect`, then the second **`use`** statement will 
generate a trait conflict.
This is as it should be: in general, there is no way to automatically combine checkers or 
`atStart` or `atEnd` code.  
It is your job as the combiner of the dialects to create a new `thisDialect` object that combines the pieces of the other dialects in the way that you want, using **`alias`** and **`exclude`** clauses to resolve the conflict and access the parts of the bundles that you wish to reuse.

## The `parseChecker` and `astChecker` methods

The argument to the `parseChecker` method will be the `ast.moduleNode` that
represents the root of the parse tree for the whole dialectical module.
Similarly, the `astChecker`
will be given the `ast.moduleNode` that is the root of the AST of the
dialectical module.

Currently, in _minigrace_, the parse tree and the AST are implemented with the
same kinds of objects: the various node objects defined in the module _ast_.
The difference between them is that various re-writings
have been applied to the parse tree to
produce the AST.  These include:
 1. Symbol table information has been added to the AST.
 2. In the parse tree, a request whose name is a simple identifier without
    arguments appears as an `identifierNode`; in the AST, it has been resolved
    into a `callNode` or a `memberNode`, both of which respond to `isCall` with
    `true`.
 3. Implicit receivers in requests have been resolved to `self`,
 an `outerNode`, `$module` (for the current module), or `$dialect` (for the current dialect).
 4. Return statements are decorated with the declared return type of the
    containing method.
 5. Variables on the lhs of assignments are decorated with their declared types.
 6. The names of fresh methods requested in `inherit` and `use` statements have been
    decorated with a suffix beginning with `$`, to indicate that they should
    be compiled as templates rather than as normal requests.

The details are at present undocumented and subject to change.
Refer to the module _ast_
to see what methods are available on the various AST nodes, and to the
module _identifierresolution_ to see what re-writings have been performed.

## The Symbol Table

Each AST node has an attribute `scope` that refers to the symbol table
that applies to that node.  For example, the `scope` of an expression
inside a method will be the scope introduced by that method, including the
method's parameters, while the scope of a method declaration itself will be 
the enclosing object.  The scope object has methods
```
import "identifierKinds" as identifierKinds
method contains (name:String) -> Boolean
method kind (name:String) -> identifierKinds.T 
method kind (name:String) ifAbsent (action) -> identifierKinds.T | Object
```
that describe the kind of thing that `name` represents.  Note that
inherited names and names obtained from traits are represented in the symbol
table explicitly.

Each scope also has a `parent`, which is the enclosing scope, and a method
`withSurroundingScopesDo(action:Procedure1)` that applies `action` to the current
scope and all the surrounding scopes.  Scopes are defined in the
_identifierresolution_ module.

## Writing a Checker

The simplest way of writing a `parseChecker` or an `astCheker` method is by 
building a visitor.  The module _ast_ declares `baseVisitor` and
`pluggableVisitor` for you to inherit.  The visitors implement a top-down
traversal of the tree.  If a visitor on a node returns `true`, the traversal will
continue with the sub-components of the node; if it returns `false`, the
traversal will go no deeper.

If the dialect's checker finds an illegal condition in the tree, it should stop 
the compilation process by raising an appropriate exception.
A simple way to do this is by making a request
```
errormessages.syntaxError "warning message" atRange (range)
```
where `range` is an object that conforms to the `Range` interface, i.e., has
an attribute `range` that specifies the line and column range in the source where the 
error was found.

Each node in the parse tree, and most nodes in the AST, have 
a `range` attribute that gives its location in the source.
(The exceptions are the nodes in the AST that represent 
things that were implicit in the source, like `self` and `outer`.)

The `errormessages.syntaxError(_)range(_)` method will raise a `SyntaxError` 
exception, which the IDE will catch and use to 
highlight the offending range of the source program.

You can also stop compilation and produce an error message by raising one of the
following exceptions directly:

 - `DialectError`, declared in *xmodule*
 - `SyntaxError`, declared in *errormessages*

If you do this by requesting the `raise(message)with(data)` method, and `data` is either
an AST node or a range object, then the appropriate source code range will
be highlighted when the error is displayed.

Note that the IDE _throws away_ anything written on the standard output stream.
This means that you won't see the output from a `print` statement.
If you need to produce debugging output in the IDE,
import the `"io"` module `as io`,
and use `io.error.write "Progress is being made!\n"`.
