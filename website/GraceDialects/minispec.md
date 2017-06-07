---
title: The Minispec Dialect
keywords: BDD, behaviour-driven development, behaviour-driven design, behavior-driven development, behavior-driven design, specification, test, dialect
summary: "The dialect “minispec” used to specify the behaviour of Grace modules.  It helps you practice Behaviour-Driven Development (BDD)."
sidebar: dialects_sidebar
permalink: /dialects/minispec/
author:
- 'Andrew P. Black'
toc: false
folder: Dialects
---


## Specifying your design using _Minispec_


*minispec* is a specification dialect for Grace. It is intended to introduce students to the process of specifying the behaviour of their software. This document illustrates how to use it.

### An Example


The best way to explain how to use *minispec* is by example.  We will show how to use *minispec* to describe 
a small fragment of the behaviour of Grace's string objects.

    dialect "minispec"

    describe "strings" with {
        def greeting = "Hello, "
        def emptyString = ""

        specify "the size of the empty string" by {
            expect (emptyString.size) toBe 0
        }
        
        specify "the size of a string is the number of characters that it contains" by {
            def noun = "earthling"
            expect (noun.size) toBe 9
        }
        
        specify "asUpper creates an upper-case string" by {
            expect (greeting.asUpper) toBe "HELLO, "
        }
        
        specify "asUpper does not modify the receiver" by {
            greeting.asUpper
            expect (greeting) toBe "Hello, "
        }
        
        specify "contains is true when the receiver contains another string" by {
            def subString = "fox"
            def receiver = "The quick brown fox jumped."
            expect (receiver.contains(subString)) toBe true orSay 
                "{receiver.asDebugString}.contains({subString.asDebugString}) should be true"
        }
    }

Line 1 says that this module is written in the dialect *minispec*. 
Line 3 builds a *description*: a collection of specifications, here just five.
A description can
also contain definitions, variable declarations, and executable code, as
seen on lines 4–5.

Unsurprisingly, each `specify` statement _specifies_ something: a _fact_, which is
described by a string after the word `specify`.  It also contains a block of
code, which states some expectations about the behavior of the module being specified.
These expectations make precise the _fact_ described by the string. 

Any definitions and declarations in the `describe` block are evaluated afresh
for each specify statement.  This is important; it means that each specification
is independent of the others, and can be understood isolation.

When the _minispec_ module is executed, the expectations in all of the specify statements
are used to verify that the actual behavior of the module is correct.


The description above will produce the output

    strings: 5 run, 0 failed, 0 errors

### What’s in a Specification?


Typically, a specification contains zero, one or two lines of code to set up a
specifiable situation, and then one or more *expectations* that state what
you expect the code being specified to do. Here are the
things that you can expect.


    method expect (cond:Boolean) orSay (complaint:String) {
        // expects cond to be true; if not, minispec will complain with complaint
        // equivalent to expect (cond) toBe true orSay (complaint)
    }

    method expect(s1:Object) toBe (s2:Object) {
        // expects s1 == s2;  complains with a default message otherwise. 
    }

    method expect(s1:Object) toBe (s2:Object) orSay (complaint:String) {
        // expects s1 == s2;  complains with complaint otherwise. 
    }

    method expect(b:Object) orSay (complaint:String) {
        // expects b to be true;  complains with complaint otherwise. 
    }

    method expect(s1:Object) notToBe (s2:Object) {
        // expects s1 ≠ s2;  complains with a default message otherwise. 
    }

    method expect(s1:Object) notToBe (s2:Object) orSay (complaint:String) {
        // expects s1 ≠ s2;  complains with complaint otherwise. 
    }

    method expect(n1:Number) toBe (n2:Number) within (epsilon:Number) {
        // expects n1 and n2 to be approximately equal, i.e., to differ by less than epsilon
    }

    method expect(b:Block) toRaise (desired:ExceptionKind) {
        // expects the execution of b to raise the desired ExceptionKind.
    }

    method expect(b:Block) notToRaise (undesired:ExceptionKind) {
        // expects the execution of b not to raise the undesired ExceptionKind;
        // it might raise some other kind of exception, or no exception at all
    }

    method expect(s:Object) toHaveType (desired:Type) {
        // expects s to have type desired; if it does not, the complaint will tell
        // you which methods are missing
    }

    method expect(s:Object) notToHaveType (undesired:Type) {
        // expects s not to have type undesired.
    }

    method failAndSay(reason:String) {
        // always causes the specification to fail, complaining with reason
    }

