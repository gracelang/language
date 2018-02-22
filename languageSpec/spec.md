---
author:
- 'Andrew P. Black'
- 'Kim B. Bruce'
- 'James Noble'

bibliography:
- 'spec.bib'

title:
    The Grace Programming Language\
    Draft Specification Version 0.7.7
...


# Introduction

This is a specification of the Grace Programming Language. This
specification is notably incomplete, and everything is subject to
change. In particular, this version does *not* address:

-   static type system

-   immutable data and pure methods.

-   reflection

-   assertions, data-structure invariants, pre- & post-conditions, and
    contracts
-   concurrency

-   libraries and dialects, including implementations of Number, and

-   testing.

Many of the expressions and commands in Grace are actually defined in the
Grace standard prelude (and hence may not be supported in all dialects).
Because some of these constructs are used in the examples in this document,
we urge you to have a copy of the documentation for the standard prelude
at hand when reading this document.  It should be available in the same
directory where this document was found.

# User Model

------------------------------------------------------------------------

> *All designers in fact have user and use models consciously or
> subconsciously in mind as they work. Team design … requires explicit
> models and assumptions.*
>
> Frederick P. Brooks, *The Design of Design*.

------------------------------------------------------------------------

Grace has been designed with the following users in mind.

1.  First year university students learning programming in CS1 and CS2
    courses that use object-oriented programming.

    -  The courses may be structured objects first, or
        procedures first.

    -  The courses may be taught using dynamic types, static types, or
        both in combination (in either order).

    -  Grace offers some (but not necessarily complete) support for
        “functional first” curricula, primarily for courses that proceed
        rapidly to procedural and object-oriented programming.

2.  University students taking second year classes in programming,
    algorithms and data structures, concurrent programming, software
    craft, and software design.

3.  Faculty and teaching assistants developing libraries, frameworks,
    examples, problems and solutions, for the above courses.

4.  Programming language researchers needing a contemporary
    object-oriented programming language as a research vehicle.

5.  Designers of other programming or scripting languages in search of a
    good example of contemporary OO language design.


# Syntax

------------------------------------------------------------------------

> *Much of the following text assumes the reader has a minimal grasp of
> computer terminology and a “feeling” for the structure of a program.*
>
> Jensen and Wirth, *Pascal: User Manual and Report*.

------------------------------------------------------------------------

Grace programs are written in Unicode. Reserved words are written in the
ASCII subset of Unicode.

## Character Equivalencies

The following ASCII sequences are treated as equivalent to the corresponding Unicode characters everywhere except in strings.

