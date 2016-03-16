---
author:
- 'Andrew P. Black'
- 'Kim B. Bruce'
- James Noble

bibliography:
- 'spec.bib'

title: |
    The Grace Programming Language\
    Draft Specification Version 0.6a5
...


# Introduction

This is a specification of the Grace Programming Language. This
specification is notably incomplete, and everything is subject to
change. In particular, this version does *not* address:

-   static type system

-   immutable data and pure methods.

-   reflection

-   assertions, data-structure invariants, pre & post conditions,
    contracts

-   libraries, including more (complex?) Numeric types and testing

# User Model

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
        procedural first. 

    2.  The courses may be taught using dynamic types, static types, or
        both in combination (in either order).

    3.  We aim to offer some (but not necessarily complete) support for
        “functional first” curricula, primarily for courses that proceed
        rapidly to procedural and object-oriented programming.

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

# Syntax

------------------------------------------------------------------------

> *Much of the following text assumes the reader has a minimal grasp of
> computer terminology and a “feeling” for the structure of a program.*
>
> Jensen and Wirth, *Pascal: User Manual and Report*.

------------------------------------------------------------------------

Grace programs are written in Unicode. Reserved words are written in the
ASCII subset of Unicode. 

## Layout

Grace uses braces for grouping.  Code layout must be consistent with
grouping.  Indentation must increase by at least two spaces after a
brace. 
Statements are terminated by line breaks when the
following line has the same or lesser indentation than the indentation
of the line containing the start of the current statement.  Statements
may also optionally be terminated by semicolons

### code with punctuation

    def x = 
       muble "3"
       fratz 7;
    while {stream.hasNext} do {
       print(stream.read);
    };

### code without punctuation

    def x = 
       muble "3"
       fratz 7
    while {stream.hasNext} do {
       print(stream.read)
    }

This defines `x` to be the result of the single request `muble("3") fratz(7)`.

## Comments

Grace’s comments start with a pair of slashes `//` and are terminated by
the end of the line. Comments are *not* treated as
white-space. Each comment is conceptually attached to the smallest
immediately preceding syntactic unit, except that comments following a
blank line are attached to the largest immediately following syntactic
unit.

    // comment, to end of line

## Identifiers and Operators

Identifiers must begin with a letter, which is followed by a sequence of
zero or more letters, digits and prime (`'`) or underscore (`_`)
characters.  Conventionally, type and pattern identifiers start with capital
letters, while other identifiers start with lower-case letters.

A single underscore (`_`) acts as a placeholder identifier: it can
appear in declarations, but not in expressions. In declarations, `_` is
treated as a fresh identifier.

Operators are sequences of unicode mathematics operator symbols 
(see https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode)
and the following ASCII operator characters:

    ! ? @ # $ % ^ & | ~ = + - * / \ > < : . 

## Reserved Tokens

Grace has the following reserved tokens:

    alias as class def dialect exclude inherit import is method object
    outer prefix return self Self trait type var use where 

    . := = ; { } [ ] ( ) : -> < > 

## Newlines, Tabs and Control Characters

Newline in Grace programs can be represented by the Unicode line feed (lf) character, by the
Unicode carriage return
(cr) character, or by the Unicode line separator
(U+2028) character; a line feed that immediately
follows a carriage return is ignored.

Tabs and all other non-printing control characters are syntax errors,
even in a string literal. Escape sequences are provided to denote
control characters in strings; see Table \[tab:StringEscapes\] in
Section \[Strings\].
        
# Built-in Objects

## Done


Assignments, and methods without an explicit result, have the value
**`done`**, of type **`Done`**. The type `Done` plays a role similar to *void*
or *Unit* in other languages. The only requests understood by `done` are
`asString` and `asDebugString`. (In particular, `done` does not have an
equality method).

## Numbers

Grace supports a single type **`Number`**. `Number` supports at least 64-bit
precision floats. Implementations may support other numeric types: a
full specification of numeric types is yet to be completed.

Grace has three syntactic forms for numerals (that is, literals that
denote `Number`s).

1.  Decimal numerals, written as strings of digits, optionally preceded
    by a minus.

2.  Base-exponent numerals, always in decimal, which contain a decimal
    point, or an exponent, or both. Grace uses `e` as the
    exponent indicator. Base-exponent numerals may optionally be
    preceded by a minus, and may have a minus in front of the exponent.

3.  Explicit radix numerals, written as a (decimal) number between 2 and
    35 representing the radix, a leading `x`, and a string of digits,
    where the digits from 10 to 35 are represented by the letters A to
    Z, in either upper or lower case. A radix of 0 is taken to mean a
    radix of 16. Explicit radix numerals may optionally be preceded by
    a minus.


#### Examples 

    1
    -1
    42
    3.14159265
    13.343e-12
    -414.45e3
    16xF00F00
    2x10110100
    0xdeadbeef // Radix zero treated as 16

## Booleans 

The predefined constants `true` and `false` denote values of Grace’s
`Boolean` type. Boolean operators are written using `&&` for and, `||`
for or, and prefix `!` for not.

#### Examples 

    p && q
    toBe || toBe.not

In addition to `&&` and `||` taking boolean arguments, they also accept
parmameterless blocks that return `Boolean`.  This gives them 
“short circuit” (a.k.a non-commutative) semantics.

#### Examples 

    p && { q }
    toBe || { ! toBe }


## Strings

