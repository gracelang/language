---
title: Writing a Dialect
keywords: Dialect Checker
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
dialect "standardGrace"
```
However, this does _not_ automatically make all of the _standardGrace_ dialect
available to dialectical programs.  This is because the outer dialect is not
visible to programs written in the inner dialect.

This means that if you _want_ to make all of "standardGrace" available to
dialectical program, you will have to take special action.  The recommended way
of doing this at present is to add the statement
```
inherit prelude.methods
```
The identifier `prelude` is defined to be the current dialect, that is, the
dialect surrounding the dialect that you are writing.
Thus, if the current dialect is
`"standardGrace"`, `prelude` will be bound to the standardGrace module object.
Because of the freshness constraint, it is not possible to inherit from
`prelude`.  However, `prelude.methods` is a fresh copy of the module,
from which it is possible to inherit.

Inheritance makes all the attributes of the inherited object (here, a copy
of the _standardGrace_ module), available locally, and thus also available to
any modules written in your dialect.

## Defining `thisDialect`

A dialect that implement a checker (feature 3 above), or wants to wrap the
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
 3. Implicit receivers in other requests have been resolved to `self`,
    an `outerNode`, `prelude`, or the current module.
 4. Return statements are decorated with the declared return type of the
    containing method.
 5. The names of fresh methods requested in `inherit` and `use` statements have been
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
`withSurroundingScopesDo(action:Block1)` that applies `action` to the current
scope and all the surrounding scopes.  Scopes are defined in the
_identifierresolution_ module.

## Writing a Checker

The simplest way of writing a `parseChecker` or an `astCheker` method is by 
building a visitor.  The module _ast_ declares `baseVisitor` and
`pluggableVisitor`for you to inherit from.  The visitors implement a top-down
traversal of the tree.  If a visitor on a node returns `true`, the traversal will
continue with the sub-components of the node; if it returns `false`, the
traversal will go no deeper.

If the dialect's checker finds an illegal condition in the tree, it should stop 
the compilation process by requesting
```
errormessages.syntaxError "warning message" atRange (range)
```
where `range` speciifes the line and column range in the source where the 
error was found.  Each node in the parse tree and most nodes in the AST have 
a `range` attribute that gives its location in the source; the exceptions are
things that were implicit in the source, like `self` and `outer`.  The IDE will
then highlight the offending range of the source program.