| ASCII | Unicode         | Codepoint
| :---: | :-----:         | :-------:
| >=    | $\geq$		      | U+2265
| <=    | $\leq$          | U+2264
| !=    | $\neq$          | U+2260
| ->    | $\rightarrow$	   | U+2192
| ]]    | $\rrbracket$	   | U+27E7
| [[    | $\llbracket$	   | U+27E6


## Layout

Grace uses braces to indicate the boundaries of code blocks.
Code layout must be consistent with
these boundaries: indentation must increase after a left brace.

Statements are terminated by line breaks when the
following line has the same or lesser indentation than the indentation
of the line containing the start of the current statement.
Statements may optionally be terminated by semicolons.

All changes in indentation must be by *two* or more spaces; a change of a single
space is always treated as an error.

**Example code with punctuation**

    def x =
       mumble "3"
       fratz 7;
    while {stream.hasNext} do {
       print(stream.read);
    };

**Example code without punctuation**

    def x =
       mumble "3"
       fratz 7
    while {stream.hasNext} do {
       print(stream.read)
    }

This example defines `x` to be the result of the single request `mumble ("3") fratz (7)`.
Because the second and third lines are indented more than the first, they continue that line.

## Comments

Comments start with a pair of slashes `//` and are terminated by
the end of the line. Comments are *not* treated as
white-space. Each comment is conceptually attached to the smallest
immediately preceding syntactic unit, except that comments following a
blank line are attached to the largest immediately following syntactic
unit.

**Example**


    // comment, to end of line

## Identifiers and Operators

Identifiers must begin with a letter, which is followed by a sequence of
zero or more letters, digits, prime (`'`) or underscore (`_`)
characters.  Conventionally, type and pattern identifiers start with capital
letters, while other identifiers start with lower-case letters.

A identifier comprising a single underscore `_` acts as a placeholder: it can
appear in declarations, but not in expressions. In declarations, `_` is
treated as a fresh identifier.

Operators are sequences of [unicode mathematical operator symbols](
https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode)
and the following ASCII operator characters:

`! ? @ # % ^ & | ~ = + - * / \ > < : . ` $\$\,$

## Reserved Tokens

Grace has the following reserved tokens:

    alias as class def dialect exclude import inherit interface is method
    object outer prefix required return self Self trait type use var where
    . ... := = ; { } [ ] ( ) : -> $\rightarrow$ // [[  ]] $\llbracket$ $\rrbracket$


## Newlines, Tabs and Control Characters

Newline in Grace programs can be represented by the Unicode line feed (LF) character, by the
Unicode carriage return
(CR) character, or by the Unicode line separator
(U+2028) character; a line feed that immediately
follows a carriage return is ignored.

Tabs and all other non-printing control characters are syntax errors,
even in a string literal. Escape sequences are provided to denote
control characters in strings; see [the Table of String Escapes](#strings).

# Built-in Objects

## Done

Assignments, and methods without an explicit result, have the value
`done`, of type `Done`. The type `Done` plays a role similar to *void*
or *Unit* in other languages. The only requests understood by `done` are
`asString` and `asDebugString`; in particular, `done` does not have an
equality method.

## Ellipsis

The token `...` is a valid expression, but evaluating it will lead to a runtime error.
It is included in the language so that programmers can indicate that their code is
incomplete.

## Numbers

In Grace, numbers are objects. Grace supports a single type `Number`,
which accommodates at least 64-bit
precision floats. Implementations may support other classes
of numbers, and may define types that extend `Number`; a
full specification of numeric types is yet to be completed.

Grace has three forms of numerals (that is, literals that
denote `Number` objects).  

1.  Decimal numerals, written as strings of digits.

2.  Base-exponent numerals, always in decimal, which contain a decimal
    point, or an exponent, or both. Grace uses `e` as the
    exponent indicator. Base-exponent numerals may have a minus in front of the _exponent_.  A decimal point, if present, must not be
    the first or last character of the numeral

3.  Explicit radix numerals, written as a (decimal) number between 2 and
    35 representing the radix, a leading `x`, and a string of digits,
    where the digits from 10 to 35 are represented by the letters A to
    Z, in either upper or lower case. A radix of 0 is taken to mean a
    radix of 16.

**Examples**


    1
    42
    3.14159265
    0.25    // leading 0 is required
    17.0    // the trailing 0 is required because of the decimal point
    17      // same as the above
    13.343e-12
    414.45e3
    16xF00F00
    2x10110100
    0xdeadbeef // Radix zero treated as 16

Note that there are no numerals for negative numbers;
negative numbers can be generated by requesting the 
prefix `-` operator on a positive number.

**Examples**


    -1
    -2e4

## Booleans

The predefined constants `true` and `false` denote values of Grace’s
`Boolean` type. Boolean operators are written using `&&` for and, `||`
for or, and prefix `!` for not.

**Examples**


    p && q
    toBe || toBe.not

In addition to `&&` and `||` taking boolean arguments, they also accept
parameterless blocks that return `Boolean`.  This gives them
“short circuit” (a.k.a. "non-commutative") semantics.

**Examples**


    p && { q }
    toBe || { ! toBe }


## Strings

### String Literals

String literals in Grace are written between double quotes, and must
be confined to a single line. Strings literals support a range of
escape characters;
these are listed in the table below.

Individual characters
are represented by strings of length 1. Strings are immutable, so an implementation may intern them. Grace’s standard
library supports efficient incremental string construction.

|Escape |  Meaning |  Unicode |
|:------|:------   |:------|
|    `\\`    | backslash      | U+005C |
|    `\n`     | line-feed      | U+000A |
|    `\t`     | tab            | U+0009 |
|    `\{`     | left brace     | U+007B |
|    `\}`     | right brace    | U+007D |
|    `\"`   | double quote   | U+0022 |
|   `\r`             | carriage return      | U+000D       |
|   `\l`            | line separator       | U+2028       |
|   `\_`            | non-breaking space   | U+00A0       |
|   `\uhhhh`       | 4-digit Unicode      | U+hhhh     |
|   `\Uhhhhhh`     | 6-digit Unicode      | U+hhhhhh   |


**Examples**


    "Hello World!"
    "\t"
    "The End of the Line\n"
    "A"

### String Constructors

String Constructors are a generalization of [String Literals](#string-literals) that contain expressions enclosed in braces.
The value of a String Constructor is obtained by first evaluating any
expressions inside braces, requesting `asString` of the resulting object,
and inserting the resulting string into the string literal in place of the
brace expression.

**Example**


    "Adding {a} to {b} gives {a+b}"

### Uninterpreted Strings

String literals can also be written between single guillemet quotation marks,
‹thus›.  Between the ‹ and the ›, characters from the input become characters of
the string value without interpretation, and without any escapes (not even for ›).

**Example**

    lexer.lex ‹// This is input for a test of the lexer.
    // The input ends with a newline.
    def s = "This is a String"
    def n = 17
    ›

## Lineups

A Lineup is a comma separated list of expressions surrounded by `[` and `]`.

**Examples**


    [ ]        //empty lineup
    [ 1 ]
    [ red, green, blue ]

When executed, a lineup returns an object that supports the `Iterator` interface,
which includes the methods `size`, `map`, `do(_)`, and `iterator`.
Lineups are most frequently used to build collections, to control loops,
and to pass collections of options to methods.

**Examples**


    set [ 1, 2, 4, 5 ]           //make a set
    sequence [ "a", "b", "c" ]   //make a sequence
    ["a", "e", "i", "o", "u"].do { x -> testletter(x) }
    myWindow.addWidgets [
       title "Launch",
       text "Good Morning, Mrs President",
       button "OK" action { missiles.launch },
       button "Cancel" action { missiles.abort }
    ]

## Blocks

Grace blocks are lambda expressions, with or without
parameters. If a parameter list is present, the parameters are separated
by commas and the list is separated from the body of the block by the `->` symbol.
Within the body of the block, the parameters cannot be assigned.
Block parameters may optionally be annotated with types; omitted type
annotations are treated as the type `Unknown`.

    { do.something }
    { i -> i + 1 }
    { i:Number -> i + 1 }
    { sum, next -> sum + next }

Blocks are lexically scoped, and can close over any visible field or parameter.
The body of a block consists of a sequence of declarations and
expressions; declarations are local to the block.
An empty body is allowed, and is equivalent to `done`.
A `return` statement inside a block returns from the enclosing method.

Blocks construct objects containing a method named `apply`, or
`apply(n)`, or `apply(n, m)`, …, where the number of parameters to `apply`
is the same as the number of parameters of the block. Requesting the
`apply(...)` method evaluates the block; it is an error to provide the wrong
number of arguments.
It is a `TypeError` if an argument to `apply(...)` does not match
the types annotation of the corresponding parameter.

**Examples**


The looping construct

    for (1..10) do {
        i -> print i
    }

might be implemented as a method with a block parameter

    method for (collection) do (block) {
        def stream = collection.iterator
        while {stream.hasNext} do {
            block.apply(stream.next)
        }
    }

Here is another example:

    var sum := 0
    def summingBlock: Block1⟦Number, Number⟧ =
        { i: Number ->  sum := sum + i }
    summingBlock.apply(4)       // sum now 4
    summingBlock.apply(32)      // sum now 36


# Declarations

Declarations may occur anywhere within a module, object, class,
or trait.  Field declarations may also occur within a
method or block body.  Declarations are visible within the *whole* of
their containing lexical scope.  It is an error to declare
any name more than once in a given lexical scope.

Grace has a single namespace for all identifiers: methods, parameters,
constants, variables, classes, traits, and types. It is a *shadowing error*
to declare a parameter (but not a method or field) that has the same name as a
lexically-enclosing field, method, or parameter.

## Fields

Grace has two kinds of fields: [constants](#constants) and [variables](#variables).

### Constants

Constants are defined with the **`def`** keyword; they bind
an identifier to the value of an initialising expression, and may
optionally be annotated with a type.  This type is checked when
the constant is initialised. Constants cannot be re-bound.

An omitted type annotation is treated as the type `Unknown`.

**Examples**


    def x = 3 * 100 * 0.01
    def x:Number = 3
    def x:Number           // Syntax Error: x must be initialised

### Variables

Variable are introduced with the **`var`** keyword.
Variables can be re-bound to
new values as often as desired, using an assignment.
A variable declaration may optionally provide an initial value; if there is
no initial value, the variable is *uninitialised* until it is assigned.
Any attempt to access the value of an uninitialised
variable is an error, which may be caught either at run time or at
compile time.
Variables may be optionally given a type: this type is checked when
the variable is initialised and assigned.
An omitted type annotation is treated as the type `Unknown`.

**Examples**


    var x:Rational := 3     // explicit type
    var x:Rational          // x must be initialised before access
    var x := 3              // x has type Unknown
    var x                   // x has type Unknown, value is uninitialised

## Methods

Methods are declared using the **`method`** keyword followed by a name.
Methods define the action to be taken when the object containing the
method receives a
request with the given name. Because every method must be associated
with an object, methods may not be declared directly inside other
methods.  The body of the method is enclosed in braces.

The type of the object returned from the method may
optionally be given after the symbol `->`;
an omitted type annotation is treated as the type `Unknown`.
When the method returns, its result is checked against this type.  

    method pi  { 3.141592634 }

    method greet(user: Person) from(sender: Person) {
        print "{sender} sends his greetings, {user}."
    }

    method either (a) or (b) -> Done {
        if (random.nextBoolean)
            then {a.apply} else {b.apply}
    }


### Method Names

To improve readability, method names have several forms.
For each form, we describe its appearance,
and also a _canonical_ form of the name which is used in dispatching method requests.
A request "matches" a method if the canonical names are equal.

1. A method can be named by a single identifier, in which case the method
	has no parameters; in this case the _canonical name_ of the method is
	the identifier.

1. A method can be named by a single identifier suffixed with `:=`; such a method is called an assignment method, and is conventionally used for writer methods, both
	user-written and automatically-generated.
    Assignment methods _always_ take a single parameter after the `:=`, and have a _canonical name_ of  the identifier followed by `:=(_)`.
    It is an error to declare a variable and an assignment method with the same identifier in the same scope.

1. A method can be named by one or more _parts_, where each _part_ is an identifier
	followed by a parenthesized list of parameters.
	In this case
	the  _canonical name_ of the method is a sequence of parts, where
	each part comprises the identifier for that part followed by `(_, ..., _)`,
	the number of underscores between the parentheses being the number of
	parameters of the part.

2. A method can be named by a sequence of operator symbols.
	Such an "operator method" can be a _unary operator_, which has no parameters, and which is requested by a prefix operator expression.
	It can also be a _binary method_, which has one parameter, in which
	case it is requested by a binary operator expression.  The canonical name of a
	unary method is **`prefix`** followed by the sequence of operator symbols; the canonical
	name of a binary method is the sequence of operator symbols followed by `(_)`
	

**Examples**
 of single identifiers

```
method ping { print "PING!" }
method isEmpty { elements.size == 0 }
```

**Example**
 of an assignment method

```
method value:= (n: Number) -> Done {
    print "value currently {value}, now assigned {n}"
    outer.value:= n
}
```
This declares a method with canonical name `value:=(_)`;
such a method cannot be declared in the same scope as a
variable `value`.
	
**Examples**
 of multi-part names

    method drawLineFromOriginTo (destination)
    method drawLineFrom (source) to (destination)
    method max(v1, v2)

In the first two examples, the canonical names of the methods are
`drawLineFromOriginTo(_)`, and `drawLineFrom(_)to(_)`.  The latter
comprises two parts: `drawLineFrom(_)` and `to(_)`.
In the third example, the canonical name of the method is `max(_,_)`.
	
**Examples**
 of operator symbols

```
    method + (other:Point) -> Point {
        (x + other.x) @ (y + other.y)
    }

    method prefix- -> Point
        { 0 - self }
```

As a consequence of the above rules, methods `max(a, b, c)` and
`max(a, b)` have different canonical names and are therefore treated
as distinct methods.  In other words, Grace allows "overloading by
arity". (Grace does _not_ allow overloading by type).

### Parameters

Depending on their syntactic form, method declarations may include one
or more lists of parameters. Inside method bodies, parameters are
treated as [constants](#constants): they may not be reassigned.
Parameters to a method may optionally be annotated with types:
the corresponding arguments will be
checked against those types, either before execution, or
when the method is requested.  
An omitted type annotation is treated as the type `Unknown`.

### Type Parameters

Methods may be declared with one or more type parameters.
If present, type parameters are listed between $\llbracket$
and $\rrbracket$ after the identifier that forms the first
(or only) part of a multipart name.

Type parameters may be constrained with `where` clauses;
the details have yet to be specified.

The presence or absence of type parameters does not change the
canonical name of the method.

**Examples**


    method sumSq⟦T⟧(a:T, b:T) -> T where T <: Numeric {
        (a * a) + (b * b)
    }

    method prefix- ⟦T⟧ -> Number
         { 0 - self }


### Returning a Value from a Method

Methods may contain one or more **`return`** statements.
If a `return e` statement is executed, the method terminates with the
value of the expression `e`, while a `return` statement with no
expression is equivalent to `return done`.  If execution reaches
the end of the method body without executing a `return`, the method
terminates and returns the value of the last expression evaluated.
An empty method body returns `done`.

## Annotations

Any declaration, and any object constructor, may have a
comma-separated list of annotations following the keyword **`is`**
before its body or initialiser. Grace defines the following core
annotations:

| Annotation | Semantics |
|:-----      |:--------------------------------------------|
| `confidential` | method may be requested only on self or outer — see [Encapsulation](#encapsulation) |
| `manifest` | method must return a manifest object - see [Manifest Expressions](#manifest-expressions) |
| `overrides` | method must override another method - see [Overriding Methods] |
| `public` | method may be requested from anywhere |
| |  field can be read and written from anywhere - see [Encapsulation](#encapsulation) |
| `readable`  | field may be read from anywhere - see [Encapsulation](#encapsulation) |
| `writeable` | variable field may be written from anywhere - see [Encapsulation](#encapsulation) |

Additional annotations may be defined by dialect or libraries.

**Examples**


    var x is readable, writeable := 3
    def y: Number is public
    method foo is confidential  { }
    method id⟦T⟧ is required  { }


## Encapsulation

Grace has different default encapsulation rules for methods, types, and
fields. The defaults can be changed by explicit annotations. The details
are as follows.

### Public

Public attributes can be requested by any client that has access to the
object that defines them.

### Confidential

Confidential attributes can be requested
only on `self` or on some number of cascaded `outer`s, or in an implicit request (which must resolve to one of the former cases).
Consequently, if _m_ is
defined in the object, class, or trait _d_, it
is accessible to _d_, to objects that inherit from _d_, and to objects lexically enclosed by _d_, but not to clients of _d_.

### Methods, Classes, Traits and Types

By default, methods (which category includes classes and traits), and types, are public.
If a method or type is annotated `is confidential`, it is confidential.

### Fields

Variables and definitions (`var` and `def` declarations) immediately
inside an object constructor create *fields* in that object.

A field declared as `var x` can be read using the request `x` and
assigned to using the assignment request `x:=(...)`.
A field declared as `def y` can be read using the request `y`, and
cannot be assigned. By default, fields are *confidential*.

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
method with the same name, and cannot have a method `x:=(_)`
as well as a `var` field named `x`.

**Examples**


    object {
        def a = 1                  // Confidential access to a
        def b is public = 2        // Public access to b
        def c is readable = 2      // Public access to c
        var d := 3                 // Confidential access and assignment
        var e is readable          // Public access and confidential assignment
        var f is writable          // Confidential access, public assignment
        var g is public            // Public access and assignment
        var h is readable, writable    // Public access and assignment
    }

### No Private Attributes

Some other languages support “private attributes”, which are available only
to an object itself, and not to clients or inheritors. Grace does not
have private fields or methods; all can be accessed from subobjects.
However, identifiers from outer scopes can be used to obtain an effect similar to privacy.

**Example simulating private fields**


    method newShipStartingAt (s:Point) endingAt (e:Point) {
        // returns a battleship object extending from s to e.  This object cannot
        // be asked its size, or its location, or how much floatation remains.
        assert ( (s.x == e.x) || (s.y == e.y) )
        def size = s.distanceTo(e)
        var floatation := size
        object {
            method isHitAt(shot:Point) {
                if (shot.onLineFrom (s) to (e)) then {
                    floatation := floatation - 1
                    if (floatation == 0) then { self.sink }
                    true
                } else { false }
            }
            ...
        }
    }

The object returned by `newShipStartingAt(_)endingAt(_)` can update the variable
`floatation` in the surrounding scope, even though it is not
accessible to anything inheriting from that object.
Notice also how the coordinates of the ship `s` and `e` are also inaccessible.

# Objects, Classes, and Traits

Grace **`object`** constructors generate
individual objects.
Grace **`class`** declarations define methods that generate objects,
all of which have the same structure.

The design of Grace's reuse mechanism is complete, but tentative. We need
experience before confirming the design.

## Objects

Object constructors are expressions that evaluate to an object with the
given attributes. Each time an object constructor is executed, a new object
is created. In addition to declarations of types, fields and methods, object
constructors can also contain expressions (executable code at the top level),
which are executed as a
side-effect of evaluating the object constructor. All of the declared
attributes of the object are in scope throughout the object constructor.

**Examples**


    object {
        def colour:Colour = colours.tabby
        def name:String = "Unnamed"
        var miceEaten := 0
        method eatMouse { miceEaten := miceEaten + 1 }
    }

Like everything in Grace, object constructors are lexically scoped.

A name can be bound to an object constructor, like this:

    def unnamedCat = object {
         def colour:Colour = colours.tabby
         def name:String = "Unnamed"
         var miceEaten := 0
         method eatMouse { miceEaten := miceEaten + 1 }
    }


## Class Declarations

A class is a method whose body is treated as an object constructor that is
executed every time the class is invoked. The class
returns the newly-created object.  For example,

    class catColoured(c) named (n) {
        def colour is public = c
        def name is public = n
        var miceEaten is readable := 0
        method eatMouse {miceEaten := miceEaten + 1}
        print "The cat {n} has been created."
    }

is equivalent to

    method catColoured(c) named (n) {
        object {
            inherit graceObject
            def colour is public = c
            def name is public = n
            var miceEaten is readable := 0
            method eatMouse {miceEaten := miceEaten + 1}
            print "The cat {n} has been created."
        }
    }

This class might be used as follows:

    def fergus = catColoured (colours.tortoiseshell) named "Fergus"

This creates an object with fields `colour` (set to
`colours.tortoiseshell`), `name` (set to `"Fergus"`), and `miceEaten`
(initialised to `0`), prints “The cat Fergus has been created”, and
binds the name `fergus` to this object.

## Trait Objects and Trait Declarations

Trait objects are objects with certain properties.  Specifically, a
trait object is created by an object constructor that directly contains no
field declarations, `inherit` statements, or executable code.
A trait can `use` other traits.
Methods in a trait can capture variables in the lexical scope of the trait,
so that they can have what is effectively private state, as illustrated in the [Section on private attributes](#no-private-attributes).
Note that a trait can contain types, traits, and classes; these classes _can_ contain field declarations, and can inherit.


Aside from these restrictions, Grace's **trait** syntax and semantics is parallel to the class syntax.
In particular, a `trait` defines a method that returns a trait object.
Hence, the following two declarations create equivalent traits:

**Examples**

    trait emptiness1 {
        method isEmpty { size == 0 }
        method nonEmpty { size != 0 }
        method ifEmptyDo (eAction) nonEmptyDo (nAction) {
                if (isEmpty) then { eAction.apply } else { do(nAction) }
        }
    }

    method emptiness2 {
        object {
            method isEmpty { size == 0 }
            method nonEmpty { size != 0 }
            method ifEmptyDo (eAction) nonEmptyDo (nAction) {
                    if (isEmpty) then { eAction.apply } else { do(nAction) }
            }
        }
    }

The advantage of `emptiness1` is that it makes the programmer's intention clearer.
Moreover, if a field or an inherit statement were inadvertently added to `emptiness1`, the implementation would immediately complain.
With the second form, the error would be found only when `emptiness2` is `use`d.

## Type Parameters

Like methods, classes and traits may be declared with type
parameters, and requests on the class or trait may optionally be provided
with type arguments.


**Example**

    class vectorOfSize(size)⟦T⟧ {
        var contents := Array.size(size)
        method at(index: Number) -> T { return contents.at(index) }
        method at(index: Number) put(elem: T) { ... }
    }

    class sortedVectorOfSize(size)⟦T⟧
        where T <: Comparable⟦T⟧ {
          ...
    }

## Reuse

Grace supports reuse in two ways: through **`inherit`**
statements and through **`use`** statements.
Object constructors (including classes and modules) can contain one `inherit` statement,
while traits cannot contain an `inherit` statement;  object
constructors, classes, modules and traits can all contain one or more `use` statements.

Both `inherit` and `use` introduce the attributes of a reused object —
called the _parent_ — into the current object (the object under
construction).  There are two differences between `inherit` and `use`
clauses:

  1. the object reused by a `use` clause must be a trait object; and
  2. `inherit` clauses include methods in the parent that originated in `graceObject`,
while `use` clauses do not.

The `superExpr` in an `inherit` or `use` clause must be a 
[Manifest Expression](#manifest-expressions)
that creates a new object; usually this will be a request on a class or trait.
The `superExpr` cannot depend on `self`, implicitly or
explicitly.
The reason that the `superExpr` must be manifest is to ensure that
it cannot be overriden, and thus that the names of the attributes obtained from the
parent can be determined staticaly and locally.
Note that the arguments to a [Manifest Expression](#manifest-expressions)
need not themselves be manifest.

If it is necessary for the current object to access an overridden attribute
of a parent, the overridden
attribute can be given an additional name by attaching
an **`alias`** clause to the inherit or use statement: `alias new(_) = old(_)`
creates a new `confidential` _alias_ `new(_)` for the attribute `old(_)`.
It is a _object composition error_ to alias an attribute to its own name.
Attributes of the parent that are not wanted can be excluded using
an **`exclude`** clause.
It is an _object composition error_ to alias or exclude attributes
that are not present in the class or trait being inherited.

When a reuse statement has both alias and exclude clauses, the set of attributes that is introduced by the reuse statement is determined as follows.

 * The set contains all the attributes of the _parent_, except for those that appear in an exclude clause (and, in the case of a `use` statement, except for the attributes obtained from `graceObject`).
 * The set contains all of the new method names introduced by the alias clauses.
    Each of these names is bound to the attribute to which the old method name is bound in the _parent_.

The order of the alias and exclude clauses is irrelevant.

** Examples **

```
trait t1 {
    method x { ... }
    method y { ... }
}

class c1 {
    use t1 alias w = y exclude x
    method v { ... }
}
```
Objects generated by `c1` have attributes `v`, `w` and `y`, but not `x`

```
trait t1 {
    method x { ... }
    method y { ... }
}

class c1 {
    use t1 alias w = y exclude x
    method w { ... }
}
```
This is a trait composition error, because `c1` gets `w` from two places: an alias clause, and a method definition.

```
trait t1 {
    method x { ... }
    method y { ... }
}

class c1 {
    use t1 alias x = y
    method y is override { ... }
    method w { ... }
}
```
This is also a trait composition error, because `x` is defined twice: in `t1`, and in the alias clause. This can be corrected by excluding `x` from `t1`.

### Object Combination and Initialisation

When executed, an object constructor (or trait or class declaration)
first creates a new object with no attributes, and binds it to `self`.

Second, the attributes of the superobject (created by the `inherit`
clause, possibly modified by `alias` and `exclude`) are installed in the new
object.  Fields (`def`s and `vars`s) thus installed are uninitialised.

Third, the methods of all traits
(created by `use`
clauses, possibly modified by `alias` and `exclude`, and
excluding those methods inherited unchanged from `graceObject`) are
combined.
It is an _object composition error_ for there to be multiple
definitions of a method.
This combination of methods is then
installed in the new
object: methods in the trait combination override declarations in the
superobject.

Fourth, attributes create by local declarations are installed in the
new object: local declarations
override declarations from both superobject and
traits, except that
it is an _object composition error_ for an alias to be
overridden by a local declaration. 
The term "local declarations" comprises declarations of
methods, types and fields (both `def`s and `vars`s).

Finally, field initializers and executable statements are executed,
starting with the most superior inherited superobject, and finishing with the
initializers of local fields, and local statements.
(Note that _used_ objects must be traits, and therefore contain no executable code.)
Initialisers for all `def`s and `var`s,
and code in the bodies of parents,
are executed once in the order they are written, even for `def`s or
`var`s that are excluded from the new object, or aliased to one or
more new names.
During initialisation, `self` is bound to the new object being
created, even while executing code and initialisers of parents.

As a consequence of these rules, a new object can change the
initialization of its parents, by overriding a method requested on self
by the parents' initialisers.


### Required Methods

Methods may be declared to be *required* by giving them the body `required`.
(Required methods are similar to what some other languages call abstract methods.)
This indicates that a real method
body must be supplied before that method can be requested.
Required methods do _not_ conflict with other methods.
In particular, a required local
method does not override a method from a parent; instead the parent is
said to supply the requirement.  Similarly, a method required by a used trait
can be supplied by another used trait without any conflict.

Requesting a required method that has not been supplied will generate an error.

### Overriding Methods

A new declaration in the current object overrides a declaration
from a parent.
Methods may be annotated with `override`. A method so annotated must
override a method from its parent with the same canonical name.
The `override` annotation is optional: local methods override parents' methods
with or without the `override` annotation.  Dialects may require the annotation.

**Examples**


The example below shows how a class can use a method to override an
accessor method for an inherited variable.

    class pedigreeCatColoured (aColour) named (aName) {
        inherit catColoured (aColour) named (aName)
        var prizes := 0
        method miceEaten is override { 0 }
                // a pedigree cat would never be so coarse
        method miceEaten:= (n:Number) -> Number is override { return }
               // ignore attempts to debase it
    }

Traits are designed to be used as fine-grained components of reuse:

    trait feline {
        method independent { "I did it my way" }
        method move {
            if (isOut) then {
                comeIn
            } else {
                goOut
            }
        }
    }

    trait canine {
        method loyal { "I'm your best friend" }
        method move {
            if (you.location != self.location) then {
                self.position := you.heel
            }
        }
    }

In this context, the following object has a trait conflict:

    object {
        use feline alias catMove = move
        use canine alias dogMove = move
    }

because the `move` attribute is defined in two separate traits.
In contrast, the following definition is legal:

    def nyssa = object {
        use feline alias catMove = move
        use canine alias dogMove = move
        method move {
            if (random.choice) then {
                catMove
            } else {
                dogMove
            }
        }
    }

Here, the
conflict is resolved by overriding with a local `move` method.  This method
accesses the overridden methods from the parent traits using the aliases `catMove`
and `dogMove`; as a result, `nyssa` will `move` either like a dog or a cat, depending on
a random variable.

### Overriding Types

If a type declared in the current object has the same name as a type declared 
in a parent, the two types must be _identical_.

### Default Methods

All objects implement a number of _default methods_ by inheriting from
`graceObject`.
Programmers can
override these implementations with alternative implementations.
Type [Object](#type-object) contains all the public
default methods.


|  Method                            |    Return value                                           |
| :-----------------------------------------------  | :------------------------------------------- |
| `isMe (other:Object) → Boolean`; _confidential_  |    true if other is the same object as self |
| $\neq$ `(other:Object) → Boolean`|    the inverse of ==                                 |
| `asString → String`               |    a string describing self                          |
| `asDebugString → String`          |    a string describing the internals of self         |
| `:: (other:Object) → Binding`     |  a Binding object with `self` as key and `other` as value|


Notice that `graceObject` implements $\neq$ but not `==`.
This is to help ensure that, when an object chooses to implement `==`,
$\neq$ is also available, and is the inverse of `==`.
If desired, the _confidential_ method `isMe` can be used in the implementation of a
public `==` method.

# Method Requests

Grace is a pure object-oriented language.
All computation proceeds by _requesting_ an
object — the target of the request — to execute a method with a
particular *name*. The response of the target is to execute the
method, and to answer the return value of the method.

Grace distinguishes the act of *requesting* a method (what Smalltalk calls
“sending a message”), and *executing* that method. Requesting a method
happens outside the target object, and involves only a
reference to the target, the method name, and possibly some arguments.
In contrast, executing the method involves the code of the method, which
is internal to the target.


## Self

The reserved word **`self`** refers to the current object.
Inside a method, self always refers to the target of the method-request
that caused the method to execute.
Elsewhere, **`self`** refers to
the object being constructed by the lexically-innermost module,
object constructor, class or trait surrounding the word **`self`**
Hence, the expression `self.x` requests `x` on the current object.

The reserved word **`Self`** refers to the type of the current object.


**Examples**


      self
      self.value
      self.bar(1,2,6)
      self.doThis(3) timesTo("foo")
      self + 1
      ! self

## Outer

The reserved word **`outer`** refers to the object lexically enclosing
the current object.  The expression `outer.x` requests `x` on the object lexically
enclosing `self`.

**Examples**


      outer
      outer.outer.outer.outer
      outer.value
      outer.bar(1,2,6)
      outer.outer.doThis(3) timesTo("foo")
      outer + 1
      ! outer

## Named Requests

A named method request comprises a _receiver_,
followed by a dot **`.`**, followed by a
method name, wherein the parameters have been replaced by expressions that
evaluate to the method's arguments.
Note that a request without arguments does not contain any parentheses.

The _receiver_ is an expression; when evaluated it designates the
_target_ of the request.
The name of a method, which determines
the position of the argument lists within that name, is chosen when
the method is declared ([See Methods](#methods)).
When reading a request of a multi-part method
name, you should continue accumulating words and argument lists as far
to the right as possible.

Unlike some other languages, Grace does _not_ allow the overloading of
method names by type:  the type of the arguments supplied to the request does
not influence the method being requested.  However, the _number_ of arguments
in a list does determine the method being requested.

**Examples**

        self.clear
        self.drawLineFrom (p1) to (p2)
        self.drawLineFrom (origin) length (9) angle (pi/6)
        self.movePenTo (x, y)
        self.movePenTo (p)


### Delimited Arguments

Parenthesis may be omitted where they would enclose a single argument
that is a numeral, string, lineup, or block.

**Examples**


        self.drawLineFrom (p1) to (p2)
        self.drawLineFrom (origin) length 9 angle (pi/6)
        print "Hello World"
        while {x < 10} then {
            print [a, x, b]
            x := x + 1
        }


### Implicit Requests

If the receiver of a named method request using the name _m_ is `self` or
`outer` it may be left implicit, _i.e._, the `self` or `outer` and the
dot may both be omitted.
Implicit requests are interpreted as a `self` request, or as an
`outer` request, or as an `outer.outer. ...` request with the appropriate number of `outer`s.

When resolving an implicit request, the usual rules of lexical scoping apply,
so a definition of _m_ in
the current scope will take precedence over any definitions in enclosing scopes.
However, if _m_ is defined in the current scope by inheritance or trait use,
rather than directly, and *also* defined directly in an enclosing scope, then
an implicit request of _m_ is ambiguous and is an error.

Implicit requests are always resolved lexically, that is, in the scope in which
the implicit request is written, and
not within the scope of any object (class, or trait) that may inherit the
method containing the implicit request.

**Examples of Implicit Requests**

    print "Hello world"
    size
    canvas

**Example of Implicit Request Resolution**

    method foo { print "outer" }

    class app {
      method barf { foo }
    }

    class bar {
      inherit app
      method foo { print "bar" }
    }

    class baz {
      inherit bar
      method barf { foo }   // ambiguous - could be self.foo or outer.foo
    }


    app.barf  // prints "outer"
    bar.barf  // prints "outer"

## Assignment Requests

An assignment request is a variable followed by `:=`, or a request
of a method whose name ends with `:=`. In both cases the `:=` is
followed by a single argument, which need not be surrounded by
parentheses. Spaces are optional before and after the
`:=`.

**Examples**

       x := 3
       y:=2
       widget.active := true

Assignment methods conventionally return `done`.

## Binary Operator Requests

Binary operators are methods whose names comprise one or more operator
characters, provided that the operator is not reserved by the
Grace language. Binary operators have a receiver and one argument; the
receiver must be explicit. So, for example, `+`, `++` and `..` are valid
operator symbols, but `.` is not, because it is reserved.

Most Grace operators have the same precedence: it is a syntax error for
two distinct operator symbols to appear in an expression without
parenthesis to indicate order of evaluation. The same operator symbol
can be requested more than once without parenthesis; such expressions
are evaluated left-to-right.

Four binary operators do have precedence defined between them: `/` and
`*` bind more tightly than `+` and `-`.

**Examples**


    1 + 2 + 3                  // evaluates to 6
    1 + (2 * 3)                // evaluates to 7
    (1 + 2) * 3                // evaluates to 9
    1 + 2 * 3                  // evaluates to 7
    1 +*+ 4 -*- 4              // precedence error

**Examples**


Named method requests without arguments bind more tightly than operator
requests.


| Grace | Parsed as |
|:--|:--|
|  `1 + 2.i`                     | `1 + (2.i)` |
|  `(a * a) + (b * b).sqrt`      | `(a * a) + ((b *b).sqrt)` |
|  `((a * a) + (b * b)).sqrt `   | `((a * a) + (b *b)).sqrt` |
|  `a * a + b * b`               | `(a * a) + (b *b)` |
|  `a + b + c`                   | `(a + b) + c` |
|  `a - b - c`                   | `(a - b) - c` |


## Unary Prefix Operator Requests

Grace supports unary methods named by operator symbols that precede the
explicit receiver. (Since binary operator methods must have an
explicit receiver, there is no syntactic ambiguity.)

Prefix operators bind less tightly than named method requests, and more
tightly than binary operator requests.

**Examples**


    -3 + 4
    (-b).squared
    -(b.squared)
    - b.squared     // parses as -(b.squared)

    status.ok :=  !engine.isOnFire && wings.areAttached && isOnCourse


## Precedence of Method Requests

Grace programs are formally defined by the language’s [Grammar]. The
grammar gives the following precedence levels; lower numbers bind more
tightly.

1.  Numerals and constructors for strings, objects, collections,
blocks, and types; parenthesized expressions.
2.  Requests of named methods.
Multi-part requests accumulate name-parts and arguments as far to
the right as possible.
3.  Prefix operators
4.  “Multiplicative” operators `*` and `/`: associate left to right.
5.  “Additive” operators `+` and `-`: associate left to right.
6.  “Other” operators, whose binding must be given explicitly
using parenthesis.
7.  Assignments and method requests that use `:=` as a suffix to a
method name.


## Requesting Methods with Type Parameters

Methods that have type parameters may be requested with or without
explicit type arguments. If type arguments are supplied there must be
the same number of arguments as there are parameters. If type
arguments are omitted, they are assumed to be type `Unknown`.



**Examples**


    sumSq⟦Number⟧(10.i64, 20.i64)

    sumSq(10.i64, 20.i64)


## Manifest Expressions

The parents in `inherit <parent>` and `use <parent>`
clauses must be _manifest_. This means that Grace must be able to
determine the _shape_ of the object that is being inherited on a module-by-module
basis. 

If `parent` is an implicit request, it is first converted to an
explicit request by applying the disabmiguation rules
for [Implicit Requests](#implicit-requests).
It is then subjected to the following test.

A parent expression p<sub>1</sub>.p<sub>2</sub> ... p<sub>_n_</sub> is manifest if

1. p<sub>1</sub> is bound to a module in an import statement, or
2. p<sub>1</sub> is `outer`, and `outer` refers to a module

and

all of the p<sub>_i_</sub>, _i_ > 1, are defined in a `DefDeclaration` a 
`MethodDeclaration` or a `ClassDeclaration`

# Pattern Matching

Pattern matching is based on `Pattern` objects that respond to the
`match(subject)` request by returning a `MatchResult`, which is either
`false` if the match fails, or a `SuccessfulMatch⟦R⟧` object which
behaves like `true` but also supports a `result` request.  All type
objects are Patterns; in addition, libraries supply non-type Patterns,
and programmers are free to implement their own Patterns.

**Example**


Suppose that the type `Point` is defined by:

    type Point = {
      x -> Number
      y -> Number
    }

and implemented by this class:

    class x(x':Number) y(y':Number) -> Point {
      method x { x' }
      method y { y' }
    }

we can write

    def cp = x(10) y(20)

    Point.match(cp)              // SuccessfulMatch, behaves like true
    Point.match(cp).result       // cp
    Point.match(42)              // false

## Matching Blocks

Blocks with a single parameter are called _matching blocks_. Matching
blocks also conform to  type Pattern, and can be evaluated by
requesting `match(_)` as well as `apply(_)`. When `apply(_)` would
raise a type error because the block's argument would not conform to its
parameter type, `match(_)` returns false; when `apply(_)` would return
a result `r`, `match(_)` returns a `SuccessfulMatch` object whose
`result` is `r`.

If the parameter declaration of a matching block takes the form `_:pattern`,
then the `_:` can be omitted, provided that `pattern` is
is parenthesized, or is a string literal or a numeral.
This rule (the *delimited argument rule*) means that the pattern can't be
mistaken for a declaration of a parameter to the block.

## Self-Matching Objects

The objects created by [String Literals](#strings) [Numerals](#numbers) and
[the Boolean constants](#booleans)
are patterns that match strings, numbers and Booleans that are equal to the literal.

**Examples**

Matching blocks and self-matching objects can be conveniently used
in the `match(_)case(_)...` family of methods.

    method fib(n:Number) -> Number {
        match (n)
	        case { 0 -> 0 }
	        case { 1 -> 1 }
	        case { _ -> fib(n-1) + fib(n-2) }
    }

The first two blocks use self-matching objects; the first is short for { _:0 -> 0 }.

The last block has no pattern (or, if you prefer, has the pattern `Unknown`,
which matches any object).  Such a block always matches.

If
`match(_)case(_)...` does not find a match, it raises a non-exhaustive match exception.


    { 0 -> "Zero" }
        // match against a Sting Literal

    { s:String -> print(s) }
        // type match, binding s - identical to block with typed parameter

    { (pi) -> print("Pi = " ++ pi) }
        // match against the value of an expression - requires parenthesis

    { a -> print("did not match") }
        // match against empty type annotation; matches anything, and binds to `a`


# Exceptions

Grace supports exceptions (more precisely, exception packets), which can be raised and caught.
At the site where an exceptional situation is detected, an exception is
raised by requesting the `raise` method on an `ExceptionKind` object,
with a string argument explaining the problem, and an optional data object.

Raising an exception does two things: it creates an `ExceptionPacket` object
of the specified kind, and terminates the execution of the expression
containing the `raise` request. It is not possible to restart or
resume that execution. Execution continues when the exception is *caught.*

**Examples**

        BoundsError.raise "index {ix} not in range 1..{n}"
        UserException.raise "impossible happened"

## Kinds of Exception

Grace defines a hierarchy of _kinds_ of exception; each kind of exception
corresponds to a different kind of exceptional situation.
All exceptions have the same _type_, that is, they understand the same set of 
requests.  A hierarchy of exception kinds is used to classify exceptions.

    type ExceptionKind = Pattern & {
        parent -> ExceptionKind
        // answers the ExceptionKind that is the parent of this exception in the
        // hierarchy. The parent of Exception is defined to be Exception. The parent
        // of any other ExceptionKind is the object that was refined to create it.
        
        refine (name:String) -> ExceptionKind
        // answers a new ExceptionKind object, which is a refinement of self.

        name -> String
        // answers the name given when this ExceptionKind object was created.
        
        raise (message:String)
        // creates an exception of this kind, terminating the current execution,
        // and transferring control to an appropriate handler.
        
        raise (message:String) with (data:Object)
        // similar to raise(_), except that the object data is associated with the
        // new exception.

        == (other:Object) → Boolean
        // answers true if other is an ExceptionKind such that parent == other.parent
        // and name = other.name, otherwise false.
    }

The root of the hierarchy of `ExceptionKind`s is `Exception`; all other `ExceptionKinds` 
are (direct or indirect) refinements of `Exception`. 
The `name` of `Exception` is `"Exception"`, and
the parent of `Exception` is `Exception` itself.

Because `ExceptionKinds` are also `Patterns`, they support the pattern protocol 
(`match`, `&`, and `|`); an `ExceptionKind` object `e` will `match` any exception 
raised from `e'`, and any exception raised from a `refine`ment of `e'`, where `e' == e`, 
This means that `ExceptionKinds` can be used as the 
patterns of the catch blocks in a `try(_)catch(_)…finally(_)` construct.

Grace defines three direct refinements of `Exception`:

 * `EnvironmentException`: those exceptions arising from interactions between the program and the environment, including network exceptions, file system exceptions, and inappropriate user input.
 * `ProgrammingError`: exceptions arising from programming errors.
       Examples are `IndexOutOfBounds`, `NoSuchMethod`, and `NoSuchObject`.
 * `ResourceException`: exceptions arising from an implementation insufficiency, such as running out of memory or disk space.

Notice that there is no category for "expected" exceptions.  This is deliberate; expected events should not be represented by exceptions, but by other values and control structures.
For example, if you you have a key that may or may not be in a dictionary, you should not request the `at` method and catch the `NoSuchObject` exception.  Instead, you should request the `at(_)ifAbsent(_)` method.

## Exception Packets

Exception packet objects are generated when an exception is raised.

    type ExceptionPacket = type {
        exception -> ExceptionKind   // the exceptionKind that raised this exception.
        message -> String            // the message provided when this exception was raised.
        
        data -> Object               // the data object associated with this exception
                                     // when it was raised, if there was one. Otherwise, 
                                     // the string "no data".
        
        lineNumber -> Number         // the source-code line of the raise request
                                     //  that created this exception.
        
        moduleName -> String         // the name of the module containing the raise
                                     // request that created this exception.
        
        backtrace -> List⟦String⟧      
        // a description of the call stack at the time that this exception was raised.
        // backtrace.first is the initial execution environment; backtrace.last is the
        // context that raised the exception.
    }

The `data` field of an `ExceptionPacket` may be populated
with any object using the `raise(_)with(_)` method on an `ExceptionKind` object. For
example:

```
MyException.raise "A message" with (anObject)
```

The `data` object is stored so that it can be used (if desired) when the exception is caught.


## Catching Exceptions

An exception in `expression` can be caught by a dynamically-enclosing

    try (expression)
        catch (block 1)
        ...
        catch (block n)
        finally (finalBlock)

in which the `block i`
are pattern-matching blocks. More precisely, if an exception is raised
during the evaluation of the `try` block `expression`, the `catch` blocks
`block 1`, `block 2`, …, `block n`, are attempted, in order,
until one of them matches the exception. If none of them matches, then
the process of matching the exception continues in the
dynamically-surrounding `try(_)catch(_)…finally(_)`. The
`finalBlock` is always executed before control leaves the
`try(_)catch(_)…finally(_)` construct, whether or not an
exception is raised, and whether or not one of the catch blocks returns.

Finally clauses can return early, either by executing a `return`, or by
raising an exception. In such a situation, any prior `return` or raised
exception is silently dropped.

**Examples**


    try {
        def f = io.open("data.store", "r")
    } catch {
        e: NoSuchFile -> print "{e.message}\nFile does not exist."
    } catch {
        e: PermissionError -> print "Permission denied"
    } catch {
        _: Exception -> print "Unidentified Error"
        system.exit(1)
    } finally {
        f.close
    }

A single handler may be defined for more than one kind of exception using the `|` pattern combinator:

    try {
        try_block
    } case { e:MyError | AnotherError ->
        handler
    }


`handler` will be run when either `MyError` or `AnotherError` is raised inside the `try_block`.

# Types

Grace uses structural typing, as do
[Modula-3](https://www.cs.purdue.edu/homes/hosking/m3/reference/)
and [WhiteOak](http://doi.acm.org/10.1145/1449764.1449771).
[Malayeri and Aldrich](http://www.cs.cmu.edu/~donna/public/ecoop08.pdf)
discuss the differences between nominal and structural typing.

Types primarily describe the requests that objects can answer. Fields do not
directly influence types, except that a field that is public, readable
or writable is treated as the appropriate method or methods.

Type names introduced by [type declarations](#type-declarations)
are treated as expressions
that denote _type objects_.  All type objects are also patterns, so
they can be used in [pattern matching](#pattern-matching),
typically to perform dynamic
type tests.
Because type declarations cannot be changed by overriding, the value of
a type expression can always be determined before the program is executed;
this means that types can be checked statically.

## Predeclared Types

A number of types are declared in the standard prelude and included in
most dialects, including [`None`](#none), [`Done`](#done), `Boolean`, [`Object`](#type-object),
[`Number`](#numbers), [`String`](#strings), `Block0`, `Block1`,
`Block2`, `Fun`, `Iterator`, `Pattern`, [`ExceptionPacket`](#exception-packets),
[`ExceptionKind`](#kinds-of-exception), and [`Type`](#type-type).

### Type None

Type `None` is completely empty; it has no methods.


### Type Object

The type `Object` includes methods to which most
objects respond --- the [Default Methods] declared in
`graceObject`. Some objects, notably `done`, do not conform to `Object`.


    type Object = {
    	!= (other: Object) -> Boolean          // the inverse of ==
    	asString -> String                     // a string for use by the client
    	asDebugString -> String                // a string for use by the implementor
    	:: (other:Object) -> Binding           // a binding with self as the key
    }

Notice that `isMe`, although present in [`graceObject`](#default-methods), is not present in
type `Object`, because it is *confidential*.
Also notice that neither `graceObject` nor type `Object` include `==`.

### Type Self

The type `Self` represents the public interface of the current
object.
Self is prohibited as the annotation on parameters, but
can be used to annotate results.

### Type Unknown

Unknown is not actually a type, although it is treated as a type
by the type checker.  It is similar to the type label "Dynamic" in C#.
Unknown can be written explicitly as a type annotation; moreover,
if a declaration is not annotated, then the type of the declared name is
_implicitly_ `Unknown`.  Omitted type arguments are also equivalent to
`Unknown`.

Type-checking against `Unknown` will always succeed: any object matches
type `Unknown`, and type `Unknown` conforms to all other types.

**Examples**


    var x: Unknown := 5   //who knows what the type is?
    var x := 5            //same here, but Unknown is implicit
    x := "five"           //who cares
    x.gilad               //almost certainly raises NoSuchMethod

    method id(x) { x }    //argument and return types both implicitly unknown
    method id(x: Unknown) -> Unknown { x }  // same thing, explicitly

### Type Type

All types have type Type, which is defined as

    type Type = interface {
        match (o:Unknown) -> MatchResult
        & (other:Type) -> Type
        | (other:Type) -> Type
        + (other:Type) -> Type
        :> (other:Type) -> Boolean
        <: (other:Type) -> Boolean
        == (other:Type) -> Boolean
        != (other:Type) -> Boolean
        hash -> Number
        asString -> String
        asDebugString -> String
        interfaces -> Sequence⟦Interface⟧
	}

This type captures the idea that a type is a disjunction of interfaces.  The interface literal syntax
defines a type containing a single interface, so the `interfaces` method of an interface returns a sequence of length 1 containing itself.

    type Interface = Type & interface {
	     methods -> Dictionary⟦String, Signature⟧
            // keys are the canonical names of the methods, 
            // and values their signatures
	     types -> Dictionary⟦String, Type⟧
            // keys are the declared names of the types; 
            // values objects representing those types
	     - (other:Interface) -> Interface
	 }
	
	 type Signature = interface {
	     name -> String
            // the canonical name of the method
	     arguments -> Sequence⟦Type⟧
            // the types of the parameters, in order
	     result -> Type
            // the type of the result
	 }
	
These types say that each interface comprises a mapping from (canonical) method names to method signatures,
and a mapping from type names to type objects.
Each Signature comprises the (canonical) name of the method, the types of its arguments, and the type of its result.


## Interfaces and Type Literals

Interfaces characterize objects by detailing their public methods,
and the types of the parameters and results of those methods. Interfaces can also
contain definitions of other types; this enables interfaces to describe types nested
inside objects.

The various cat objects and class descriptions (see
[Objects, Classes, and Traits](#objects-classes-and-traits)) would create objects that
conform to this interface:

    interface {
        colour -> Colour
        name -> String
        miceEaten -> Number
        miceEaten:= (n:Number) -> Done
    }

Note that the public methods of `Object` are implicitly included in the type
denoted by a type literal.

For commonality with method declarations, parameters are normally named
in type literals. These names are useful when writing specifications
of the methods. If a parameter name is omitted, it must be replaced by
an underscore. The type of a parameter or result may be omitted,
in which case the type is `Unknown`.

## Type Declarations

Types, including parameterized types, may be named in type declarations.
By convention, the names of types start with an uppercase letter.
A simple type literal consists of the keyword `interface` followed by
an open curly brace, a sequence of method signatures, and a closed
curly brace.
The `interface` keyword may be omitted from the right-hand-side
of a type declaration when the right-hand-side is a simple type literal.
Type declarations may not be overridden.

**Examples**

	type MyCatType = interface {  // the word interface may be omitted
		color -> Colour
		name -> String
	}
	// I care only about names and colours
	
	type MyParametricType⟦A,B⟧ =
		interface {
			at (_:A) put (_:B) -> Boolean
			cleanup(_:B)
		} where A <: Hashable,  B <: DisposableReference

## Type Conformance

The key relation between types is **conformance**. We write `B <: A`
to mean B conforms to A; that is, that B has all of the methods
of A, and perhaps additional methods (and that the corresponding methods
have conforming signatures). This can also be read as “B is a subtype of
A”, or “A is a supertype of B”.

We now define the conformance relation more rigorously. This section
draws heavily on the wording of the [Modula-3 report]
(https://www.cs.purdue.edu/homes/hosking/m3/reference/).

If `B <: A`, then every object of type `B` is also an object
of type A. The converse does not apply.

If `A` and `B` are interfaces, then `B <: A` if and only if, for
every method `m` in `A`, there is a corresponding method `m` (with the same
canonical name) in `B` such that

-   If the method `m` in `A` has signature `m(P1, ... ,Pk)n(Pk+1, ... ,Pn)... -> R`, and
    `m` in B has signature `m(Q1,...,Qk)n(Qk+1,...,Qn)... -> S`, then

    -   parameter types must be contravariant: `Pi <: Qi`

    -   results types must be covariant: `S <: R`

The relationship used in `where` clauses to constrain
type parameters of traits, classes and methods has yet to be specified.

## Composite types

Grace offers a number of operators to compose types.

### Variant Types

The expression
`T1 | T2 | ... | Tn `
signifies an untagged, retained variant type.
When a *variable* or *method* is annotated with a variant type,
that variable may be bound to, or that method may return,
an object of any one of the
component types `T1`, `T2`, ..., `Tn`.
No *objects* actually have variant types, only
expressions.
The type of an object referred to by a variant
variable
(as determined by the type annotations in its declaration)
can be examined using that object’s reified type information.

The only methods in the static type of a receiver with a variant
type are methods present in all members
of the variant.

Variant types are *not* equivalent to the
object type that describes all common methods. This is so that the
exhaustiveness of match/case statements can be determined statically.
Thus the rules for conformance are more restrictive:

```
S <: (S | T)
T <: (S | T)
(S' <: S) & (T' <: T)  ==>  (S' | T') <: (S | T)
```
**Example**


To illustrate the limitations on conformance of variant types, suppose

    type S = {m: A -> B, n: C -> D}
    type T = {m: A -> B, k: E -> F}
    type U = {m: A -> B}

Then `U` fails to conform to `S | T` even though `U` contains all
methods contained in both `S` and `T`.

### Intersection Types

An object conforms to an Intersection type, written
`T1 & T2 & ... & Tn`, if and only if that object conforms to all of the
component types. The main uses of intersection types is for augmenting
types with new operations, and as bounds on `where` clauses.

    (S & T) <: S
    (S & T) <: T
    U <: S; U <: T; <==> U <: (S & T)

**Examples**


    type List⟦T⟧ = Sequence⟦T⟧ & interface {
        add(_:T) -> List⟦T⟧
        remove(_:T) -> List⟦T⟧
    }

    class happy⟦T⟧(param: T) -> Done
       where T <: (Comparable⟦T⟧ & Printable & Happyable) {
               ...
    }

### Union Types

Structural union types (sum types), written `1 + 2 + ... + Tn`, are
the dual of intersection types. A union type `T1 + T2` has the interface
common to `T1` and `T2`. Thus, a type `U` conforms to `T1 + T2` if it
has a method that conforms to each of the methods common to `T1` and
`T2`. Union types are included for completeness; variant types subsume 
most uses of unions.

    S <: (S + T)
    T <: (S + T)

### Type Subtraction

A type subtraction, written `T1 - T2` has the interface of `T1` without
any of the methods in `T2`.  The signatures of the methods in `T2` are
irrelevant.

### Nested Types

Type definitions may be nested inside other expressions, for example,
they may be defined inside object, class, method, and other type
definitions, and typically accessed via [Manifest Requests](#manifest-requests).
This allows types to be declared and imported from other modules.

## Type Assertions

When parameters, fields, and method results are annotated with types,
the programmer can be confident that objects bound to those parameters and
fields,
and returned from those methods, do indeed have the specified types, insofar
as Grace has the required type information.  The checks necessary to implement
this guarantee may be performed statically or dynamically.

When implementing the type check, types specified as `Unknown` will always
conform.  So, if a variable is annotated with type
```
    interface {
        add(Number) -> Collection⟦Number⟧
        removeLast -> Number
    }
```
an object with type
```
    interface {
        add(Unknown) -> Collection⟦Unknown⟧
        removeLast -> Unknown
        size -> Number
    }
```
will pass the type test.  Of course, the presence of `Unknown` in the type
of the object means that a subsequent type error may still occur.
For example, the code of the `add(_)` method
might actually depend on being given a `String` argument,
or the collection returned from `add(_)` might contain `Boolean`s.

The same type check can be requested explicitly by using the operators `<:`,
`:>` and `==` between types.

**Examples**

    assert (B <: A) description "B does not conform to A"
    assert (B <: interface { foo(_) } ) description "B has no foo(_) method"
    assert (B <: interface {foo(_:C) -> D} ) description "B doesn't have a method foo(_:C)->D"
    assert (B == (A | C)) description "B is neither an A or a C"

# Modules and Dialects

Grace programs can be divided into multiple modules.
A module is typically used to define library functionality.

## Modules

A module is typically defined in a implementation-dependent fashion,
typically by creating a file containing Grace code. The text of the
file is treated as the body of an object constructor, so it may
contain both declarations and executable code. When a module is loaded,
this object constructor is *executed*, resulting in a _module object_.

## Importing Modules

Modules may begin with one or more `import` _moduleName_ `as` _nickname_
statements.
_moduleName_ is a [string literal](#string-literals) that identifies the module
to be imported in an implementation-dependent manner; for example,
_moduleName_ may be a file path.
_nickname_ is the Grace identifier used to refer to the imported module object
in the importing module.
The nickname is confidential by default, but can be annotated as public.

Because importing a module creates a module object, public
declarations at the top level of imported modules are accessed
by requesting a method on the module's nickname.
Confidential declarations are not visible to the importing module.

## Executing a Module

Grace programs are executed by asking the execution
environment to run a particular module,
which may be thought of as the “main” module.
Grace will load and initialise all transitively
imported modules in depth-first order,
thus executing the “main” module _last_, after all its dependencies
are loaded.
Each imported module is loaded just once, the first time
it is reached: importing the same _moduleName_ multiple times
results in the same module object.
Circular module dependencies are errors.

**Examples**


cat.grace module:

```
import "animals" as a
print "initialising cat module"
class cat {
    inherit a.mammal
    method species { "cat" }
}
print "cat module done"
```

animals.grace module:

```
print "initialising animals module"
class mammal {
    method asString { "I am a {species}" }
    method species { "mammal" }
}
print "animals module done"
```

will print:

```
initialising animals module
animals module done
initialising cat module
cat module done
```

## Dialects

Grace dialects support language levels for teaching, and
domain-specific "little" languages. A module may begin with a dialect
statement `dialect "name"`,
where the `dialect` keyword is followed by a [string literal](#string-literal).

The effect of the dialect statement is to import the dialect like any other
module, but then arrange that the dialect's module object
lexically encloses the object defined by the module. This means that
[Implicit Requests](#implicit-requests) in the module can resolve to the definitions in
the dialect.

Many features built in to other programming languages are obtained
from dialects in Grace: this includes all preexisting type
declarations, classes, traits, control structures, and even the
`graceObject` trait that defines the default methods.

Modules that do not declare a 'dialect' are treated as being written in the
dialect `standardGrace`.  If a module really wishes to use no dialect,
it should specify `dialect "none"`. 

In addition to declarations, a dialect can also define a _checker_ that
examines the parse tree or syntax tree of any module written in the dialect,
and generates errors.
This enables a dialect to restrict the language of its modules to a subset
of the full Grace language.

**Examples**


The `bcpl.grace` module might declare an `unless(_)do(_)` control
structure that is like `if`, but backwards.

bcpl.grace module:

    method do (block: Block0) unless (test: Boolean)  {
        if (test.not) then (block)
    }

A module written in this dialect can use that control structure as if
it were built in:

example.grace module:

    dialect "bcpl"
    ...
    do { average := sum / count } unless (count == 0)


## Module and Dialect Scopes

The **module scope** of a Grace module contains all declarations at the top
level of the module, including the nicknames introduced by `import` declarations.

Surrounding the module scope is the
**dialect scope**, which contains all *public* declarations at the top level of
the module that defines the dialect.
That is, the public names at the top level of the dialect
are treated as being in a scope surrounding that of any
module written in that dialect.  (Confidential names are not visible.)

Lexical lookup stops at the dialect scope: it does not extend
to the scope surrounding the dialect (which would contain any
other dialects used to implement the current dialect).
These rules allow dialects to import modules, and to be written in other dialects,
without those other definitions polluting the language defined by the dialect.

# Pragmatics

The distribution medium for Grace programs, objects, and libraries is
Grace source code.

Grace source files should have the file extension `.grace`. If, for any
bizarre reason a trigraph extension is required, it should be `.grc`

Grace files may start with one or more lines beginning with `#`: these
lines are ignored by the language, but may be interpreted as directives
by an implementation.

## Garbage Collection

Grace implementations should be garbage collected. Garbage collection
may occur at any backwards branch, at any method request, and
at any point where an object is constructed.
Grace does not support finalization.

## Concurrency

The core Grace specification does not describe a concurrent language.
Various concurrency models may be provided as dialects.
The details remain to be specified.

# Acknowledgements

We thank Michael Homer and Tim Jones for working on early
implementations of Grace, and Josh Bloch, Cay Horstmann, Michael
Kölling, Doug Lea, Ewan Tempero, Laurence Tratt, and the participants at the Grace
Design Workshops and IFIP WG2.16 on Programming Language Design
meetings for discussions about the design of Grace.

# Grammar

The following PEG defines the context-free syntax of Grace.
Productions are arranged in alphabetical order.

```
GRAMMAR
```