String literals in Grace are written between double quotes, and must
be confined to a single line. Strings literals support a range of
escape characters such as `"\n\t"`, and also escapes for Unicode;
these are listed in Table \[tab:StringEscapes\]. Individual characters
are represented by Strings of length 1. Strings are Grace value
objects, so an implementation may intern them. Grace’s standard
library includes supports efficient incremental string construction.

   Escape  Meaning        Unicode                         Escape           Meaning              Unicode
  -------- -------------- --------------------- -------------------------- -------------------- -------------------------
    \\\\   backslash      U+005C             \\`_`            non-breaking space   U+00A0
    \\n    line-feed      U+000A              \\r             carriage return      U+000D
    \\t    tab            U+0009              \\l             Line separator       U+2028
    \\{    left brace     U+007B           \\u$hhhh$          4-digit Unicode      U+$hhhh$
    \\}    right brace    U+007D    \\U$hhhhhh$  6-digit Unicode      U+$hhhhhh$
   \\`"`   double quote   U+0022                                                   

#### Examples

    "Hello World!"
    "\t"
    "The End of the Line\n"
    "A"

### String interpolation

Within a string literal, expressions enclosed in braces are treated
specially. The expression is evaluated, the `asString` method is
requested on the resulting object, and the resulting string is inserted
into the string literal in place of the brace expression.

#### Examples

    "Adding {a} to {b} gives {a+b}"

## Lineups 

Grace supports a constructor syntax for use in parsing multiple arguments
or building collections: a comma separated list of expressions
surrounded by `[` and `]` brackets.

#### Examples

    [ ]        //empty lineup
    [ 1 ]
    [ 2, a, 5 ] 

When executed, this constructor returns an object that supports a 
very minimal interface ('size' and `do(_)`), which will generally be
used to build collections.

#### Examples

    set [ 1, 2, 4, 5 ]      //make a set
    seq [ "a", "b", "c" ]   //make a sequence
    myWindow.addWidgets [ 
       title "Launch",
       text "Good Morning Mrs President", 
       button "OK" action { missiles.launch },
       button "Cancel" action { missiles.abort }
    ]

## Blocks

Grace blocks are lambda expressions; they may or may not have
parameters. If a parameter list is present, the parameters are separated
by commas and the list is terminated by the **`->`** symbol.

    { do.something }
    { i -> i + 1 }
    { i:Number -> i + 1 }
    { sum, next -> sum + next }

Blocks construct objects containing a method named `apply`, or
`apply(n)`, or `apply(n, m)`, …, where the number of parameters to `apply`
is the same as the number of parameters of the block. Requesting the
`apply` method evaluates the block; it is an error to provide the wrong
number of arguments. If block parameters are declared with type
annotations, it is an error if the arguments do not conform to those types.

#### Examples

