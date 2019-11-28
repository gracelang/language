---
title: The Minitest Dialect
keywords: TDD, test-driven-development, test, dialect
summary: "The dialect “minitest” helps you write and run test cases with low overhead.  It supports the practice of test-driven development (TDD)."  
sidebar: dialects_sidebar
permalink: /dialects/minitest/
author:
- 'Andrew P. Black'
toc: false
folder: Dialects
---


## Testing your code with _Minitest_


*minitest* is a testing dialect for Grace. It is intended to simplify
the process of testing for students beginning to practice Test-Driven
Development. This document illustrates how to use it.

### An Example


The best way to explain how to use *minitest* is by example:

    dialect "minitest"
    import "setVector" as sV

    testSuite {
        def setO = sV.setVector.new
        def set23 = sV.setVector.new
        set23.add 2
        set23.add 3

        test "emptiness" by {
            assert (setO.size == 0) description ("setO is not empty!")
            deny (setO.contains 2) description ("setO contains 2!")
        }
        test "non-emptiness" by {
            assert (set23.size) shouldBe 2
            assert (set23.contains 2)
            assert (set23.contains 3)
        }
        test "remove" by {
            set23.remove 2
            deny (set23.contains 3) description "{set23} contains 3 after it was removed"
        }
        test "duplication" by {
            set23.add 2
            assert (set23.size == 2) description "duplication of 2 not detected by set"
        }
    }

Line 1 says that this module is written in the dialect *minitest*. Line
2 imports the module under test, in this case, a (buggy!) implementation
of sets using vectors, which is in the module *setVector*. Line 4 builds
a *testSuite*: a collection of tests, here just four. A testSuite can
also contain definitions, variable declarations, and executable code, as
seen on lines 5–8.  These are common to all of the tests in the test suite.

As you can see, each test has a title (which is printed out if the test
fails or errors) and a block of code, which should contain one or more
assertions.

When the test module is executed, all of the test in the test suite are
run, in some order. Any variables and definitions inside the testSuite
are _re-initialized before each test_ is run.

You can also put code at the top level of the module, outside of any test suite.
Such code is run just once, when the module is initialized.  This is a good place
to construct any large objects that will be shared by many tests, but not changed.

### Naming TestSuites

If you have more than one test suite in a single module, it’s handy to give each
test suite a name. 
This makes it easy to see how many tests pass in each suite.
To name test suites, use the method `testSuite(_)with(_)`, like this:

<object id="minitest_for_and" data="{{site.editor}}?minitest_for_and" width="100%" height="550px"> </object>

If you run this code, it should produce the output

    for(_)and(_): 2 run, 0 failed, 0 errors
    match tests: 3 run, 0 failed, 0 errors

### What’s in a test?


Typically, a test contains zero, one or two lines of code to set up a
testable situation (this is called the _test fixture_), and then one or more *assertions*. Here are the
things that you can assert.


        assert (bb: Boolean) description (message)
        // asserts that bb is true.   If bb is not true, the test will fail with message

        deny (bb: Boolean) description (message)
        // asserts that bb is false.   If bb is not false, the test will fail with message

        assert (bb: Boolean)
        deny (bb: Boolean)
        // short forms, with the default message "assertion failure"

        assert (s1:Object) shouldBe (s2:Object)
        // like assert (s1 == s2), but with a more appropriate default message.  
        // Uses the == method of s1.

        assert (s1:Object) shouldntBe (s2:Object)
        // like assert (s1 ≠ s2), but with a more appropriate default message. 
        // Uses the ≠ method of s1.

        assert (b:Function0) shouldRaise (desiredException)
        // asserts that desiredException is raised during the execution of the block b
        
        assert (b:Function0) shouldRaise (desiredException) mentioning (str)
        // asserts that desiredException is raised during the execution of the block b,
        // and that the exception's message contains str as a substring. 
        
        assert (b:Function0) shouldRaise (desiredException) mentioning (s1) and (s2)
        // asserts that desiredException is raised during the execution of the block b,
        // and that the exception's message contains both s1 and s2 as substrings. 

        assert(n1:Number) shouldEqual (n2:Number) within (epsilon:Number)
        // asserts that n1 and n2 don't differ by more than epsilon.
        // Use instead of assert(_)shouldBe(_) for floating point numbers.
        
        assert (b:Function0) shouldntRaise (undesiredException)
        // asserts that the undesiredException is not raised during the execution of b.
        // The assertion holds if b raises some other exception, or if it completes
        // without raising any exception.
        // NOTE:  Use this rarely!  If all you need is to check that b does not
        // raise an exception, just write the body of the block in-line: if it does raise
        // an exception, your test will error.  If you want to check that b does raise
        // and exception of a different kind, then use assert(_)shouldRaise(_)...

        failBecause (message)
        // always fails; equivalent to assert (false) description (message)

        assert(value:Object) hasType (Desired:Type)
        // asserts that value has all of the methods of type Desired.

        deny(value:Object) hasType (Undesired:Type)
        // asserts that value is missing one of the methods in the type Undesired
        
        assertType(T:Type) describes (value)
        // asserts that T is a complete description of value, i.e., that all of
        // value's methods are in T

