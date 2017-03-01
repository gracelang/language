---
title: The option Module
keywords: Maybe, Option, variant, null, nil, singleton
summary: "Option objects provide a way of dealing with values that may or may not be present.  The option module provides two constrcutors for option objects: full(_) and empty"
sidebar: modules_sidebar
permalink: /modules/option/
author:
- 'Andrew P. Black'
toc: false
folder: Modules
---

## Accessing the option module

The *option* module object can be imported using
`import "option" as option`, where `option` is an identifier of your choice.
The object `option` responds to the following requests.

```
type Option⟦T⟧ = Collection⟦T⟧ & type {
    value → T
    valueIfEmpty⟦U⟧ (eValue:Block0⟦U⟧) → T | U
    isFull → Boolean
    isEmpty → Boolean
    ifFull⟦U⟧ (fAction:Block1⟦T, U⟧) ifEmpty (eAction:Block0⟦U⟧) → U
    ifEmpty⟦U⟧ (eAction:Block0⟦U⟧) ifFull (fAction:Block1⟦T, U⟧) → U
        // same semantics as ifFull(fAction) ifEmpty (eAction), but lets the 
        // programmer write the actions in the opposite order.
    ifFull (fAction:Block1⟦T, Done⟧) → Done
        // same semantics as ifFull (fAction) ifEmpty {done}
    ifEmpty (eAction:Block0⟦Done⟧) → Done
        // same semantics as ifFull (done) ifEmpty (eAction)
}

ValueError → ExceptionKind

full⟦T⟧(contents:T) → Option⟦T⟧
// creates an object s such that s.value and s.valueIfEmpty{...} answer contents, 
// isFull answers true and isEmpty answers false.
// ifFull(fAction) ifEmpty (_) applies fAction to contents and returns its result.
// The object s also behaves exactly like a collection containing the single
// element contents, so, for example, s.do(action) applies action to contents.

empty⟦T⟧ → Option⟦T⟧ 
// creates an object s such that s.value raises a ValueError, and 
// s.valueIfEmpty { expr } executes expr and returns its value; 
// isFull returns false and isEmpty return true.
// ifFull (_) ifEmpty (eAction) executes eAction and returns its result.
// The object s also behaves exactly like an empty collection,
// so, for example, s.do(_) does nothing. 

```

## Usage

Option objects provide a way of dealing with values that
may not be present. For example, if specifying a color is
optional, a variable `c` that holds the choice of color might 
take a value that is an `option.Option⟦Color⟧`.  
When deciding how to paint an object, client code might then
write something like
```
    paintWithColor(c.valueIfEmpty {randomColor})
```

If `c` is filled with a color, this has the effect of painting with that color; 
otherwise, it paints with a `randomColor`.

## Alternatives 

An alternative to using an option object is to create an 
application-specific default value, e.g., `defaultColor`.
This object can then be given application-specific 
method, so that in most cases there is no need to test the
value.  Another alternative is to use a singleton object,
such as `noColor`, and an explicit `match(_)case(_)…` to check 
whether `c` is `noColor`or a real color.