The looping construct

    for (1 .. 10) do {
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
    def summingBlock : Block<Number,Number> =
        { i : Number ->  sum := sum + i }
    summingBlock.apply(4)       // sum now 4
    summingBlock.apply(32)      // sum now 36

Blocks are lexically scoped inside their containing method or block.
The body of a block consists of a sequence of declarations and
expressions. An empty body is allowed, and is equivalent to `done`.

# Declarations

All declarations may occour anywhere within a module, object, class,
or trait.  Constant and variable declarations may also occur within a
method or block body.  Declarations are visible within the whole of
their containing lexical scope.  It is an error to attempt to declare
any name more than once in the same lexical scope.

**ing.** Grace has a single namespace for all identifiers; this
shared namespace is used for everything: methods, parameters,
constants, variables, classes, traits, and and types. It is an error
to declare a constant, variable or parameter that s a
lexically-enclosing constant, variable, or parameter.

## Constants

Constant definitions are introduced using the **`def`** keyword; they bind
an identifier to the value of an initialising expression, and may
optionally be given a type: this type is checked when
the constant is initialised. Constants cannot be re-bound.

#### Examples

    def x = 3 * 100 * 0.01
    def x : Number = 3
    def x : Number           // Syntax Error: x must be initialised

## Variables

Variable definitions are introduced using the **`var`** keyword; they
optionally bind an identifier to the value of an initialising
expression. Variables can be re-bound to
new values as often as desired, using an assignment. If a
variable is declared without an initializing expression, it is said to
be *uninitialised*; any attempt to access the value of an uninitialised
variable is an error. This error may be caught either at run time or at
compile time.
Variables may be optionally given a type: this type is checked when
the variable is initialised or assigned to.

#### Examples

    var x:Rational := 3     // explicit type
    var x:Rational          // x must be initialised before access
    var x := 3              // x has type Unknown 
    var x                   // x has Unknown type and uninitialised value 

## Methods

Methods are declared with the **`method`** keyword.  Methods define the
action to be taken when the object containing the method receives a
request with the given name. Because every method must be associated
with an object, methods may not be declared directly inside other
methods.  The type of the object returned from the method may
optionally be given after the symbol `->`: this type is checked when
the method returns. The body of the method is enclosed in braces.

    method pi  { 3.141592634 } 

    method greet(user: Person) from(sender: Person) {
        print ``{sender} sends his greetings, {user}.''
    }

    method either (a) or (b) -> Done {
        if (random.nextBoolean)
            then {a.apply} else {b.apply}
    }


### Method Names

Method names have several forms.  For each form, we describe its appearance, 
and also a _canonical_ form of the name which is used in dispatching method requests.
A request "matches" a method if the canonical names are equal.

1. A method can be named by a single identifier, in which case the method
has no parameters; in this case the _canonical_ name of the method is the identifier.

2. A method can be named by an identifier suffixed with `:=`; this
form of name is conventionally used for writer methods, both
user-written and automatically-generated, as exemplified by `value:=`
below.  Such methods _always_ take a single parameter after the `:=` 

3. A method can be
named by a single identifier followed by a parenthesized list of parameters; in this case 
the  _canonical_ name of the method is the identifier followed by `(_, ..., _)`,
where the number of underscores is the same as the number of parameters.

4. A method can be named by _multiple parts_, where each _part_ is an identifier 
followed by a parenthesized list of parameters; in this case 
the  _canonical_ name of the method is the sequence of identifiers followed by `(_, ..., _)`.
The number of underscores between each pair of parentheses the same as the number of 
parameters in the parameter list of the corresponding part.

5. A method can also be named by a sequence of operator symbols. 
Such an "operator method" can have no parameters, in which case
the method is requested by a prefix operator expression.
It can also have one parameter, in which
case it is requested by a binary operator expression.  The canonical name of a 
unary method is **`prefix`** followed by the operator symbols; the canonical 
name of a binary method is the sequence of operator symbols followed by `(_)`

As a consequence of the above rules, methods `max(a, b, c)` and
`max(a, b)` have different canonical names and are therefore treated
as distinct methods.  In other words, Grace allows "overloading by
arity" (although it does _not_ allow overloading by type).
 
Method parameters optionally may be given types: those types will be
checked just before the method body is executed.

[](TODO: need to distribute examples into the above list or something) 

#### Examples

    method ping { print "PING!" } 

    method +(other : Point) -> Point { 
        (x +other.x) @ (y +other.y) 
    }

    method add (other) 
        { return (x +other.x) @ (y +other.y) }

    method value:=(n : Number) -> Done {
        print "value currently {value}, now assigned {n}"
        outer.value:= n 
    }

    method prefix- -> Number 
         { 0 - self }

### Type Parameters

Methods may be declared with one or more type parameters, which are listed between **`<`** and **`>`** used as brackets.
If present, type parameters must appear after the identifier of the first part of
a multipart name.   There must be no space between the opening `<` and the first type parameter (or,
in a request, the first type argument), or between the last type parameter (or argument) and the closing `>`.
The purpose of this rule is to disambiguate this use of `<` and `>` from their use as operator symbols, when 
they must be surrounded by spaces.

If an operator method has a type parameter list, it must be separated from the sequence of operator symbols that 
names the method by a space.

The presence or absence of type parameters does not change the canonical name of the method.

#### Examples

    method sumSq<T>(a : T, b : T) -> T where T <: Numeric {
        (a * a) + (b * b)
    }

    method prefix-<T> -> Number 
         { 0 - self }


### Returning a Value from a Method

Methods may contain one or more **`return`** statements.
If a `return e` statement is executed, the method terminates with the
value of the expression `e`, while a `return` statement with no
expression returns `done`.  If execution reaches
the end of the method body without executing a `return`, the method
terminates and returns the value of the last expression evaluated. 
An empty method body returns `done`.

## Annotations

Any declaration, and any object constructor, may have a
comma-separated list of annotations following the keyword **`is`**
before its body or initialiser. Annotations must be [Manifest
Expressions] that return _annotator objects_. While annotations may be
defined by libraries or dialects, Grace defines the following core
annotations:

| Annotation | Semantics | 
|:--|:--|
| `required` | method will not conflict with or override another method | 
| `confidential` | method may not be called from outside | 
| `manifest` | method or object must be manifest |
| `overrides` | method must override a parental method |
| `public` | method may be called from outside |
| `readable`  | variable or constant may be read from outside |
| `writeable` | variable may be assigned from outside | 

#### Examples

    var x is readable, writeable := 3
    def y : Number is public
    method foo is confidential  { } 
    method id<T> is required  { } 


## Encapsulation

Grace has different default encapsulation rules for methods, types, and
fields. The defaults can be changed by explicit annotations. The details
are as follows.

### Methods, Classes, Traits and Types

By default, methods, classes, traits and types are public, which means
that they can be requested by any client that has access to the
object. Thus, any expression can be the target of a request of a
public method.

If a method or type is annotated `is confidential`, it can be requested
only on `self` or `outer`. This means that it 
is accessible to any object that contains it, and to inheriting
objects, but not to client objects.

### Fields

Variables and definitions (`var` and `def` declarations) immediately
inside an object constructor create *fields* in that object.

A field declared as `var x` can be read using the request `x` and
assigned to using the assignment request `x:=(_)`.
A field declared as `def y` can be read using the request `y`, and
cannot be assigned. By default, fields are *confidential*: they can be
accessed and assigned from the object itself, and inheriting objects,
and from lexically-enclosed objects, but not from clients. In other
words, these requests can be made only on `self` and `outer`.

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
as well as a `var` field `x`.

#### Examples

    object {
        def a = 1              // Confidential access to a
        def b is public = 2        // Public access to b
        def c is readable = 2     // Public access to c
        var d := 3                   // Confidential access and assignment 
        var e is readable          // Public access and confidential assignment
        var f is writable           // Confidential access, public assignment
        var g is public             // Public access and assignment
        var h is readable, writable    // Public access and assignment
    }

### No Private Fields

Some other languages support “private fields”, which are available only
to an object itself, and not to clients or inheritors. Grace does not
have private fields; all fields can be accessed from subobjects.
However, the parameters and temporary variables of methods that return
fresh objects can be used to obtain an effect similar to privacy.

#### Examples

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
is created. In addition to declarations of fields and methods, object
constructors can also contain expressions (executable code at the top level),
which are executed as a
side-effect of evaluating the object constructor. All of the declared
attributes of the object are in scope throughout the object constructors.

#### Examples

    object {
        def colour:Colour = Colour.tabby
        def name:String = "Unnamed"
        var miceEaten := 0
        method eatMouse { miceEaten := miceEaten + 1 }
    }

Like everything in Grace, object constructors are lexically scoped.

A name can be bound to an object constructor, like this:

    def unnamedCat =  object {
         def colour : Colour = Colour.tabby
         def name : String = "Unnamed"
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
            inherits graceObject
            def colour is public = c
            def name is public = n
            var miceEaten is readable := 0
            method eatMouse {miceEaten := miceEaten + 1}
            print "The cat {n} has been created."
        }
    }

This class might be used as follows:

    def fergus = catColoured (colour.tortoiseshell) named "Fergus"

This creates an object with fields `colour` (set to
`colour.tortoiseshell`), `name` (set to `"Fergus"`), and `miceEaten`
(initialised to `0`), prints “The cat Fergus has been created”, and
binds the name `fergus` to this object.

