---
author:
- 'Andrew P. Black'
- 'Kim B. Bruce'
- James Noble
bibliography:
- 'spec.bib'
title: |
    The Grace Programming Language\
    Draft Specification Version 0.6a1.
...

<span>Revision committed on -- at : by </span>

Introduction
============

This is a specification of the Grace Programming Language. This
specification is notably incomplete, and everything is subject to
change. In particular, this version does *not* address:

-   the library, especially collections and collection literals

-   static type system (although we’ve made a start)

-   immutable data and pure methods.

-   reflection

-   assertions, data-structure invariants, pre & post conditions,
    contracts

-   libraries, including more (complex?) Numeric types and testing

User Model
==========

------------------------------------------------------------------------

> *All designers in fact have user and use models consciously or
> subconsciously in mind as they work. Team design …requires explicit
> models and assumptions.*
>
> Frederick P. Brooks, *The Design of Design*.

------------------------------------------------------------------------

1.  First year university students learning programming in CS1 and CS2
    classes that are based on object-oriented programming.

    1.  The courses may be structured objects first, or
        imperative first. Is it necessary to support “procedures first”?

    2.  The courses may be taught using dynamic types, static types, or
        both in combination (in either order).

    3.  We aim to offer some (but not necessarily complete) support for
        “functional first” curricula, primarily for courses that proceed
        rapidly to imperative and object-oriented programming.

2.  University students taking second year classes in programming,
    algorithms and data structures, concurrent programming, software
    craft, and software design.

3.  Faculty and teaching assistants developing libraries, frameworks,
    examples, problems and solutions, for first and second year
    programming classes.

4.  Programming language researchers needing a contemporary
    object-oriented programming language as a research vehicle.

5.  Designers of other programming or scripting languages in search of a
    good example of contemporary OO language design.

Syntax
======

------------------------------------------------------------------------

> *Much of the following text assumes the reader has a minimal grasp of
> computer terminology and a “feeling” for the structure of a program.*
>
> Jensen and Wirth, *Pascal: User Manual and Report*.

------------------------------------------------------------------------

Grace programs are written in Unicode. Reserved words are written in the
ASCII subset of Unicode. 