### What's _not_ in a test

The golden rule is to keep the tests simple. In addition to testing that
the code in the module under test works, they define *what it means* for
the code to work. So the readability of the tests is of utmost
importance.  **Do not** put complex conditional code in a test.

Each test should check one property of the module under test.  This usually
means using just one or two assertions.  If there are several properties to check,
write several tests.

It’s also important for the tests to depend only on the defined external
behaviour of the code under test, and *not* on implementation decisions
that might change. So, for example, if the result is a set, your test
should not depend on the order in which the elements appear when you
iterate over it.

Don't make your test depend on trivial details that are likely to change.  Why not?
Because you don't want to spend valuable development time changing tests because,
for example, you correct a punctuation mistake in an error message.
This is where the 

    assert (computation) shouldRaise (ExceptionKind) mentioning (string)
    assert (computation) shouldRaise (ExceptionKind) mentioning (string1) and (string2)

assertion methods can be useful.
Don't insist that the whole wording of the error message is just so.  
Instead, put only the critical phrases in the `mentioning` string(s).

### What happens when you execute a *minitest* module?


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

In all cases, *minitest* will record the outcome, *and then go on to run
the next test*. This is important, because we generally want to be able
to run a suite of tests, and see how many pass, rather than have testing
stop on the first error or failure. For example, when we run the _set_
test suite at the top of this page, we get the output

    4 run, 1 failed, 0 errors
    Failures:
        remove: ⟦SetVector: <Vector: 3>⟧ contains 3 after it was removed

Note that even though the test with title *remove* failed, *minitest*
went on to run the remaining tests.

### Limiting the output from Erroneous Specifications.

When a test reveals an error, _minitest_ will
run it again, and on this second run will capture and print Grace's usual _backtrace_.
This may or may not be useful;  if the error is deep within the module being specified,
it can be quite useful, but in the case where it is in the test itself, it is not.

If there are many errors in the tests or the module under test, 
the output can be quite voluminous.  By default,  _minitest_ will re-run 10 errors.
You can change this by assigning to the variable `numberOfErrorsToRerun`.  For example,
if you add 

    numberOfErrorsToRerun := 0
    
to a test module (_before_ the `testSuite` statement), then no 
tests will be re-run.
You will still see the failure and error reports, but no back-traces.

### Exiting

The minitest dialect defines a method `exit` that will terminate your test module.
It's intended to be used at the end of the module, after all of the tests have run.
If they all passed, `exit` will print `"all tests passed"` and pass exit code `10`
to the calling environment; if any of 
the tests errored or failed, it will print nothing and pass exit code `1`. 
This is helpful in conjunction with scripts that run many test modules. 

### Further Reading

If you want more information about testing, see the documentation for
*gUnit*, Grace’s more comprehensive testing framework, or any of many
excellent books on test-driven development. I particularly recommend
Kent Beck’s *Test Driven Development: By Example*.

[^1]: Yes, I’m using “to error” as a verb. How daring!