## Trait Objects and Trait Declarations

Trait objects are objects with certain properties.  Specifically, a
trait object is created by an object constructor that contains no
field declarations and no executable code, that `use`s only other traits,
and that `inherit`s nothing.




Modulo these restrictions, Grace's **trait** syntax and semantics is exactly parallel to the class syntax:
a `trait` defines a method that returns a trait object.

    trait emptiness {
        method isEmpty { size == 0 }
        method nonEmpty { size != 0 }
        method ifEmptyDo (eAction) nonEmptyDo (nAction) {
                if (isEmpty) then { eAction.apply } else { do(nAction) }
        } 
    }


## Type Parameters

Like methods, classes and traits may be declared to have type
parameters.  Requests on the class or trait may optionally be provided
with type arguments.

[](Type parameters may be constrained with `where` clauses.)

#### Example

    class vectorOfSize(size)<T> {
        var contents := Array.size(size)
        method at(index : Number) -> T {return contents.at() } 
        method at(index : Number) put(elem : T) { }
    }

[](    class sortedVectorOfSize(size)<T> 
        where T <: Comparable<T> {
          ...
    }
)

## Reuse

Grace supports reuse in two ways: through **`inherit`** and **`use`** statements.
Object constructors (and classes) can contain one `inherit` statement
while traits cannot contain an `inherit` statement;  object
constructors, classes and traits can all contain one or more `use` statements.

Both `inherit` and `use` introduce the attributes of a reused object —
called the _parent_ — into the current object (the object under
construction).  A new declaration in the current object can override a
declaration from a parent.

The request of an `inherit` or `use` clause is restricted to be a
[Manifest Expression](Manifest Expressions)
that creates a new object, such as a request on a class or trait.
This mens that the  request  cannot depend on a `self`, implicitly or
explicitly: programs cannot inherit (or use) any trait or class that
can potentially be overridden. 
The object reused by a `use` clause must be a trait object. 
The arguments to this request need not themselves be manifest.

If it is necessary to access an overridden attribute, the overridden
attribute of the parent can be given an additional name by attaching
an **`alias`** clause to the inherits statement: `alias n(_) = m(_)`
gives a new `confidential` _alias_ `n(_)` for the attribute `m(_)`.
Attributes of the parent that are not wanted can be excluded using
an **`exclude`** clause: excluded attributes are replaced by a
`confidential` `required` method with an empty body.


### Combination and Initialisation

When executed, an object constructor (or trait or class declaration)
first creates a new object with no attributes, and binds it to `self`. 

Next, the attributes of all _parent_ objects (created by any 'inherit'
or 'uses' clauses, modified by `alias` and `exclude`) and any local
declarations, are installed in the new object.  Local declarations
override parental declarations.  It is a _trait composition error_ for
the same concrete attribute to come from more than one parent, and not
to be overridden by a local definition; or for an alias to be
overridden by a local declaration.

Next, types must be evaluated and bound within objects. As [Manifest
Expressions], types cannot depend on runtime values.

Finally, the initializers and executable statements are executed, starting with the most superior inherited superobject, and finishing with local declarations. (Note that used traits contain no executable code.)
Initialisers for all `def`s and `var`s, 
and code in the bodies of parents,
are executed once in the order they are written, even for `def`s or
`var`s that are excluded from the new object, or aliased to one or
more new names. 
During initialisation, `self` is always bound to the new object being
created, even while executing code and initialisers from parent
objects, classes or traits.

As a consequence of these rules, a new object can change the
initialization of its parents, by overriding self requests invoked by
parents' initialisers or executable statements.


### Required Methods

Methods may be annotated as being **`required`** (previously
"abstract").  Required methods do not conflict with other methods,
either required or concrete (not required), however a required local
method overrides an inherited concrete method. In most dialects,
a required method's body must be empty.

#### Examples

