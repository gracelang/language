---
title: The Beginning Student Dialect
keywords: beginning student, dialect
summary: "The dialect “beginningStudent” simplifies the creation of collections, enforces case conventions, requires type declarations and purpose statements, and includes ”minispec”."
sidebar: dialects_sidebar
permalink: /dialects/beginningStudent/
author:
- 'Andrew P. Black'
toc: false
folder: Dialects
---

## Introduction

The _beginningStudent_ dialect is intended to avoid some challenges that 
beginning students have encountered with Grace.  It makes several changes to 
the [_standardGrace_ dialect]({{site.baseurl}}/dialects/standard).
Other than what is listed below, all of the features of 
[_standardGrace_ dialect]({{site.baseurl}}/dialects/standard)
are available in _beginningStudent_.

## Collections

The collection constructors of _standardGrace_, written with `[` square brackets `]`,
are not present in _beginningStudent_.  Instead, use the following methods:

    list.empty                  // creates an empty list
    list(arg1)                  // creates a list containing the single element arg1
    list(arg1, arg2)            // creates a list containing the two elements arg1 and arg2
    list(arg1, ...)             // as above, but with an arbitrary number of arguments 
    
    sequence.empty              // creates an empty sequence
    sequence(arg1)              // creates a sequence containing the single element arg1
    sequence(arg1, arg2)        // creates a sequence containing the two elements arg1 and arg2
    sequence(arg1, ...)         // as above, but with an arbitrary number of arguments 
    
    set.empty                   // creates an empty set
    set(arg1)                   // creates a set containing the single element arg1
    set(arg1, arg2)             // creates a set containing the two elements arg1 and arg2
    set(arg1, ...)              // as above, but with an arbitrary number of arguments 
    
    dictionary.empty            // creates an empty dictionary
    dictionary(k1::v1)          // creates a dictionary containing the single key k1, with value v1
    dictionary(k1::v1, k2::v2)  // creates a dictionary containing the two keys k1 and k2,
                                // with values v1 and v2, respectively.
    dictionary(k1::v1, ...)     // as above, but with an arbitrary number of arguments 

Once they have been constructed, these collections are identical to those of the
[_standard_ dialect]({{site.baseurl}}/dialects/standard).

## Type are Required

This dialect requires that the programmer specify the types of all method parameters 
and return values, block parameters, and variables in **var** declarations.

## Case Conventions Enforced

This dialect requires that methods and variable names start with a lower-case letter,
and types with an upper-case letter.

## Purpose Statements are Required

This dialect requires that methods have purpose statements, and that these purpose
statements specify the role of the parameters to the method, as well as its return value, if it has one.

## Minispec

The _beginningStudent_ dialect incorporates the [_minispec_ dialect]({{site.baseurl}}/dialects/minispec).
