---
title: The Minispec Dialect
keywords: BDD, behavior-driven-development, specification, test, dialect
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


The best way to explain how to use *minispec* is by example.  We will show how to use *minispec* to describe the behaviour of Graces' string objects.

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
written as a string after the word `specify`.  It also contains a block of
code, which must state some expectations about the behavior of the module being specified.
Any definitions and declarations in the `describe` block are evaluated afresh
for each specify statement.

When the _minispec_ module is executed, the expectations in all of the specify statements
are used to verify that the actual behavior of the module is correct.


This will produce the output

    for()and: 2 run, 0 failed, 0 errors
    match tests: 3 run, 0 failed, 0 errors

### What’s in a test?


Typically, a test contains zero, one or two lines of code to set up a
testable situation, and then one or more *assertions*. Here are the
things that you can assert.


        assert (bb: Boolean) description (message)
        // asserts that bb is true.   If bb is not true, the test will fail with message

        deny (bb: Boolean) description (message)
        // asserts that bb is false.   If bb is not false, the test will fail with message

        assert (bb: Boolean)
        deny (bb: Boolean)
        // short forms, with the default message "assertion failure"

        assert (s1:Object) shouldBe (s2:Object)
        // like assert (s1 == s2), but with a more appropriate default message.  Uses the == method of s1.

        assert (s1:Object) shouldntBe (s2:Object)
        // like assert (s1 != s2), but with a more appropriate default message. Uses the != method of s1.

        assert (block0) shouldRaise (desiredException)
        // asserts that the desiredException is raised during the execution of block0

        assert(n1:Number) shouldEqual (n2:Number) within (epsilon:Number)
        // asserts that n1 and n2 don't differ by more than epsilon.
        // Use instead of assert(_)shouldBe(_) for floating point numbers.
        assert (block0) shouldntRaise (undesiredException)
        // asserts that the undesiredException is not raised during the execution of block0.
        // The assertion holds if block0 raises some other exception, or if it completes
        // execution without raising any exception.

        failBecause (message)
        // always fails; equivalent to assert (false) description (message)

        assert(value:Object) hasType (Desired:Type)
        // asserts that value has all of the methods of type Desired.

        deny(value:Object) hasType (Undesired:Type)
        // asserts that value is missing one of the methods in the type Undesired

The golden rule is to keep the tests simple. In addition to testing that
the code in the module under test works, they define *what it means* for
the code to work. So the readability of the tests is of utmost
importance.

It’s also important for the tests to depend only on the defined external
behaviour of the code under test, and *not* on implementation decisions
that might change. So, for example, if the result is a set, your test
should not depend on the order in which the elements appear when you
request on it.

### What happens when you execute a *minispec* module?


Executing the above module will run all of the tests and print a summary
of the results. In general, one of three things might happen when a test
runs.

1.  The test *passes*, that is, all of the assertions that it makes
    are true.

2.  The test *fails*, that is, one of the assertions is false. (A test that
    does not check any assertions is also deemed to fail.)

3.  The test *errors*[^1], that is, a runtime error occurs that prevents
    the test from completing. For example, the test may request a method
    that does not exist in the receiver, or might index an array out
    of bounds.

In all cases, *minispec* will record the outcome, *and then go on to run
the next test*. This is important, because we generally want to be able
to run a suite of tests, and see how many pass, rather than have testing
stop on the first error or failure. For example, when we run the _set_
test suite at the top of this page, we get the output

    4 run, 0 failed, 1 error
    Errors:
        remove: RuntimeError: undefined value used as argument to at(_)put(_)

Note that even though the test with title *remove* errored, *minispec*
went on to run the remaining tests.

If you want more information about testing, see the documentation for
*gUnit*, Grace’s more comprehensive testing framework, or any of many
excellent books on test-driven development. I particularly recommend
Kent Beck’s *Test Driven Development: By Example*.

[^1]: Yes, I’m using “to error” as a verb. How daring!