The example below shows how a class can use a method to override an
accessor method for an inherited variable. 

    class pedigreeCatColoured (aColour) named (aName) {
        inherits catColoured (aColour) named (aName)
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

    trait canine {
        method loyal { "I'm your best friend" }
        method move { 
            if (you.location != self.location) then {
                self.setPosition(you.heel)
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

### Default Methods

Many objects conventionally implement a number of _default methods_ by
inheriting from the **`graceObject`** trait. In particular, the
objects created by the `class` syntax inherit from `graceObject` if no
**inherits** clause is supplied (but not objects created by the
`trait` syntax or by `object` constructors). Programmers can of course
override some of these implementations, or write those methods _ab initio_.
The [type Object] conventionally defines a type containing all the default methods.

# Method Requests

Grace is a pure object-oriented language. Everything in the language
is an object, and all computation proceeds by _requesting_ an
object—the receiver of the request—to execute a method with a
particular *name*. The response of the receiver is to execute the
method, and to return as an answer the value returned by the execution
of the method.

Grace distinguishes the act of *requesting* a method (what Smalltalk calls
“sending a message”), and *executing* that method. Requesting a method
happens outside the object receiving the request, and involves only a
reference to the receiver, the method name, and possibly some arguments.
In contrast, executing the method involves the code of the method, which
is local to the receiver.


## Self 

The reserved word **`self`** refers to the lexically enclosing object.
The expression `self.x` requests `x` on the current object.


#### Examples

      self                     
      self.value
      self.bar(1,2,6)
      self.doThis(3) timesTo("foo")               
      self + 1 
      ! self   

## Outer

The reserved word **`outer`** refers to the object lexically enclosing
`self`.  The expression `outer.x` requests `x` on the object lexically
enclosing the current object.

#### Examples

      outer                     
      outer.outer.outer.outer
      outer.value
      outer.bar(1,2,6)
      outer.outer.doThis(3) timesTo("foo")               
      outer + 1 
      ! outer   

## Named Requests

A named method request comprises an expression identifying the receiver, 
followed by a dot “.”, followed by a
method name, and within parentheses, a comma-separated list of
arguments.
Parentheses are not used if there are no arguments. 


To improve
readability, the name of a method that takes more than one parameter
may comprise multiple parts, with multiple argument lists between the parts and after the last part.
For example:

        method drawLineFrom (source) to (destination) { ... }

In this example the name of the method is `drawLineFrom(_) to(_)`; it
comprises two parts, `drawLineFrom(_)` and `to(_)`. The name of a method and
the position of the argument lists within that name is determined when
the method is declared. When reading a request of a multi-part method
name, you should continue accumulating words and argument lists as far
to the right as possible. 

Unlike some other languages, Grace does _not_ allow the overloading of
method names by type:  the type of the arguments supplied to the request does
not influence the method being requested.  However, the _number_ of arguments
in a list does determine the method being requested.

#### Examples
        self.clear
        self.drawLineFrom (p1) to (p2)
        self.drawLineFrom (origin) length (9) angle (pi/6)
        self.movePenTo (x, y)
        self.movePenTo (p)


### Delimited Arguments

Parenthesis may be omitted where they would enclose a single argument
that is a numeral, string, lineup, or block.

#### Examples

        self.drawLineFrom (p1) to (p2)
        self.drawLineFrom (origin) length 9 angle (pi/6)
        print "Hello World"
        while {x < 10} then { 
            print [a, x, b]
            x := x + 1 
        }


### Implicit Requests

If the receiver of a named method request named _m_ is `self` or
`outer` it may be left implicit, _i.e._, the `self` or `outer` and the
dot may both be omitted.

Implicit requests are resolved as follows:

* If there is a declaration named _m_ lexically inside but excluding
    the single innermost object (or trait, class) then the implicit
    request resolves to that declaration. Otherwise:

* If there is a declaration named _m_ lexically visible on `self`
   (i.e. declared in the single innermost object, trait, or class declaration
   containing the method, or `use`d or `inherit`ed by that declaraton)
   then the implicit request is treated as a `self` request. Otherwise:

* If there is a lexically visible declaration of _m_, going out as far
  as the [module object](Modules) and [dialect](Dialects)
  then the request resolves to that declaration. Otherwise:

* If there is no declaration named _m_, the request is an error.

Note that implicit requests are resolved within the site of the
declaring method, not where they are used. 

#### Examples

Implicit requests: 

        print "Hello world" 
        size 
        canvas

Resolving implicit requests: 

````
method foo { print "outer" } 

class app {
  method barf { foo }
}

class bar { 
  inherits app
  method foo { print "bar" } 
} 

class baz {
  inherits bar
  method barf { foo }
}


app.barf  //prints "outer"
bar.barf  //prints "outer"
baz.barf  //prints "bar"
````

##Assignment Requests

An assignment request is a variable followed by `:=`, or a request
of a method whose name ends with `:=`. In both cases the `:=` is
followed by a single argument, which need not be surrounded by
parentheses. Spaces are optional before and after the
`:=`.

#### Examples

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
two different operator symbols to appear in an expression without
parenthesis to indicate order of evaluation. The same operator symbol
can be requested more than once without parenthesis; such expressions
are evaluated left-to-right.

Four binary operators do have precedence defined between them: `/` and
`*` bind more tightly than `+` and `-`.

#### Examples

    1 + 2 + 3                  // evaluates to 6
    1 + (2 * 3)                // evaluates to 7
    (1 + 2) * 3                // evaluates to 9
    1 + 2 * 3                  // evaluates to 7
    1 +*+ 4 -*- 4              // precedence error

Named method requests without arguments bind more tightly than operator
requests. The following examples show the Grace expressions on the left,
and the parse on the right.

#### Examples

  ----------------------------- ---------------------------
  `1 + 2.i`                     `1 + (2.i)`
  `(a * a) + (b * b).sqrt`      `(a * a) + ((b *b).sqrt)`
  `((a * a) + (b * b)).sqrt `   `((a * a) + (b *b)).sqrt`
  `a * a + b * b`               `(a * a) + (b *b)`
  `a + b + c`                   `(a + b) + c`
  `a - b - c`                   `(a - b) - c`
  ----------------------------- ---------------------------

## Unary Prefix Operator Requests

Grace supports unary methods named by operator symbols that precede the
explicit receiver. (Since binary operator methods must have an
explicit receiver, there is no syntactic ambiguity.)

Prefix operators bind less tightly than named method requests, and more
tightly than binary operator requests.

#### Examples

    -3 + 4
    (-b).squared
    -(b.squared)
    - b.squared     // parses as -(b.squared)

    status.ok :=  !engine.isOnFire && wings.areAttached && isOnCourse


## Requesting Methods with Type Parameters

Methods that have type parameters may be requested with or without
explicit type arguments. If type arguments are supplied there must be
the same number of arguments as there are parameters. If type
arguments are omitted, they are assumed to be type `Unknown`.



#### Examples

    sumSq<Integer64>(10.i64, 20.i64) 

    sumSq(10.i64, 20.i64) 


## Manifest Expressions

Types, annotations, and the parent arguments to `inherit` and `use`
clauses must be _manifest_: that is they must be able to be determined
before a program begins running. Requests for types and annotations
must return manifest type and annotation objects respectively, while
parent arguments must return the results of manifest object constructors.

 1. [Numbers], [Lineups], [Strings], and [Objects] are manifest expressions.
 2. [Implicit Requests] and  [Outer] requests resolving to manifest
 declarations in surrounding method scopes, the module, or the
 dialect, are manifest.
 4. Explicit requests are manifest if the receiver is manifest
 and if they resolve to a manifest declaration.
 5. A method is manifest if it uniquely tail-returns a manifest
 expression.  Thus, class and trait declarations are manifest.
 6. [Constant](Constants) and [Type](Types) declarations, and 
imported [Modules]' nicknames are manifest declarations.
 7. `self` and `outer` are not manifest expressions.

Note that [Variables], method parameters, and [Self] are not manifest.
Class, trait and method declarations may themselves be manifest, but
they will not be able to be used in manifest expressions if they
are reached by implicit or explicit method requests on `self`.

A dialect may check method declarations with `manifest` annotations to
ensure that they declare methods that would be manifest when requested
on manifest objects.

## Precedence of Method Requests

Grace programs are formally defined by the language’s [Grammar]. The
grammar gives the following precedence levels; lower numbers bind more
tightly.

1.  Numerals and constructors for strings, objects, iterables,
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


# Pattern Matching

Pattern matching is based around `Pattern` objects that respond to the
`match(subject)` request by returning a `MatchResult`, which is either
`false` if the match fails, or a `SuccessfulMatch<R>` object which
behaves like `true` but also supports a `result` request.  All type
objects are Patterns, although there are other Patterns that are not
types.

In particular, in the scope of this `Point` type:

    type Point = {
      x -> Number
      y -> Number
    }

implemented by this class:

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
blocks also conform to  type Pattern, and can be evaluted by
requesting `match(_)` as well as `apply(_)`. When `apply(_)` would
raises a type error because the block's argument would not match its
parameter type, `match(_)` returns false; when `apply(_)` would return
a result `r`, `match(_)` returns a `SuccessfulMatch` object whose
`result` is `r`. 

If a matching block parameter declaration takes the form `_ :
pattern`, then the `_ :` can be omitted, provided the `pattern` here
is either parenthesized, or a string or numeric literal (the delimited
argument rule).

## Self-Matching Objects

The objects created by literals — Strings and Numbers — are patterns that
match themselves. That’s what lets things like this work:

    method fib(n : Number) -> Number {
      match (n) 
        case { 0 -> 0 }
        case { 1 -> 1 }
        case { _ -> fib(n-1) + fib(n-2) }
    }

To match against objects that are not patterns, a library or dialect
can offer to lift any object `o` to a pattern that matches just `o`
by supporting a request such as `Singleton(o)`.

#### Examples

    { 0 -> "Zero" }                        
        // match against a literal constant

    { s:String -> print(s) }    
        // typematch, binding s - identical to block with typed parameter

    { (pi) -> print("Pi = " ++ pi) } 
        // match against the value of an expression - requires parenthesis

    { _ -> print("did not match") }
        // match against placeholder, matches anything



# Exceptions

Grace supports exceptions, which can be raised and caught. Exceptions
are categorized into a hierarchy of `ExceptionKind`s.
At the site where an exceptional situation is detected, an exception is
raised by requesting the `raise` method on an `ExceptionKind` object,
with a string argument explaining the problem.


Raising an exception does two things: it creates an `exception` object
of the specified kind, and terminates the execution of the expression
containing the `raise` request; it is not possible to restart or
resume that execution although reflection or debuggers should have
access to the whole stack at the point the exception is
thrown. Execution continues when the exception is *caught.*

#### Examples

        BoundsError.raise "index {ix} not in range 1..{n}"
        UserException.raise "Oops...!"

## Catching Exceptions

An exception can be caught by a dynamically-enclosing
`try(exp) catch (block 1)`
…`catch(block`n`) finally(finalBlock)`, in which the `block`i
are pattern-matching blocks. More precisely, if an exception is raised
during the evaluation of the `try` block `exp`, the `catch` blocks
`block`1, `block`2, …`block`n, are attempted in order
until one of them matches the exception. If none of them matches, then
the process of matching the exception continues in the
dynamically-surrounding `try() catch()` …`catch() finally()`. The
`finalBlock` is always executed before control leaves the
`try() catch()` …` catch()` `finally()` construct, whether or not an
exception is raised, or one of the `catch` blocks returns.

Finally clauses can return early, either by executing a `return`, or by
raising an exception. In such a situation, any prior `return` or raised
exception is silently dropped.

#### Examples 

    try {
        def f = file.open("data.store")
    } catch {
        e : NoSuchFile -> print "No Such File"
    } catch {
        e : PermissionError -> print "Permission denied"
    } catch {
        _ : Exception -> print "Unidentified Error"
        system.exit
    } finally {
        f.close
    }


# Types

Grace uses structural typing @Modula3 @malayeri08 @whiteoak08. Types
primarily describe the requests that objects can answer. Fields do not
directly influence types, except that a field that is public, readable
or writable is treated as the appropriate method.

Type declarations are always statically typed, and their semantics may
depend on the static types. 
When they are used "type names" are conceptually [Manifest Expressions]
that return _type objects_. All type objects are also patterns, so
they can be used in [Pattern Matching], typically to perform dynamic
type tests. On the other hand, because they are manifest, types can be
checked statically.

## Predeclared Types

A number of types are declared in the standard prelude and included in
most dialects, including `None`, `Done`, `Boolean`, `Object`,
`Number`, `String`, `Block`, `Stream`, `Pattern`, `Exception`, and
`ExceptionKind`.  Some paticular types are treated specially:

### type Object

The type ``Object`` declares a number of methods to which most normal
objects will respond --- the [Default Methods] declared in
`graceObject`. Some objects, notably instances of raw traits and
`done` do not conform to ``Object``.

### type Self 

The type ``Self`` represents the public interface of the current
object.

### type Unknown 

The type `Unknown` prevents type checking. Any object matches
type unknown, and messages sent to Unknown can only be checked at
runtime. Unknown can either be written explicitly in declarations,
or types can be omitted altogether, in which case the type is
considered to be _implicitly_ `Unknown`

#### Examples

    var x : Unknown := 5  //who knows what the type is 
    var x := 5            //same here, but Unknown is implicit
    x := "five"           //who cares
    x.gilad               //almost certainly crash at run time

    method id(x) { x }    //argument and return types both implicitly unknown
    method id(x : Unknown) -> Unknown { x }  // same thing, explicitly  


## Interface Types

Types define the interface of objects by detailing their public methods,
and the types of the arguments and results of those methods. Types can
contain definitions of other types to describe types nested
inside objects.

The various `Cat` object and class descriptions (see
[Objects, Classes, and Traits]) would create objects that conform to an interface
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

## Type Declarations

Types—and parameterized types—may be named in type declarations:

    type MyCatType = { 
       color -> Colour
       name -> String 
    } 
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
everything else.

    type MyParametricType = type <A,B>
     {
        at (_:A) put (_:B) -> Boolean  
        cleanup(_:B)
     }

## Type Conformance

The key relation between types is **conformance**. We write `B <: A`
to mean B conforms to A; that is, that B has all of the methods
of A, and perhaps additional methods (and that the corresponding methods
have conforming signatures). This can also be read as “B is a subtype of
A”, “A is a supertype of B”.

We now define the conformance relation more rigorously. This section
draws heavily on the wording of the Modula-3 report @Modula3.

If B `<:` A, then every object of type B is also an object
of type A. The converse does not apply.

If A and B are ground object types, then B `<:` A iff for
every method m in A, there is a corresponding method `m` (with the same
name) in B such that

-   The method `m` in B must have the same number of arguments as `m` in
    A, with the same distribution in multi-part method names.

-   If the method `m` in A has signature “`(P1,...Pn) -> R`, and
    `m` in B has signature “`(Q1,...Qn) -> S`”, then

    -   parameter types must be contravariant: `Pi <: Qi`

    -   results types must be covariant: `S <: R`

The conformance relationship is used in `where` clauses to constrain
type parameters of classes and methods.

## Composite types

Grace offers a number of operators to build up composite types.

### Variant Types

Variables with untagged, retained variant types, written
`T1 | T2 ... | Tn `, may refer to an object of any one of their
component types. No *objects* actually have variant types, only
expressions. The actual type of an object referred to by a variant
variable can be determined using that object’s reified type information.

The only methods that may be requested via a variant type are methods
with exactly the same declaration across all members of the variant.

Variant types are retained as variants: they are *not* equivalent to the
object type that describes all common methods. This is so that the
exhaustiveness of match/case statements can be determined statically.
Thus the rules for conformance are more restrictive:

``` 
S <: (S | T);    T <: (S | T) 
(S' <: S) & (T' <: T)  ==>  (S' | T')  <: (S | T) 
```

To illustrates the limitations of variant types, suppose

    type S = {m: A -> B, n:C -> D}
    type T = {m: A -> B, k: E -> F}
    type U = {m: A -> B}

Then `U` fails to conform to `S | T` even though `U` contains all
methods contained in both `S` and `T`.

### Intersection Types

An object conforms to an Intersection type, written
`T1 & T2 & ... & Tn`, if and only if that object conforms to all of the
component types. The main use of intersection types is for augmenting
types with new operations, and as as bounds on `where` clauses.

``` 
U <: S; U <: T; ==> U <: (S & T)
(S & T) <: S;    (S & T) <: T 
```

#### Examples

    type List<T> = Sequence<T> & type {
        add(_:T) -> List<T>
        remove(_:T) -> List<T>
    }

    class happy<T>(param: T) -> Done
       where T <: (Comparable<T> & Printable & Happyable) {     
               ...
    }

### Union Types

Structural union types (sum types), written `1 + `2 + ... + Tn\*, are
the dual of intersection types. A union type `T1 + T2` has the interface
common to `T1` and `T2`. Thus, a type `U` conforms to `T1 + T2` if it
has a method that conforms to each of the methods common to `T1` and
`T2`. Unions are mostly included for completeness: variant types subsume
most uses.


``` 
S <: (S + T);    T <: (S + T)
```


### Type Subtraction

A type subtraction, written `T1 - T2` has the interface of `T1` without
any of the methods in `T2`.

```
interface(S - T) = interface(S) - interface(T) 
```


### Singleton Types

To keep track of individual objects (especially in variants) a library
or dialect can offer to lift any object `o` to a type just `o` by
supporting a manifest request such as `Singleton(o)` and treating the
result as a type.  Singleton types match only their singleton object.

    def null = object { 
        method isNull -> Boolean {return true} 
    }

    type Some<T> { 
        thing -> T 
        isNull -> Boolean
    }

    type Option<T> = Some<T> | Singleton(null)


```
singleton(o) <: S  if (o : T) && (T <: S)
x : singleton(o)   if x == o
```

### Nested Types

Type definitions may be nested inside other expressions, for example,
they may be defined inside object, class, method, and other type
definitions, and typically accessed via [Manifest Requests].
This allows types to be declared and imported from
across modules, since modules are manifest objects.

### Type Assertions

Type assertions can be used to check conformance and equality of
types.

    assert {B <: A}  
       // B 'conforms to' A.
    assert {B <: type {foo(_:C) -> D} }
       // B had better have a foo method from C returning D
    assert {B == A | C}


# Modules and Dialects 

Grace programs can be divided into multiple modules. 

## Modules

A module is typically defined in a single Grace file. The text of the
file is treated as the body of an object constructor, so it may
contain any declarations and executable code. When a module is loaded,
its code is executed, resulting in a _module object_.

Modules may begin with one or more `import "module" as nickname`
statements, naming a module to be imported and giving a _nickname_
that can be used to refer to the module object in the rest of the
importing module. Because modules are just objects, public
declarations at the top level of imported modules are requested simply
by requesting a method on the module's nickname.

Grace programs may be executed by choosing one module as an entry
point to run in the operating system. Grace will the load and
initialise all transitively imported modules in depth-first order,
thus executing the "main" module _last_, after all its dependencies
are loaded. Each individual module is loaded only once, the first time
it is reached: importing the same module name again results in the same
module object. 

Circular module dependencies are errors.

##### Examples

cat.grace module:
````
import "animal" as a 
print "initialising cat module" 
class cat {
  inherit a.animal
  method species { "Cat" } 
}
print "cat module done" 
````

animal.grace module:
````
print "initialising animal module" 
class animal {
  method asString { "I am a {species}" }
  method species { "Random Animal" }
}
print "animal module done" 
````

will print:

````
initialising animal module
animal module done
initialising cat module
cat module done
````

## Dialects 

Grace dialects support language levels for teaching, and
domain-specific little languages. A module may begin with a dialect
statement `dialect "name"`: this imports the dialect like any other
module, but then arranges that the dialect's module object
lexically encloses the object defined by the module. This means that
[Implicit Requests] in the module can resolve to the definitions in
the dialect. 

Many features built in to other programming languages are obtained
from dialects in Grace: this includes all preexisting type
declarations, classes, traits, control structures, and even the
'graceObject' trait that defines the default methods.

Modules that do not declare a 'dialect' implicitly belong to the
`standardPrelude` dialect: the definition of _Standard Grace_.

##### Examples

The `bcpl.grace` module declares an "`unless(_)do(_)`" control
structure that is like `if`, but backwards. 

bcpl.grace module:
````
method do (block : Block) unless (test : Boolean)  {
    if (!test) then (block)
}
````

A module written in that dialect can use that control structure as if
it was built in:

example.grace module:
````
dialect "bcpl"
import "file" as f

def myfile = f.openFile "foo.txt"
do {  print "Can't open file" }  unless (myfile.isOpen) 

````



## Module and Dialect Scopes

Moving out from module scope, Grace programs can access the following scopes:

1. **module scope** containing all declarations at the top level of
a module. 

2. **surrounding module scope** containing the nicknames introduced by
`import` declarations.

3. **dialect scope** containing all declarations at the top level of
a module. 

Lexical lookup stops at the module's dialect scope: it does not extend
to the surrounding dialect's scope (containing any nicknames
introduced by imports in the module); nor to the scopes of e.g. any
dialects used to implement the dialect module.

This allows dialects to import modules, and to be defined via other
(module-defining) dialects, without those other definitions polluting
the language defined by the dialect.

# Pragmatics

The distribution medium for Grace programs, objects, and libraries is
Grace source code.

Grace source files should have the file extension `.grace`. If, for any
bizarre reason a trigraph extension is required, it should be `.grc`

Grace files may start with one or more lines beginning with “`#`”: these
lines are ignored.

## Garbage Collection

Grace implementations should be garbage collected. Points where GC
may occur are at any backwards branch and at any method request.
(Why is this here at all?  What about execution of object constrictors, which 
will presumably trigger allocation?)

Grace will not support finalization.

## Concurrency

The core Grace specification does not describe a concurrent language.
Different concurrency models may be provided as dialects.

Grace does not provide overall sequential consistency. Rather, Grace
provides sequential consistency within a single thread. Across threads,
any value that is read has been written by some thread sometime—but
Grace does not provide any stronger guarantee for concurrent operations
that interfere.

Grace’s memory model should support efficient execution on architectures
with Total Store Ordering (TSO).

# Acknowledgements

Thanks to Josh Bloch, Cay Horstmann, Michael Kölling, Doug Lea, Ewan
Tempero, and the participants at the Grace Design Workshops and the
IFIP WG2.16 Programming Language Design for discussions about the
language design.

The Scala language specification 2.8 @scala28 and the Newspeak language
specification 0.05 @newspeak005 were used as references for early
versions of this document. The design of Grace (so far!) has been
influenced by Algol @algolPerlis [@algolNaur], AmbientTalk @ambientTalk,
AspectJ @aspectJecoop, BCPL @BCPLBOOK [@cpl2bcpl], Beta @betabook, Blue
@BlueSIGCSE95 [@BlueSIGCSE96; @BlueSpec], Brainfuck @brainfuckLanguage, C @Cbook, C$++$ @cppnotoo,
C$\sharp$ @Csharp3 [@Csharp4], Ceylon @Ceylon, Dart @dart, Dylan @dylan, E [@E]Eiffel @oosc [@eiffel],
Emerald @Black2007, $F_1$ @LucaTypeSystems, $F\sharp$ @fsharp, FORTH
@FORTH, $FGJ$ @igarashi01, $FJ\vee$ @igarashi07, FORTRESS @fortress10b, gBeta
@fampoly, Go @Go, Haskell @haskellHistory, IGJ @AlexIGJ, INTERCAL
@INTERCAL, Java @mrBunny [@JavaConcur], Jigsaw
[@Jigsaw], Kevo @anteroCloning, Lua @lua, Lisp @goodBadUgly, ML @ml, Modula-2 @Modula2,
Modula-3 @Modula3, Modular Smalltalk @ModularSmalltalk, Newspeak
@brachamodules [@newspeak005], Noney @malayeri08, O'CAML @OCAML, the Object Calculus
@AbadiCardelli, Pascal @Pascal, Perl @perltalk, Quorun @Quorum, Racket
@HowToDesignPrograms, Scala @SCA [@scala28], Scheme @scheme, Self
@selfpower, Smalltalk @bluebook [@Ingalls81; @Budd1987; @strongtalk],
TrumpScript @TrumpScript, 
Turing @OOTuring,  
U2 @someLanguageBeginningWithU,
VDM @VDM (or VC++ @VC++),
Whiteoak @whiteoak08, Whitespace @whitespaceLanguage,
XTend @XTend, 
yes @UnixYesCommand,
and Z @Zed 
at least: we apologise if we’ve missed any languages out.
All the good ideas come from these languages: the bad ideas are our
responsibility @HoareHints.

Grammar
=======

_(to be attached one James works out how to do it)_