Layout {#Layout}
------

Grace uses braces for grouping.  Code layout must be consistent with
grouping.  Indentation must increase by at least two spaces after a
brace. 
Statements are terminated by semicolons, and by line breaks when the
following line has the same or lesser indentation than the indentation
of the line containing the start of the current statement.

### code with punctuation

    def x = 
      muble("3")
      fratz(7);
    while {stream.hasNext} do {
       print(stream.read);
    };

### code without punctuation

    def x = 
      muble("3")
      fratz(7)
    while {stream.hasNext} do {
       print(stream.read)
    }

This defines `x` to be the result of the single request `muble("3") fratz(7)`.

Comments
--------

Grace’s comments start with a pair of slashes `//` and are terminated by
the end of the line. Comments are *not* treated as
white-space. Each comment is conceptually attached to the smallest
immediately preceding syntactic unit, except that comments following a
blank line are attached to the largest immediately following syntactic
unit.

    // comment, to end of line

Identifiers and Operators
-------------------------

Identifiers must begin with a letter, which is followed by a sequence of
zero or more letters, digits and prime (`'`) or underscore (`_`)
characters.

A single underscore (`_`) acts as a placeholder identifier: it can
appear in declarations, but not in expressions. In declarations, `_` is
treated as a fresh identifier.

Operators are sequnces of unicode operator symbols and the following
ASCII operator characters:

   ! ? @ # $ % ^ & | ~ = + - * / \ > < : . 

Reserved Tokens
---------------

Grace has the following reserved tokens:

    alias as class def dialect exclude inherit import is method object
    outer prefix return self Self trait type var use where 

    . := = ; { } [ ] ( ) : -> < > 

Newlines, Tabs and Control Characters
-------------------------------------

Newline in Grace programs can be represented by the Unicode <span
style="font-variant:small-caps;">line feed (lf)</span> character, by the
Unicode <span style="font-variant:small-caps;">carriage return
(cr)</span> character, or by the Unicode <span
style="font-variant:small-caps;">line separator</span>
<span>(U+2028)</span> character; a <span
style="font-variant:small-caps;">line feed</span> that immediately
follows a <span style="font-variant:small-caps;">carriage return</span>
is ignored.

Tabs and all other non-printing control characters are syntax errors,
even in a string literal. Escape sequences are provided to denote
control characters in strings; see Table \[tab:StringEscapes\] in
Section \[Strings\].
	
Built-in Objects
================

Done
----

Assignments, and methods without an explicit result, have the value
`done`, of type `Done`. The type `Done` plays a role similar to *void*
or *Unit* in other languages. The only requests understood by `done` are
`asString` and `asDebugString`. (In particular, `done` does not have an
equality method).

Numbers
-------

Grace supports a single type `Number`. `Number` supports at least 64-bit
precision floats. Implementations may support other numeric types: a
full specification of numeric types is yet to be completed.

Grace has three syntactic forms for numerals (that is, literals that
denote `Number`s).

1.  Decimal numerals, written as strings of digits, optionally preceded
    by a minus.

2.  Explicit radix numerals, written as a (decimal) number between 2 and
    35 representing the radix, a leading `x`, and a string of digits,
    where the digits from 10 to 35 are represented by the letters A to
    Z, in either upper or lower case. A radix of 0 is taken to mean a
    radix of 16. Explicit radix numerals may optionally be preceded by
    a minus.

3.  Base-exponent numerals, always in decimal, which contain a decimal
    point, or an exponent, or both. Grace uses `e` as the
    exponent indicator. Base-exponent numerals may optionally be
    preceded by a minus, and may have a minus in front of the exponent.

### Examples 

    1
    -1
    42
    3.14159265
    13.343e-12
    -414.45e3
    16xF00F00
    2x10110100
    0xdeadbeef // Radix zero treated as 16

Booleans 
--------

The predefined constants `true` and `false` denote values of Grace’s
`Boolean` type. Boolean operators are written using `&&` for and, `||`
for or, and prefix `!` for not.

### Examples 

    P && Q
    toBe || toBe.not

In addition to `&&` and `||` taking boolean arguments, they also accept
parmameterless blocks that return `Boolean`.  This gives them 
“short circuit” (a.k.a non-commutative) semantics.

### Examples 

    P && { Q }
    toBe || { ! toBe }

Strings and Characters 
----------------------

String literals in Grace are written between double quotes, and must be
confined to a single line. Strings literals support a range of escape
characters such as `"\n\t"`, and also escapes for Unicode; these are
listed in Table \[tab:StringEscapes\]. Individual characters are
represented by Strings of length 1. Strings are Grace value objects (see
§\[Values\]), and so an implementation may intern them. Grace’s standard
library includes supports efficient incremental string construction.

   Escape  Meaning        Unicode                         Escape           Meaning              Unicode
  -------- -------------- --------------------- -------------------------- -------------------- -------------------------
    \\\\   backslash      <span>U+005C</span>             \\`_`            non-breaking space   <span>U+00A0</span>
    \\n    line-feed      <span>U+000A</span>              \\r             carriage return      <span>U+000D</span>
    \\t    tab            <span>U+0009</span>              \\l             Line separator       <span>U+2028</span>
    \\{    left brace     <span>U+007B</span>           \\u$hhhh$          4-digit Unicode      <span>U+$hhhh$</span>
    \\}    right brace    <span>U+007D</span>    <span>\\U$hhhhhh$</span>  6-digit Unicode      <span>U+$hhhhhh$</span>
   \\`"`   double quote   <span>U+0022</span>                                                   

### Examples {#examples-3 .unnumbered}

    "Hello World!"
    "\t"
    "The End of the Line\n"
    "A"

### String interpolation {#StringInterpolation}

Within a string literal, expressions enclosed in braces are treated
specially. The expression is evaluated, the `asString` method is
requested on the resulting object, and the resulting string is inserted
into the string literal in place of the brace expression.

### Examples {#examples-4 .unnumbered}

    "Adding {a} to {b} gives {a+b}"

Blocks {#Blocks}
======

Grace blocks are lambda expressions; they may or may not have
parameters. If a parameter list is present, the parameters are separated
by commas and the list is terminated by the `->` symbol.

    { do.something }
    { i -> i + 1 }
    { sum, next -> sum + next }

Blocks construct objects containing a method named `apply`, or
`apply(n)`, or `apply(n, m)`, …where the number of parameters to `apply`
is the same as the number of parameters of the block. Requesting the
`apply` method evaluates the block; it is an error to provide the wrong
number of arguments.

### Examples {#examples-5 .unnumbered}

The looping construct

    for (1..10) do {
        i -> print i 
    }

might be implemented as as method with a block parameter

    method for (collection) do (block) {
        def stream = collection.iterator
        while {stream.hasNext} do {
            block.apply(stream.next)
        }
    }

Here is another example:

    var sum := 0
    def summingBlock : Block<Number,Number> =
        { i : Number ->  sum := sum + i }
    summingBlock.apply(4)       // sum now 4
    summingBlock.apply(32)      // sum now 36

Blocks are lexically scoped inside their containing method or block.
The body of a block consists of a sequence of declarations and
expressions. An empty body is allowed, and is equivalent to `done`.

Declarations
============

Declarations of constants and variables may occur anywhere within an
object, a method, or a block: their scope is the whole of their
defining object, method, or block.  It is also an error to attempt to
declare any name more than once in the same lexical scope.

**Shadowing.** Grace has a single namespace for all identifiers; this
shared namespace is used for methods, parameters, constants, variables
and types. It is an error to declare a constant, variable or parameter
that shadows a lexically-enclosing constant, variable or parameter.

Constants
---------

Constant definitions are introduced using the `def` keyword; they bind
an identifier to the value of an initialising expression, and may
optionally be given a type. Constants cannot be re-bound.

### Examples {#examples-6 .unnumbered}

    def x = 3 * 100 * 0.01
    def x : Number = 3
    def x : Number           // Syntax Error: x must be initialised

Variables
---------

Variable definitions are introduced using the `var` keyword; they
optionally bind an identifier to the value of an initialising
expression. Variables can be re-bound to
new values as often as desired, using an assignment. If a
variable is declared without an initializing expression, it is said to
be *uninitialised*; any attempt to access the value of an uninitialised
variable is an error. This error may be caught either at run time or at
compile time, depending on the cleverness of your implementor.

### Examples

    var x:Rational := 3     // explicit type
    var x:Rational          // x must be initialised before access
    var x := 3              // x has type Unknown 
    var x                   // x has Unknown type and uninitialised value 

Methods
-------


Methods are declared with the `method` keyword.
Methods define the action to be taken when the object containing the
method receives a request with the given name. Because every method must
be associated with an object, methods may not be declared directly
inside other methods.
The type of the object returned from the method may optionally be given
after the symbol `->`. The body of the method is enclosed in braces.

    method pi  { 3.141592634 } 

    method greet(user: Person) from(sender: Person) {
        print ``{sender} sends his greetings, {user}.''
    }

    method either (a) or (b) -> Done {
        if (random.nextBoolean)
            then {a.apply} else {b.apply}
    }


### Method Names

Methods names are a sequence of one or more parts, each part 
A method name with a single part can optionally have an argument list.

A method each part
comprising an identifier and an argument list.  

part of a method name just one part may
or may not have arguments; otherwise each part (in "multi-part names")
must have at least one argument declared after the name of that part.
Methods can also be named by an identifier suffixed with “`:=`”; this
form of name is conventionally used for writer methods, both
user-written and automatically-generated, as exemplified by `value:=`
below. Prefix operator methods are named “`prefix`” followed by the
operator character(s).

Methods may also define binary or prefix unary operators. Binary
operator messages take a single arguemnt and thier names are sequences
of operator characters; prefix methods take no arguments and their
names are prefixed by `prefix`.

### Examples

    method +(other : Point) -> Point { 
        (x +other.x) @ (y +other.y) 
    }

    method + (other) {
        (x +other.x) @ (y +other.y)
    }

    method + (other) 
        { return (x +other.x) @ (y +other.y) }

    method value:=(n : Number) -> Done {
        print "value currently {value}, now assigned {n}"
        super.value:= n 
    }

### Type Parameters

Methods may be declared with type parameters; these type parameters may
be constrained with `where` clauses.

### Examples {#examples-10 .unnumbered}

    method sumSq<T>(a : T, b : T) -> T where T <: Numeric {
        (a * a) + (b * b)
    }

    method prefix- -> Number 
         { 0 - self }

### Returning a Value from a Method

Methods may contain one or more `return` statements.
If a `return e` statement is executed, the method terminates with the
value of the expression `e`, while a `return` statement with no
expression returns `done'.  If execution reaches
the end of the method body without executing a `return`, the method
terminates and returns the value of the last expression evaluated. 
An empty method body returns `done`.


Objects and Classes {#ObjectsAndClasses}
===================

Grace `object` constructor expressions and declarations produce
individual objects. Grace provides `class` declarations to create
classes of objects all of which have the same structure.

Grace’s class and inheritance design is complete but tentative. We need
experience before confirming the design.

Objects {#Objects}
-------

Object literals are expressions that evaluate to an object with the
given attributes. Each time an object literal is executed, a new object
is created. In addition to declarations of fields and methods, object
literals can also contain expression, which are executed as a
side-effect of evaluating the object literal. All of the declared
attributes of the object are in scope throughout the object literal.

### Examples {#examples-11 .unnumbered}

    object {
        def colour:Colour = Colour.tabby
        def name:String = "Unnamed"
        var miceEaten := 0
        method eatMouse {miceEaten := miceEaten + 1}
    }

Object literals are lexically scoped inside their containing method, or
block.

A name can be bound to an object literal, like this:

    def unnamedCat =  object {
         def colour : Colour = Colour.tabby
         def name : String = "Unnamed"
         var miceEaten := 0
         method eatMouse {miceEaten := miceEaten + 1 }
    }

Every reference to `unnamedCat` returns the same object.  \

Factory methods
---------------

The body of a factory method is treated as an object constructor that is
executed every time that the factory method is invoked. The factory
method returns the newly-created object. Thus, the keyword `factory` in
front of a method declaration is equivalent to enclosing the method body
in `object { ... }`. For example,

    factory method ofColour(c) named (n) {
        def colour is public = c
        def name is public = n
        var miceEaten is readable := 0
        method eatMouse {miceEaten := miceEaten + 1}
        print "The cat {n} has been created."
    }

is equivalent to

    method ofColour(c) named (n) {
        object {
            def colour is public = c
            def name is public = n
            var miceEaten is readable := 0
            method eatMouse {miceEaten := miceEaten + 1}
            print "The cat {n} has been created."
        }
    }

Classes {#Classes}
-------

Class declarations combine the definition of an object with the
definition of a single factory method on that object. This method
creates “instances of the class”. A class declaration is syntactically a
combination of a definition, an object constructor, and a factory
method.

### Examples {#examples-12 .unnumbered}

    class cat.ofColour (c:Colour) named (n: String) {
        def colour:Colour is public = c
        def name:String is public = n
        var miceEaten is readable := 0
        method eatMouse {miceEaten := miceEaten + 1}
        print "The cat {n} has been created."
    }

is equivalent to

    def cat = object {
        factory method ofColour (c:Colour) named (n: String) {
            def colour:Colour is public = c
            def name:String is public = n
            var miceEaten is readable := 0
            method eatMouse {miceEaten := miceEaten + 1}
            print "The cat {n} has been created."
        }
    }

\[Constructors\]

This declares a class, binds it to the name `cat`, and declares a
factory method on that class called `ofColour()named()`. This method
takes two arguments, and returns a newly-created object with the fields
and methods listed. Creating the object also has the side-effect of
printing the given string, since executable code in the class
declaration is also part of the implicit object literal.

This class might be used as follows:

    def fergus = cat.ofColour (Colour.Tortoiseshell) named "Fergus"

This creates an object with fields `colour` (set to
`Colour.Tortoiseshell`), `name` (set to `"Fergus"`), and `miceEaten`
(initialised to `0`), prints “The Cat Fergus has been created”, and
binds `fergus` to this object.

Classes with more than one method cannot be built using the `class`
syntax, but programmers are free to build such objects using object
constructors containing several methods, some of which may be factory
methods.

Inheritance {#Inheritance}
-----------

Grace supports inheritance with “single subclassing, multiple subtyping”
(like Java), by way of an `inherits ` clause in a class declaration or
object literal.

A new declaration of a method can override an existing declaration, but
overriding declarations must be annotated with `is override`. Overridden
methods can be accessed via `super` requests. (see §\[SuperRequests\]).
It is a static error for a field to override another field or a method.

The example below shows how a subclass can override accessor methods for
a variable defined in a superclass (in this case, to always return 0 and
to ignore assignments).

    class aPedigreeCat.ofColour (aColour) named (aName) {
       inherits cat.ofColour (aColour) named (aName)
       var prizes := 0
       method miceEaten is override {0}
       method miceEaten:= (n:Number)->Number is override {return}
                                          // ignore attempts to change it
    }

The right hand side of an `inherits` clause is restricted to be an
expression that creates a new object, such as the name of a class
followed by a request on its factory method, or a request to copy an
exiting object.

When executing inherited code, self is first bound to the object under
construction, self requests are resolved in the same way as the finally
constructed object, def and var initialisers and inline code are run in
order from the topmost superclass down to the bottom subclass. Accesses
to unitialised vars and defs raise uninitialised exceptions
(§\[Uninitialised\]).

Understanding Inheritance (under discussion) {#UnderstandingClasses}
--------------------------------------------

Grace’s class declarations can be understood in terms of a flattening
translation to object constructor expressions that build the factory
object. Understanding this translation lets expert programmers build
more flexible factories.

The above declaration for `class aPedigreeCat` is broadly equivalent to
the following nested object declarations, not considering types,
modules, and *renaming superclass methods to ensure that an object’s
method have unique names*.

    def aPedigreeCat = object { // a cat factory
        method ofColour (c: Colour) named (n: String) -> PedigreeCat {
        object  { // the cat herself
            def colour : Colour := c
            def name : String := n
            var Cat__miceEaten := 0   // ugly. very ugly
                var prizes = 0
                method miceEaten {0} 
                method miceEaten:=(n:Number) {return} // ignore attempts to change it
            } // object
         } // method
    } // object 

Parameterized Classes {#GenericClasses}
---------------------

Classes may optionally be declared with type parameters. The
corresponding requests on the factory methods may optionally be provided
with type arguments. Type parameters may be constrained with `where`
clauses.

### Examples {#examples-13 .unnumbered}

    class aVector.ofSize(size)<T> {  
       var contents := Array.size(size)
       method at(index : Number) -> T {return contents.at() } 
       method at(index : Number) put(elem : T) { }
    }

    class aSortedVector.ofSize<T> 
       where T <: Comparable<T> {
          ...
    }

Method Requests {#MethodReq}
===============

Grace is a pure object-oriented language. Everything in the language is
an object, and all computation proceeds by *requesting* an object to
execute a method with a particular *name*. The response of the object is
to execute the method. The value of a method request is the value
returned by the execution of the method (see Section \[methodReturn\]).

We distinguish the act of *requesting* a method (what Smalltalk calls
“sending a message”), and *executing* that method. Requesting a method
happens outside the object receiving the request, and involves only a
reference to the receiver, the method name, and possibly some arguments.
In contrast, executing the method involves the code of the method, which
is local to the receiver.

Named Requests {#NamedCall}
--------------

A named method request is a receiver followed by a dot “.”, then a
method name (an identifier), then any arguments in parentheses.
Parentheses are not used if there are no arguments. To improve
readability, a the name of a method that takes more than one parameter
may comprise multiple parts, with argument lists between the parts, and
following the last part. For example

        method drawLineFrom(source)to(destination) { ... }

In this example the name of the method is `drawLineFrom()to()`; it
comprises two parts, `drawLineFrom` and `to`. The name of a method and
the position of its argument lists within that name is determined when
the method is declared. When reading a request of a multi-part method
name, you should continue accumulating words and argument lists as far
to the right as possible. Grace does not allow the “overloading” of
method names: the type and number of arguments in a method request does
not influence the name of the method being requested.

If the receiver of a named method is `self` it may be left implicit,
*i.e.*, the `self` and the dot may both be omitted. \[ArgParens\]
Parenthesis may be omitted where they would enclose a single argument
that is a numeral, string or block literal.

### Examples {#examples-14 .unnumbered}

        canvas.drawLineFromPoint(p1)toPoint(p1)
        canvas.drawLineFromPoint(origin)ofLenthXY(3,5)
        canvas.movePenToXY(x,y)
        canvas.movePenToPoint(p)
        print "Hello world" 
        size 

Assignment Requests {#Assignments}
-------------------

An assignment request is a variable followed by `:=`, or it is a request
of a method whose name ends with `:=`. In both cases the `:=` is
followed by a single argument. Spaces are optional before and after the
`:=`.

### Examples {#examples-15 .unnumbered}

       x := 3
       y:=2 
       widget.active := true

Assignment methods return `done`.  \

Binary Operator Requests {#BinaryOperatorCall}
------------------------

Binary operators are methods whose names comprise one or more operator
characters, provided that the operator is not a reserved symbol of the
Grace language. Binary operators have a receiver and one argument; the
receiver must be explicit. So, for example, `+`, `++` and `..` are valid
operator symbols, but `.` is not, because it is reserved.

Most Grace operators have the same precedence: it is a syntax error for
two different operator symbols to appear in an expression without
parenthesis to indicate order of evaluation. The same operator symbol
can be requested more than once without parenthesis; such expressions
are evaluated left-to-right.

Four binary operators do have precedence defined between them: `/` and
`*` over `* and \lstinline`-+.

### Examples {#examples-16 .unnumbered}

    1 + 2 + 3                       // evaluates to 6
    1 + (2 * 3)                 // evaluates to 7
    (1 + 2) * 3                 // evaluates to 9
    1 + 2 * 3                       // evaluates to 7
    1 +*+ 4 -*- 4           // syntax error

Named method requests without arguments bind more tightly than operator
requests. The following examples show the Grace expressions on the left,
and the parse on the right.

### Examples {#examples-17 .unnumbered}

  ----------------------------- ---------------------------
  `1 + 2.i`                     `1 + (2.i)`
  `(a * a) + (b * b).sqrt`      `(a * a) + ((b *b).sqrt)`
  `((a * a) + (b * b)).sqrt `   `((a * a) + (b *b)).sqrt`
  `a * a + b * b`               `(a * a) + (b *b)`
  `a + b + c`                   `(a + b) + c`
  `a - b - c`                   `(a - b) - c`
  ----------------------------- ---------------------------

Unary Prefix Operator Requests {#PrefixOperatorCall}
------------------------------

Grace supports unary methods named by operator symbols that precede the
explicit receiver. (Since binary operator methods must also have an
explicit receiver, there is no syntactic ambiguity.)

Prefix operators bind less tightly than named method requests, and more
tightly than binary operator requests.

### Examples {#examples-18 .unnumbered}

    -3 + 4
    (-b).squared
    -(b.squared)
    - b.squared     // parses as -(b.squared)

    status.ok :=  !engine.isOnFire && wings.areAttached && isOnCourse

Bracket Operator Requests {#BracketOperatorRequest}
-------------------------

Grace supports operators `[`…`]` and `[`…`]:=`, which can be defined in
libraries, *e.g.*, for indexing and modifying collections.

### Examples {#examples-19 .unnumbered}

    print( a[3] )       // requests method [] on a with argument 3
    a[3] := "Hello"    // requests method []:= on a with arguments 3 and "Hello"

Super Requests {#SuperRequests}
--------------

The reserved word `super` may be used only as an explicit receiver. In
overriding methods, method requests with the receiver `super` request
the prior overridden method with the given name from `self`. Note that
no “search” is involved; super-requests can be resolved statically,
unlike other method requests.

### Examples {#examples-20 .unnumbered}

      super.value
      super.bar(1,2,6)
      super.doThis(3) timesTo("foo")
      super + 1 
      !super 

      foo(super)  // syntax error
      1 + super   // syntax error

Outer {#OuterRequests}
-----

The reserved word `outer` is used to refer to identifiers in lexically
enclosing scopes. The expression `outer.x` refers to the innermost
lexically enclosing identifier `x`; it is an error if there is no such
`x`. If there are multiple enclosing declarations of `x`, then only the
innermost is accessible; if a programmer finds it necessary to refer to
one of the others, then the programmer should change the name to avoid
this problem.

<span> <span>$\blacktriangleright$<span>**Note: **</span>**minigrace*
currently recognizes `outer` as a *method* that can be requested of any
object and that answers a reference to its enclosing object. This is a
known limitation.*$\blacktriangleleft$</span> </span>

### Examples {#examples-21 .unnumbered}

      outer                     // illegal
      outer.value
      outer.bar(1,2,6)
      outer.outer.doThis(3) timesTo("foo")                      // illegal
      outer + 1     // illegal   (requests the binary + method, but on what receiver?)
      ! outer                           // illegal  (requests the prefix ! method, but on what receiver?)

Encapsulation
-------------

Grace has different default encapsulation rules for methods, types, and
fields. The defaults can be changed by explicit annotations. The details
are as follows.

### Methods and Types {#methodencapsulation}

By default, methods and types are public, which means that they can be
requested by any client that has access to the object. Thus, any
expression can be the target of a request for a public method.

If a method or type is annotated `is confidential`, it can be requested
only on the target `self` or `super`. This means that such a method or
type is accessible to the object that contains it, and to inheriting
objects, but not to client objects.

Methods and Types can be explicitly annotated as `is public`; this has
no effect unless a dialect changes the default encapsulation.

Some other languages support “private methods”, which are available only
to an object itself, and not to clients or subobjects. Grace has neither
private methods nor private types.

### Classes {#classes}

### Fields {#fieldencapsulation}

Variables and definitions (`var` and `def` declarations) immediately
inside an object constructor create *fields* in that object.

A field declared as `var x` can be read using the request `x` and
assigned to using the assignment request `x:=()` (see §\[Assignments\]).
A field declared as `def y` can be read using the request `y`, and
cannot be assigned. By default, fields are *confidential*: they can be
accessed and assigned from the object itself, and inheriting objects,
and from lexically-enclosed objects, but not from clients. In other
words, these requests can be made only on `self`, `super` and `outer`.

The default visibility can be changed using annotations. The annotation
`readable` can be applied to a `def` or `var` declaration, and makes the
accessor request available to any object. The annotation `writable` can
be applied to a `var` declaration, and makes the assignment request
available to any object. It is also possible to annotate a field
declaration as `public`. In the case of a `def`, `public` is equivalent
to (and preferred over) `readable`. In the case of a `var`, `public` is
equivalent to `readable, writable`.

Fields and methods share the same namespace. The syntax for variable
access is identical to that for requesting a reader method, while the
syntax for variable assignment is identical to that for requesting an
assignment method. This means that an object cannot have a field and a
method with the same name, and cannot have an assignment method `x:=()`
as well as a `var` field `x`.

### Examples {#examples-22 .unnumbered}

     [escapechar=\%]
    object {
        def a = 1  %\tabto{5cm}%            // Confidential access to a
        def b is public = 2   %\tabto{5cm}%     // Public access to b
        def c is readable = 2   %\tabto{5cm}%  // Public access to c
        var d := 3    %\tabto{5cm}%               // Confidential access and assignment 
        var e is readable   %\tabto{5cm}%       // Public access and confidential assignment
        var f is writable  %\tabto{5cm}%         // Confidential access, public assignment
        var g is public    %\tabto{5cm}%         // Public access and assignment
        var h is readable, writable  %\tabto{5cm}%  // Public access and assignment
    }

### No Private Fields

Some other languages support “private fields”, which are available only
to an object itself, and not to clients or inheritors. Grace does not
have private fields; all fields can be accessed from subobjects.
However, the parameters and temporary variables of methods that return
fresh objects can be used to obtain an effect similar to privacy.

### Examples {#examples-23 .unnumbered}

        method newShipStartingAt(s:Vector2D)endingAt(e:Vector2D) {
            // returns a battleship object extending from s to e.  This object cannot
            // be asked its size, or its location, or how much floatation remains.
            assert ( (s.x == e.x) || (s.y == e.y) )
            def size = s.distanceTo(e)
            var floatation := size
            object {
                method isHitAt(shot:Vector2D) {
                    if (shot.onLineFrom(s)to(e)) then {
                        floatation := floatation -1
                        if (floatation == 0) then { self.sink }
                        true
                    } else { false }
                }
                ...
            }
        }                

Requesting Methods with Type Parameters {#GenericMethodRequests}
---------------------------------------

Methods that have type parameters may be requested without explicit type
arguments. When a method declared with type parameters is requested in a
statically typed context without explicit type arguments, the type
arguments are inferred.

### Examples {#examples-24 .unnumbered}

    sumSq<Integer64>(10.i64, 20.i64) 

    sumSq(10.i64, 20.i64) 

Precedence of Method Requests {#sect:precedence}
-----------------------------

Grace programs are formally defined by the language’s grammar (see
appendix \[Grammar\]). The grammar gives the following precedence
levels; lower numbers bind more tightly.

1.  Numerals, and constructors for numbers, strings, objects, iterables,
    blocks, and types; parenthesized expressions.

2.  Requests of named methods, and of the `[` bracket `]` method.
    Multi-part requests accumulate name-parts and arguments as far to
    the right as possible.

3.  Prefix operators: associate right to left.

4.  “Multiplicative” operators `*` and `/`: associate left to right.

5.  “Additive” operators `+` and `-`: associate left to right.

6.  “Other” operators, whose binding must be given explicitly
    using parenthesis.

7.  Assignments, and method requests using `:=` as a suffix to a
    method name.

Control Flow {#ControlFlow}
============

Control flow statements are requests to methods defined in the dialect.
Grace uses what looks like conventional syntax with a leading keyword
(`if`, `while`, `for`, etc.); these are actually method requests on the
`outer` object defined in *standardGrace* or in some dialect.

Conditionals {#BasicControlFlow}
------------

``` {mathescape="true"}
if (test) then {block}

if (test) then {block} else {block}

if (test$_{1}$) then {block$_{1}$} elseif {test$_{2}$} then {block$_{2}$} ... else {block$_{n}$}
```

Looping statements
------------------

Grace has two bounded loops and an unbounded (while) loop.

### for statement: {#for-statement .unnumbered}


    for (collection) do { each -> loop body }

    for (course.students) do { s:Student -> print s } 

    for (0..n) do { i -> print i }

The first argument can be any object that answers an iterator when
requested. Numeric ranges, collections and strings are typical examples.
It is an error to modify the collection being iterated in the loop body.
The block following `do` is executed repeatedly with the values yielded
by the iterator as argument. Note that the block must have a single
parameter; if the body of the block does not make use of the parameter,
it may be named `_`.

### Examples {#examples-25 .unnumbered}


    for (1..4) do { _ -> turn 90; forward 10 }

For the common case where an action is repeated a fixed number of times,
use `repeat()times()`, which takes a parameterless block:


    repeat 4 times { turn 90; forward 10 }

### while statement: {#while-statement .unnumbered}

    while {test} do {block}

Note that, since test can do a series of actions before returning a
boolean, `while()do()` can be used to implement loops with exits in the
middle or at the end, as well as loops with exits at the beginning.

Case {#Case}
----

The `match(exp)`…`case(p`$_{1}$`)` …`case(p`$_{n}$`)` construct attempts
to match its first argument `exp` against a series of *pattern blocks*
`p`$_{i}$. Patterns support destructuring.

### Examples {#examples-26 .unnumbered}

    match (x)
        case { 0 -> "Zero" }                        
        // match against a literal constant
        case { s:String -> print(s) }    
        // typematch, binding s - identical to block with typed parameter
        case { (pi) -> print("Pi = " ++ pi) } 
        // match against the value of an expression - requires parenthesis
        case { _ : Some(v) -> print(v) }
        // typematch, binding a variable - looks like a block with parameter
        case { _ -> print("did not match") }
        // match against placeholder, matches anything

The `case` arguments are patterns: objects that understand the request
`match()` and return a `MatchResult`, which is either a
`SuccessfulMatch` object or a `FailedMatch` object. Each of the case
patterns is requested to `match(x)` in turn, until one of them returns
`SuccessfulMatch(v)`; the result of the whole `match`–`case` construct
is `v`.

### Patterns {#Patterns}

Pattern matching is based around the `Pattern` objects, which are
objects that respond to a request `match(anObject)`. The pattern tests
whether or not the argument to `match` “matches” the pattern, and
returns a `MatchResult`, which is either a `SuccessfulMatch` or a
`FailedMatch`. An object that has type `SuccessfulMatch` behaves like
the boolean `true` but also responds to the requests `result` and
`bindings`. An object that has type `FailedlMatch` behaves like the
boolean `false` but also responds to the requests `result` and
`bindings`.

`result` is the return value, typically the object matched, and the
`bindings` are a list of objects that may be bound to intermediate
variables, generally used for destructuring objects.

For example, in the scope of this `Point` type:

    type Point = {
      x -> Number
      y -> Number
      extract -> List<Number>
    }

implemented by this class:

    class aCartesianPoint.x(x':Number)y(y':Number) -> Point {
      method x { x' }
      method y { y' }
      method extract { aList.with(x, y) } 
    }

these hold:

    def cp = aCartesianPoint.new(10,20)

    Point.match(cp).result         %\tabto{5cm}%  // returns cp
    Point.match(cp).bindings    %\tabto{5cm}%   // returns an empty list
    Point.match(true)    %\tabto{5cm}%          // returns FailedMatch

### Matching Blocks

Blocks with a single parameter are also patterns: they match any object
that can validly be bound to that parameter. For example, if the
parameter is annotated with a type, the block will successfully match an
object that has that type, and will fail to match other objects.

Matching-blocks support an extended syntax for their parameters. In
addition to being a fresh variable, as in a normal block, the parameter
may also be a pattern. Matching-blocks are themselves patterns:
one-argument (matching) block with parameter type `A` and return type
`R` also implements `Pattern<R,Done>`.

A recursive, syntax-directed translation maps matching-blocks into
blocks with separate explict patterns non-matching blocks that are
called via `apply` only when their patterns match.

First, the matching block is flattened — translated into a
straightforward non-matching block with one parameter for every bound
name or placeholder. For example:

     { _ : Pair(a,Pair(b,c)) -> "{a} {b} {c}"  }

is flattened into

     { _, a, b, c -> "{a} {b} {c}" }

then the pattern itself is translated into a composite object structure:

    def mypat = 
      MatchAndDestructuringPattern.new(Pair, 
         VariablePattern.new("a"), 
         MatchAndDestructuringPattern.new(Pair,
            VariablePattern.new("b"), VariablePattern.new("c")))

Finally, the translated pattern and block are glued together via a
`LambdaPattern`:

    LambdaPattern.new( mypat,  { _, a, b, c -> "{a} {b} {c}" } )

The translation is as follows:

  `e`                             $\lbrack\lbrack$ `e` $\rbrack\rbrack$
  ------------------------------- ---------------------------------------------------------------------------------------------------------------------
  `_ : e`                         $\lbrack\lbrack$ `e` $\rbrack\rbrack$
  `_`                             `WildcardPattern`
  `v` (fresh, unbound variable)   `VariablePattern("v")`
  `v` (bound variable)            error
  `v : e`                         `AndPattern.new(VariablePattern.new("v"),`$\lbrack\lbrack$ `e` $\rbrack\rbrack$ `)`
  `e(f,g)`                        `MatchAndDestructuringPattern.new(e,` $\lbrack\lbrack$`f`$\rbrack\rbrack$`,` $\lbrack\lbrack$`g`$\rbrack\rbrack$`)`
  literal                         `literal`
  `e` not otherwise translated    `e`

### Implementing Match-case

Finally the match(1)\*case(N) methods can be implemented directly, e.g.:

    method match(o : Any) 
             case(b1 : Block<B1,R>) 
             case(b2 : Block<B2,R>)
      {
        for [b1, b2] do { b -> 
          def rv = b.match(o)
          if (rv.succeeded) then {return rv.result}
        }
        
        FailedMatchException.raise
      }

or (because matching-blocks are patterns) in terms of pattern
combinators:

    method match(o : Any)
             case(b1 : Block<B1,R>) 
             case(b2 : Block<B2,R>)
      {
        def rv = (b1 || b2).match(o) 
        if (rv.succeeded) then {return rv.result}

        FailedMatchException.raise
      }

#### First Class Patterns

While all types are patterns, not all patterns are types. For example,
it would seems sensible for regular expressions to be patterns,
potentially created via one (or more) shorthand syntaxes (shorthands all
defined in standard Grace)

    match (myString) 
      case { "" -> print "null string" }
      case { Regexp.new("[a-z]*") -> print "lower case" }
      case { "[A-Z]*".r  -> print "UPPER CASE" }
      case { /"[0-9]*" -> print "numeric" } 
      case { ("Forename:([A-Za-z]*)Surname:([A-Za-z]*)".r2)(fn,sn)  -> 
                    print "Passenger {fn.first} {sn}"}

With potentially justifiable special cases, more literals, e.g. things
like tuples/lists could be descructured `[a,b,...] -> a * b`. Although
it would be very nice, it’s hard to see how e.g. points created with
`"3@4"` could be destructed like `a@b -> print "x: {a}, y: {b}"` without
yet more bloated special-case syntax.

#### Discussion

This rules try to avoid literal conversions and ambiguous syntax. The
potential ambiguity is whether to treat something as a variable
declaration, and when as a first-class pattern. These rules (should!)
treat only fresh variables as intended binding instances, so a “pattern”
that syntactically matches a simple variable declaration (as in this
block `{ empty -> print "the singleton empty collection" }`) will raise
an error — even though this is unambiguous given Grace’s no shadowing
rule.

Match statements that do nothing but match on types must distinguish
themselves syntactically from a variable declaration, *e.g.*:

    match (rv) 
      case { (FailedMatch) -> print "failed" }
      case { _ : SuccessfulMatch -> print "succeeded" }

while writing just:

    match (rv) 
      case { FailedMatch -> print "failed" }
      case { SuccessfulMatch -> print "succeeded" }

although closer to the type declaration, less gratuitous, and perhaps
less error-prone, would result in two errors about variable shadowing.

#### Self-Matching

For this to work, the main value types in Grace, the main literals —
Strings, Numbers — must be patterns that match themselves. That’s what
lets things like this work:

    method fib(n : Number) {
      match (n) 
        case { 0 -> 0 }
        case { 1 -> 1 }
        case { _ -> fib(n-1) + fib(n-2) }
    }

With this design, there is a potential ambiguity regarding Booleans:
“`true || false`” as an expression is very different from
“`true | false`” as a composite pattern! Unfortunately, if Booleans are
Patterns, then there’s no way the type checker can distinguish these two
cases.

If you want to match against objects that are not patterns, you can lift
any object to a pattern that matches just that object by writing e.g.
`LiteralPattern.new(o)` (option — or something shorter, like a prefix
`=~`?).

Exceptions {#Exceptions}
----------

Grace supports exceptions, which can be raised and caught. Exceptions
are categorized into a hierarchy of `ExceptionKind`s, described in
Section \[ExceptionHierarchy\].

At the site where an exceptional situation is detected, an exception is
raised by requesting the `raise` method on an `ExceptionKind` object,
with a string argument explaining the problem.

### Examples {#examples-27 .unnumbered}

        BoundsError.raise "index {ix} not in range 1..{n}"
        UserException.raise "Oops...!"

Raising an exception does two things: it creates an `exception` object
of the specified kind, and terminates the execution of the expression
containing the `raise` request; it is not possible to restart or resume
that execution[^1]. Execution continues when the exception is *caught.*

An exception will be caught by a dynamically-enclosing
`try(exp) catch (block`$_{1}$`)`
…`catch(block`$_{n}$`) finally(finalBlock)`, in which the `block`$_{i}$
are pattern-matching blocks. More precisely, if an exception is raised
during the evaluation of the `try` block `exp`, the `catch` blocks
`block`$_{1}$, `block`$_{2}$, …`block`$_{n}$, are attempted in order
until one of them matches the exception. If none of them matches, then
the process of matching the exception continues in the
dynamically-surrounding `try() catch()` …`catch() finally()`. The
`finalBlock` is always executed before control leaves the
`try() catch()` …` catch()` `finally()` construct, whether or not an
exception is raised, or one of the `catch` blocks returns.

### Examples {#examples-28 .unnumbered}

    try {
        def f = file.open("data.store")
    } catch {
        e : NoSuchFile -> print "No Such File"
        return
    } catch {
        e : PermissionError -> print "Permission denied"
        return
    } catch {
        _ : Exception -> print "Unidentified Error"
        system.exit
    } finally {
        f.close
    }

The Exception Hierarchy {#ExceptionHierarchy}
-----------------------

Grace defines a hierarchy of kinds of exception. All exceptions have the
same type, that is, they understand the same set of requests. However,
there are various kinds of exception, corresponding to various kinds of
exceptional situation. The exception hierarchy classifies these kinds of
exception using `ExceptionKind` objects, which have the following type:

    type ExceptionKind = Pattern & {
        parent -> ExceptionKind
        // answers the exceptionKind that is the parent of this exception in the 
        // hierarchy. The parent of exception is defined to be exception. The parent
        // of any other exceptionKind is the exception that was refined to create it.
        
        refine (name:String) -> ExceptionKind
        // answers a new exceptionKind, which is a refinement of self.
        
        raise (message:String) 
        // creates an exception of this kind, terminating the current execution, 
        // and transferring control to an appropriate handler.

        raise (message:String) with (data:Object) 
        // similar to raise(), except that the object data is associated with the 
        // new exception.
    }

Because `ExceptionKinds` are also `Patterns`, they support the pattern
protocol (`match`, `&`, and `|`) described in Section \[Patterns\].
Perhaps more pertinently, this means that they can be used as the
argument of the `catch blocks` in a `try()` `catch()` …construct.

At the top of the hierarchy is the `Exception` object; all exceptions
are refinements of `exception`. There are three immediate refinements,
of `Exception`.

1.  `EnvironmentException`: those exceptions arising from interactions
    between the program and the environment, including network
    exceptions, file system exceptions, and inappropriate user input.

2.  `ProgrammingError`: exceptions arising from programming errors.
    Examples are `IndexOutOfBounds`, `NoSuchMethod`, and `NoSuchObject`.

3.  `ResourceException`: exceptions arising from an implementation
    insufficiency, such as running out of memory or disk space.

Notice that there is no category for “expected” exceptions. This is
deliberate; expected events should not be represented by exceptions, but
by other values and control structures. For example, if you you have a
key that may or may not be in a dictionary, you should not request the
`at` method and catch the `NoSuchObject` error. Instead, you should
request the `at()ifAbsent()` method.

Each exception is matched by the `ExceptionKind` that was raised to
create it, and all of the ancestors of that kind of exception. Because
`Exception` is the top of the exception hierarchy, it matches all
exceptions.

Exceptions have the following type.

    type Exception = type {
        exception -> exceptionKind  // the exceptionKind of this exception.
        message -> String       
        // the message that was provided when this exaction was raised.
        
        data -> Object      // the data object that was associated with this exception
        // when it was raised, if there was one. Otherwise, the string "no data".
        
        lineNumber -> Number        // the source code line number
        // of the raise request that created this exception.
        
        moduleName -> String        // the name of the module
        // containing the raise request that created this exception.
        
        backtrace -> List<String>   
        // a description of the call stack at the time that this exception was raised. 
        // backtrace.first is the initial execution environment; backtrace.last is the 
        // context that raised the exception.
    }

Equality and Value Objects {#Values}
==========================

All objects automatically implement the following methods; programmers
may override them.

1.  `==` operator: the implementation inherited from `graceObject`
    answers true if and only if the argument is the same object as
    the receiver.

2.  `!=`, which answers the negation of `==`

3.  `hash`, which must be compatible with `==`. This means that two
    objects that are `==` must have the same `hash`

4.  `asString`, which answers a string representation of the object
    tailored for the end user, and

5.  `asDebugString`, which answers a string representation of the object
    tailored for the programmer; the implementation inherited from
    `graceObject` answers `asString`.

Immutable objects (objects that have no `var` fields and that capture no
mutable objects) that the programmer wishes to treat as a “value
objects” should override `==` so that it implements Leibniz equality.

 

Types {#Types}
=====

Grace uses structural typing @Modula3 [@malayeri08; @whiteoak08]. Types
primarily describe the requests that objects can answer. Fields do not
directly influence types, except that a field that is public, readable
or writable is treated as the appropriate method.

Unlike in other parts of Grace, the names introduced by type
declarations are always statically typed, and their semantics may depend
on the static types. The main case for this is distinguishing between
identifiers that refer to types, and those that refer to constant name
definitions (introduced by `def`) which are interpreted as Singleton
types.

Basic Types
-----------

Grace’s standard prelude defines the following basic types:

-   `None`—an uninhabited type. `None` conforms to all other types.
    \[None\]

-   `Done`—the type of the object returned by assignments and methods
    that have nothing interesting to return. All types conform to
    `Done`. The only methods on `Done` objects are `asString` and
    `asDebugString`

-   `Object`—the common interface of most objects. It has methods `==`,
    `!=` (also written as or $\neq$), `asString`, `asDebugString`, and
    `::` (binding construction). Objects that do not explicitly inherit
    from some other object implicitly inherit from a superobject with
    this type, and thus all objects (apart from `done`) have these
    methods, which will not be further mentioned.

-   `Boolean`—the type of the objects `true` and `false`. `Boolean` has
    methods $\&\&$, $||$, $==$, $!=$, $!$ (prefix-not), `not`, `andAlso`
    (short-circuit <span>and</span>), `orElse` (short-circuit
    <span>or</span>), and `match`.

-   `Number`—the type of all numbers. `Number` has methods $+$, $*$,
    $-$, $/$, $\%$ (remainder), `^` (exponentiation), $++$, $<$, $<=$
    (or $\leq$), $>$, $>=$ (or $\geq$), `..` (creating a range), `-`
    (prefix), `inBase`, `truncate`, and `match`.

-   `String`—the type of character strings, and individual characters.
    String has methods $++$, `size`, `ord`, `at` (also `[ ]`),
    `iterator`, `substringFrom()to`, `replace()with`, `hash`, `indices`,
    `asNumber`, `indexOf`, `lastIndexOf`, and `match`.

-   `Pattern`—pattern used in match/case statements

-   `ExceptionKind`—categorizing the various kinds of exceptional event.
    `ExceptionKind` has methods `refine`, `raise`, `raise()with`,
    `match`, $|$, $\&$ and `parent`.

-   `Exception`—the type of a raised exception. `Exception` has methods
    `message`, `lineNumber`, `moduleName`, `backtrace`,
    `printBackTrace`, `data` and `exception`.

In addition, variables can be annotated as having type `Unknown`.
Unknown is not a type, but a label that the type system uses when
reasoning about the values of expressions. Parameters and variables that
lack explicit type annotations are implicitly annotated with type
`Unknown`.

Types {#ObjectTypes}
-----

Types define the interface of objects by detailing their public methods,
and the types of the arguments and results of those methods. Types can
also contain definitions of other types.

The various `Cat` object and class descriptions (see
§\[ObjectsAndClasses\]) would produce objects that conform to an object
type such as the following. Notice that the public methods implicitly
inherited from `Object` are implicitly included in all types.

    type {
        colour -> Colour
        name -> String
        miceEaten -> Number
        miceEaten:= (n : Number) -> Done
    }

For commonality with method declarations, parameters are normally named
in type declarations. These names are useful when writing specifications
of the methods. If a parameter name is omitted, it must be replaced by
an underscore. The type of a parameter may be omitted, in which case the
type is `Unknown`.

Type Declarations
-----------------

Types—and parameterized types—may be named in type declarations:

    type MyCatType = { color -> Colour; name -> String } 
       // I care only about names and colours

    type MyParametricType<A,B> = 
        where A <: Hashable,  B <: DisposableReference
      type {
        at (_:A) put (_:B) -> Boolean  
        cleanup(_:B)
      }

Notice that the `type` keyword may be omitted from the right-hand-side
of a type declaration when it is a simple type literal.

Grace has a single namespace: types live in the same namespace as
methods and variables.

    type MyParametricType = type <A,B>
     {
        at (_:A) put (_:B) -> Boolean  
        cleanup(_:B)
     }

Relationships between Types—Conformance Rules
---------------------------------------------

The key relation between types is **conformance**. We write <span>B $<:$
A</span> to mean B conforms to A; that is, that B has all of the methods
of A, and perhaps additional methods (and that the corresponding methods
have conforming signatures). This can also be read as “B is a subtype of
A”, “A is a supertype of B”.

We now define the conformance relation more rigorously. This section
draws heavily on the wording of the Modula-3 report @Modula3.

If <span>B $<:$ A</span>, then every object of type B is also an object
of type A. The converse does not apply.

If A and B are ground object types, then <span>B $<:$ A</span> iff for
every method m in A, there is a corresponding method $m$ (with the same
name) in B such that

-   The method $m$ in B must have the same number of arguments as $m$ in
    A, with the same distribution in multi-part method names.

-   If the method $m$ in A has signature “($P_1,...P_n$) `->` $R$”, and
    $m$ in B has signature “($Q_1,...Q_n$) `->` $S$”, then

    -   parameter types must be contravariant: <span>$P_i$ $<:$
        $Q_i$</span>

    -   results types must be covariant: <span>S $<:$ R</span>

If a class or object B inherits from another class A, then B’s type
should conform to A’s type. If A and B are parameterized classes, then
similar instantiatons of their types should conform.

The conformance relationship is used in `where` clauses to constrain
type parameters of classes and methods.

Variant Types
-------------

Variables with untagged, retained variant types, written
`T1 | T2 ... | Tn `, may refer to an object of any one of their
component types. No *objects* actually have variant types, only
expressions. The actual type of an object referred to by a variant
variable can be determined using that object’s reified type information.

The only methods that may be requested via a variant type are methods
with exactly the same declaration across all members of the variant.
(Option) methods with different signatures may be requested at the most
most specific argument types and least specific return type.

Variant types are retained as variants: they are *not* equivalent to the
object type that describes all common methods. This is so that the
exhaustiveness of match/case statements can be determined statically.
Thus the rules for conformance are more restrictive:

``` {mathescape="true"}
S <: S | T;   $~~~$  T <: S | T 
(S' <: S) & (T' <: T) $\Rightarrow$ (S' | T')  <: (S | T) 
```

To illustrates the limitations of variant types, suppose

    type S = {m: A -> B, n:C -> D}
    type T = {m: A -> B, k: E -> F}
    type U = {m: A -> B}

Then `U` fails to conform to `S | T` even though `U` contains all
methods continued in both `S` and `T`.

Intersection Types
------------------

An object conforms to an Intersection type, written
`T1 & T2 & ... & Tn`, if and only if that object conforms to all of the
component types. The main use of intersection types is for augmenting
types with new operations, and as as bounds on `where` clauses.

### Examples {#examples-29 .unnumbered}

    type List<T> = Sequence<T> & type {
        add(_:T) -> List<T>
        remove(_:T) -> List<T>
    }

    class happy.new<T>(param: T)
       where T <: (Comparable<T> & Printable & Happyable) {     
               ...
    }

Union Types
-----------

Structural union types (sum types), written `1 + `2 + ... + Tn\*, are
the dual of intersection types. A union type `T1 + T2` has the interface
common to `T1` and `T2`. Thus, a type `U` conforms to `T1 + T2` if it
has a method that conforms to each of the methods common to `T1` and
`T2`. Unions are mostly included for completeness: variant types subsume
most uses.

Type subtraction
----------------

A type subtraction, written `T1 - T2` has the interface of `T1` without
any of the methods in `T2`.

Singleton Types
---------------

The names of singleton objects, typically declared in object
declarations, may be used as types. Singleton types match only their
singleton object. Singleton types can be distinguished from other types
because Grace type declarations are statically typed.

    def null = object { 
        method isNull -> Boolean {return true} 
    }

    type Some<T> { 
        thing -> T 
        isNull -> Boolean
    }

    type Option<T> = Some<T> | null

Nested Types
------------

Type definitions may be nested inside other expressions, for example,
they may be defined inside object, class, method, and other type
definitions. Such types can be referred to using “dot” notation, written
`o.T`. This allows a type to be used as a specification module, and for
types to be imported from modules, since modules are objects.

Additional Types of Types
-------------------------

<span>option:</span> Grace may support exact types (written `=Type`)

<span>option:</span> Grace probably will probably not support Tuple
types, probably written `Tuple<T1, T2, ..., Tn>`.

<span>option:</span> Grace may support selftypes, written `Selftype`.

\[Tuples\]

Syntax for Types
----------------

This is very basic - but hopefully better than nothing!

    Type := GroundType | (Type ("|" | "&" | "+") Type) | "(" Type ")" 
    GroundType ::= BasicType | BasicType "<" Type ","... ">" | "Selftype"
    BasicType ::= TypeID | "=" TypeID  

Reified Type Information Metaobjects and Type Literals
------------------------------------------------------

(option) Types are represented by objects of type `Type` (Hmm, should be
`Type<T>`?). Since Grace has a single namespace, types can be accessed
by requesting their names.

To support anonymous type literals, types may be written in expressions:
`type Type`. This expression returns the type metaobject representing
the literal type.

Type Assertions
---------------

(option) Type assertions can be used to check conformance and equality
of types.

    assert {B <: A}  
       // B 'conforms to' A.
    assert {B <: {foo(_:C) -> D} }
       // B had better have a foo method from C returning D
    assert {B = A | C}

Notes
-----

1.  (**Sanity Check**) these rules

2.  What’s the relationship between “type members” across inheritance
    (and subtyping???). What are the rules on methods etc.

3.  On matching, How does destructuring match works? What’s the
    protocol? Who defines the extractor method? (not sure why this
    is here)

4.  can a type extend another type?

5.  Structural typing means we neither need nor want any variance
    annotations! Because Grace is structural, programmers can always
    write an (anonymous) structural type that gives just the interface
    they need—or such types could be stored in a library.

6.  ObjectTypes require formal parameter names & need to fix examples.
    §\[ObjectTypes\]?

7.  Tuples §\[Tuples\]. Syntax as a type? Literal Tuple Syntax?

8.  Nesting.

9.  Serialization

10. Include dialect description.

Pragmatics {#Pragmatics}
==========

The distribution medium for Grace programs, objects, and libraries is
Grace source code.

Grace source files should have the file extension `.grace`. If, for any
bizzare reason a trigraph extension is required, it should be `.grc`

Grace files may start with one or more lines beginning with “`#`”: these
lines are ignored.

Garbage Collection
------------------

Grace implementations should be garbage collected. Safepoints where GC
may occur are at any backwards branch and at any method request.

Grace will not support finalisation.

Concurrency and Memory Model
----------------------------

The core Grace specification does not describe a concurrent language.
Different concurrency models may be provided as dialects.

Grace does not provide overall sequential consistency. Rather, Grace
provides sequential consistency within a single thread. Across threads,
any value that is read has been written by some thread sometime—but
Grace does not provide any stronger guarantee for concurrent operations
that interfere.

Grace’s memory model should support efficient execution on architectures
with Total Store Ordering (TSO).

Libraries {#Libraries}
=========

Collections
-----------

Grace will support some collection classes.

Collections will be indexed `1..size` by default; bounds should be able
to be chosen when explicitly instantiating collection classes.

Acknowledgements {#acknowledgements .unnumbered}
================

Thanks to Josh Bloch, Cay Horstmann, Michael K<span>ö</span>lling, Doug
Lea, the participants at the Grace Design Workshops and the IFIP WG2.16
Programming Language Design for discussions about the language design.

Thanks to Michael Homer and Ewan Tempero for their comments on drafts.

The Scala language specification 2.8 @scala28 and the Newspeak language
specification 0.05 @newspeak005 were used as references for early
versions of this document. The design of Grace (so far!) has been
influenced by Algol @algolPerlis [@algolNaur], AmbientTalk @ambientTalk,
AspectJ @aspectJecoop, BCPL @BCPLBOOK [@cpl2bcpl], Beta @betabook, Blue
@BlueSIGCSE95 [@BlueSIGCSE96; @BlueSpec], C @Cbook, C$++$ @cppnotoo,
C$\sharp$ @Csharp3 [@Csharp4], Dylan @dylan, Eiffel @oosc [@eiffel],
Emerald @Black2007, $F_1$ @LucaTypeSystems, $F\sharp$ @fsharp, $FGJ$
@igarashi01, $FJ\vee$ @igarashi07, FORTRESS @fortress10b, gBeta
@fampoly, Haskell @haskellHistory, Java @mrBunny [@JavaConcur], Kevo
@anteroCloning, Lua @lua, Lisp @goodBadUgly, ML @ml, Modula-2 @Modula2,
Modula-3 @Modula3, Modular Smalltalk @ModularSmalltalk, Newspeak
@brachamodules [@newspeak005], Pascal @Pascal, Perl @perltalk, Racket
@HowToDesignPrograms, Scala @SCA [@scala28], Scheme @scheme, Self
@selfpower, Smalltalk @bluebook [@Ingalls81; @Budd1987; @strongtalk],
Object-Oriented Turing @OOTuring, Noney @malayeri08, and Whiteoak
@whiteoak08 at least: we apologise if we’ve missed any languages out.
All the good ideas come from these languages: the bad ideas are our
responsibility @HoareHints.

To Be Done
==========

As well as the large list in Section \[BigMissingFeatures\] of features
we haven’t started to design, this section lists details of the language
that remain to be done:

1.  specify full numeric types

2.  `Block::apply` §\[Blocks\]—How should we spell “apply”? “run”?

3.  confirm method lookup algorithm, in particular relation between
    lexical scope and inheritance (see §\[MethodReq\]) (“Out then Up”).
    Is that enough? Does the no-shadowing rule work? If it does, is this
    a problem?

4.  update grammar to incude “outer” §\[OuterRequests\].

5.  confirm rules on named method argument parenthesization
    §\[ArgParens\]

6.  how are (mutually) recursive names initialised?

7.  how should `case` work and how powerful should it be §\[Case\], see
    blog post 10/02/2011, Jon Boyland’s paper. How do type patterns
    interact with the static type system?

8.  support multiple factory methods for classes §\[Constructors\]

9.  `factory method`s.

10. where should we draw the lines between object constructor
    expressions/named object declarations, class declarations, and
    “hand-built” classes? §\[Inheritance\]

11. how do factories etc relate to “uninitialised” §\[Uninitialised\]

12. decide what to do about equality operators §\[Values\]

13. Support for enquiring about static type (`decltype` ?) and dynamic
    type (`dyntype` ?). Note that neither of these is a method request.

14. What is the type system?

15. Multiple Assignment §\[Assignment\]

16. Type assertions—should they just be normal assertions between types?
    so *e.g.*, $<:$ could be a normal operator between types.

17. Grace needs subclass compatibility rules

18. Brands Do we need them is a teaching language?

19. weak references

20. virtualise literals — numbers, strings,

21. Do we want a built-in sequence constructor, or tuple constructor?

22. design option — generalised requests, that is, requests with 0 or
    more repeating parts like *elseif*

Grammar {#Grammar}
=======

grammar.tex

[^1]: However, implementors should pickle the stack frames that are
    terminated when an exception is raised, so that they can be used in
    the error reporting machinery (debugger, stack trace)