## Writing a Specification

The golden rule is to keep the specifications simple. Remember, the idea of an
executable specification is not so much to check that
the code in the module being specified works, but to define *what it means* for
the code to work. Hence, the readability of the specification is of utmost
importance.

It’s also important for the specifications to depend only on the defined external
behaviour of the code being specified, and *not* on implementation decisions
that might change. So, for example, if the result is a Set, your test
should not depend on the order in which the elements appear.  In fact, 
if it is possible that some future implementation might return
a List, you might _specify_ merely that the result is a Collection.

Each `specify` statement should specify a single property.  Consider, for example,
the specification of `asUpper`

        specify "asUpper creates an upper-case string" by {
            expect (greeting.asUpper) toBe "HELLO, "
        }
        
This specifies what `asUpper` returns, but not its effect. We can specify its effect
separately:

        specify "asUpper does not change the receiver" by {
            greeting.asUpper
            expect (greeting) toBe "Hello, "
        }

### What happens when you execute a *minispec* module?

Executing the above module will run all of the specifications and print a summary
of the results. In general, one of three things might happen when a specification
runs.

1.  The specification *passes*, that is, all of the expectations that it makes
    are true.

2.  The specification *fails*, that is, one of the expectations is false. (A specification
    that does not make any expectations is also deemed to fail.)

3.  The specification reveals an *error*, that is, a runtime error occurs that prevents
    the specification from completing. For example, the specification, 
    or the code being specified, may request a method
    that does not exist in the receiver, or might index an array out
    of bounds.

In all cases, *minispec* will record the outcome, *and then go on to run
the next specification*. This is important, because we generally want to be able
to run a suite of specifications, and see how many pass, rather than have checking
stop on the first error or failure. For example, if we add this specify 
statement 


    specify "a string method that does not exist" by {
        expect (greeting.sort) toBe " ,Hello"
    }

to the _string_ specification at the top of this page, we get the output

    strings: 6 run, 0 failed, 1 error
    Errors:
        a string method that does not exist: NoSuchMethod: no method sort on string Hello, .  Did you mean ord?

    Re-running 1 error.

    debugging method a string method that does not exist ...
    NoSuchMethod on line 33: no method sort on string Hello, .  Did you mean ord?
      called from block.apply at line 33 of minispec
      called from specify(_)by(_) at line 109 of minispec
      called from block.apply at line 32 of minispec
      called from testCaseNamed(_)setupIn(_)asTestNumber(_).setup at line 122 of minispec
      called from block.apply at line 201 of try(_)catch(_)...finally(_)
      called from block.apply in method try(_)catch(_)...finally(_)

Note that even though the specification of _a string method that does not exist_
errored, *minispec* went on to check the remaining specifications.

### Limiting the output form Erroneous Specifications.

As the example above shows, when a specification reveals an error, _minispec_ will
run it again, and on this second run will capture and print Grace's usual _backtrace_.
This may or may not be useful;  if the error is deep within the module being specified,
it can be quite useful, but in the case where it is in the specification itself, as in this
example, it is not.

If there are many errors in the specification or the module being specified, 
the output can be quite voluminous.  By default,  _minispec_ will re-run 10 errors.
You can change this by assigning to the variable `numberOfErrorsToRerun`.  For example,
if you add 

    numberOfErrorsToRerun := 0
    
to the above specification (_before_ the `describe` statement), then no 
specifications will be re-run.

### Further Reading

If you want more information about executable specifications, Google 
"Behaviour-Driven Development" (BDD for short).


