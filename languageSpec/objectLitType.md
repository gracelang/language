---
author:
- 'Andrew P. Black'
- 'Kim B. Bruce'
- 'James Noble'

bibliography:
- 'spec.bib'

title:
    Typing Values in Grace
...

# Introduction

All objects in Grace are created with an associated type.  This type may be consulted when
the object is associated with an identifier; for example, initializing a def, updating a variable,
or associating a formal parameter with the value.  It may also be consulted when returning
an object from a method.

# Associating literal values with types

The Grace prelude defines types like Number, Boolean, and String.  Values resulting from the
evaluation of number literals, e.g., 47 and 3.14, are associated with the type Number. The
values of boolean literals true and false are associated with type Boolean, while the values of
String constructors, e.g., "hello" and "x is {x}", are associated with type String.

# Associating object literals with types

An object literal may contain any number of `def`, `var`, `type`, and `method` declarations as
well as executable code.

```
    object {
        inherit freshObj
            alias ...
            exclude
        use traitObj
            alias ...
            exclude
        def x: T is ax = tval
        ...
        var y: U is ay := uval
        ...
        type V is aV = typeExp
        ...
        method m(s:V) -> T is am {methBody}
        ...
        executableCommnands
    }
```

While classes can also be declared inside object literals, we will assume that
they have been rewritten into methods.  Executable commands have no impact on the
type, so we omit them from now on.  

If the inherit clause is omitted, the system inserts a default `inherit graceObject` which
generates a fresh object of type `Object`, which is a simple interface type.

Type annotations may be left off `def`, `var`, and `method` declarations.  If they are left
off, the system treats missing occurrences as though they have the annotation `Unknown`.
Thus we assume from now on that type annotations are always present

In the above, ax, ay, aV, and am are optional annotations on visibility (encapsulation).  
Grace supports encapsulation annotations `confidential`, `readable`, `writable`, and `public`.  
Method declarations in Grace are by default assumed to have an annotation of confidential while 
def and var declarations are by default confidential.  For simplicity, we assume that
annotations of `public` on `var` declarations are replaced by `readable` and `writable`.
(Only `var` declarations can be annotated `writable`.)
As above, we assume that all visibility annotations are present by filling in the default
values.

We can now associate a type with each object literal expression.  

The type associated with an object literal is assembled into an interface type as follows:

1.  Initialize L to be the (interface) type associated with the inherited "freshObj" expression.  By the
restrictions on inheritance, this will always result from the creation of a fresh object with an 
associated type.  Alias statements associated with an inherit statement are ignored as they only
add confidential names, but an exclude statement results in removing the associated method from the interface.

If a statement of the form ```use exTrait``` occurs in the object literal then the individual method
declarations in the trait are processed as specified below in part 6.  However, if a method 
declared in the trait is listed in an associated delete statement, then it is not processed.

2.  For each public `type` declaration as above, add 
`type V = typeExp` to interface `L`, if it is not already there.  By the restrictions on inheritance, 
any declaration of V already in `L` must be identical to the new one.

3.  For each public or readable `def` as above, add the method type
`x -> T` to interface `L`.  If `L` already contains a method with that name and arity (i.e. originating 
from the type of `freshObj`) then replace the old method by the new one.

4.  For each readable `var` as above, add the method type
`y -> U` to interface `L`.  If `L` already contains a method with that name and arity,
replace the old method by the new one.

5.  For each writable `var` as above, add the method type
`y:=(y':U) -> Done.  If `L` already contains a method with that name and arity,
replace the old method by the new one.

6.  For each public `method` declaration as above, add the method type
`m(s:V) -> T` to interface `L`.  If `L` already contains a method with that name and arity,
replace the old method by the new one.

Notice that the type associated with an object value is always an interface type.  That is,
a value never has a type that is a variant type (though its components may include type annotations
that are themselves variant types).

For example, suppose we have the following object literal:

```
    object {
        type T = {
            c -> Number
            d:=(s:String) -> Done
        }
        def x: Number = 3
        def z: String is public = "hello"
        var a is writable := aVal
        var b: B is public := bVal
        method m(s) -> Done {...}
        method n(t:Number, u: String) -> T is confidential {...}
    }
```
where we have omitted some type and visibility annotations to show how the defaults work.

This object literal would give rise to the following associated type expression:

```
    interface {
         ... method types from Object ...
         type T = {
             c -> Number
             d:=(s:String) -> Done
         }
         z -> String
         a:= (a':Unknown) -> Done
         b -> B
         b:= (b':B) -> Done
         m(s:Unknown) -> Done
    }
```

Recall that classes are syntactic sugar for a method that returns an object created by an object literal
expression.  Thus

```
    class c(x:T) -> U {...}
```
abbreviates 
```
    method c(x:T) -> U {object {...}}
```

As a result, evaluating c(a) will result in an object whose type is associated with the object expression
revealed by removing the syntactic sugar.  Similarly, because modules are implicitly objects, their
associated types are constructed as if the module was wrapped in an object literal.  Import statements
make available the object associated with the module (and its associated type).

While an object's state may be updated during computation, it retains the same assocated type that
it was created with (reflecting the intentions of the programmer in providing the initial type annotations),
even if the updated value of an instance variable is inconsistent with the type declared for that variable
(though we would expect the dynamic type checker to catch most such inconsistencies).

Because all objects are created using one of the above constructs, we see that at run-time all object
values have an associated type.

Notes:

1.  All method types from the built-in `Object` are included because the object literal directly
or indirectly inherits from `graceObject` with type `Object`.

2.  No method type for `def x` is produced because it is (by default) `confidential`.  Similarly 
`method m` is ignored because it is annotated as `confidential`.

3.  Because variable `a` is `writable`, it is represented by method `a:=`.

4.  Variable `b` is `public` so gets a method for both `readable` and `writable` annotations.

5.  Method `m` has no type annotation on parameter s, so its type is `Unknown`.

The type associated with a value is intended to be used to determine run-time errors during the execution
of a Grace program, though different implementations may catch these errors at different points of the
program execution.  Similarly, a dialect with a sound static type system may obviate the need for 
certain run-time checks.


