---
title: The Regular Expression Module
keywords: regular expression, regex, reg ex, pattern
sidebar: modules_sidebar
permalink: /modules/regex/
toc: false
folder: Modules
author:
- 'Andrew P. Black'
---

Regular expressions are useful for searching in strings, when the substring being 
sought is not a constant, but some sort of patten, such as a number, followed by a period, followed by a sequence of one or more letters, all at the start of a line.

## Creating A Regular Expression

The *regularExpresson* module can be imported using `import "regularExpression" as re`, for any identifier `re` of your choice. 
The object `re` will then respond to the following requests, both of
which create a regular expression.

```
fromString(regEx:String)
    // returns a regular expression defined by regEx.  Most characters in
    // regEx will match themsleves, but certain characters have special meaning, 
    // as described by the table below. The regex will perform a non-global,
    // case-sensitive match; to modify this, use the following request.
    
fromString(regEx:String) modifiers(modifiers:String)
    // returns a regular expression defined by regEx with modifiers, as defiend below.
```


### Modifiers


By defualt, searches stop after the first match, and are case-sensitive.
One, two or three of the following modifier characters can be used to define
regular expressions that perform modified searches.

| Modifier | Description
|:-----------|:------------------------------------------------------------------------------------
| g | Perform a global match (find all matches rather than stopping after the first match)
|  i  | Perform case-insensitive matching
|  m |  Perform "multiline" matching: ^ and \$ match at the beginning at end of each line

### Brackets

Brackets are used to find a range of characters; parentheses are used for grouping.

|  Expression |   Description
|:-------------|:-----------------------------
|  \[abc\]     |    Matches any character between the brackets
|  \[^abc\]  |   Matches any character *not* between the brackets
|  \[0-9\]      |   Matches any character in the range 0–9 (any digit)
|  \[^0-9\]  |    Matches any character *not* in the range 0–9 (any non-digit)
|  (x\|y)        |   Matches anything matching the regualr expressions *x* or *y*

### Metacharacters


Metacharacters are characters with a special meaning.  Many of them are introduced by a
slash (`\`) character.  Since `\` in a quoted string introduces a string escape, 
it is suggested that patterns containing these metacharacters be written as 
uninterpreted strings between `‹` and `›`.
If you write strings between `"` and `"`, then `\` must be written as `\\`.

| Metacharacter    |  Description
|:------------------- |: ----------------------
| .                  | Matches any single character except newline or line terminator
| \\w           | Matches a word character: a–z, A–Z, 0–9, or _ (underscore) 
| \\W       | Matches a non-word character
| \\d              | Matches a digit
| \\D          | Matches a non-digit character
| \\s         | Matches a whitespace character: space, tab, CR, LF, VT or FF
| \\S     | Matches a non-whitespace character
| \\b              | Matches a match at the start or end of a word, so \\bHI matches words beginning with *HI*, and HI\\b matches words ending with *HI*
| \\B          | Matches a match, but not at the beginning/end of a word
| \\0                | Matches a NUL character
| \\n            | Matches a new line (LF) character
| \\f           | Matches a form feed (FF) character
| \\r     | Matches a carriage return (CR) character
| \\t                | Matches a tab character
| \\v               | Matches a vertical tab (VT) character
| \\ddd            | Matches the character specified by the octal number *ddd*
| \\xdd              | Matches the character specified by the hexadecimal number *dd*
| \\udddd    | Matches the Unicode character with the hexadecimal codepoint *dddd*

### Quantifiers


| Quantifier | Description
|:--------     |:----------------------------------------------------------------------------------------------------
| n+         | Matches any string that contains at least one *n*
| n\*       | Matches any string that contains zero or more occurrences of *n*
| n?         | Matches any string that contains zero or one occurrences of *n*
| n{X}            | Matches any string that contains a sequence of *X* *n*'s
| n{X,Y}         | Matches any string that contains a sequence of *X* to *Y* *n*'s
| n{X,}      | Matches any string that contains a sequence of at least *X* *n*'s
| n\$        | Matches any string with *n* at the end of it
| ^n         | Matches any string with *n* at the beginning of it
| ?=n        | Matches any string that is followed by *n*
| ?!n    | Matches any string that is *not* followed by *n*
  
## Using Regular Expressions

Once a regular expression has been created, the following requests can be made on it.
```
matches(text:String) → Boolean
    // answers true if the receiver matches text, and false if it does not
        
firstMatchingPosition⟦T⟧(text:String) ifNone(noMatchBlock:Function0⟦T⟧) → Number | T
    // answers the index of the first substring of text that matches the receiver
    
firstMatchingString⟦T⟧(text:String) ifNone(noMatchBlock:Function0⟦T⟧) → String | T
    // answers the first substring of text that matches the receiver
    
allMatches(text:String) → Collection ⟦MatchResult⟧
    // answers a collection containing all the substrings of text that match the receiver.
    // Each element is a MatchResult object that describes one match
    
type MatchResult = interface {
    position → Number        // the index at which the matching text starts
    group(i:Number) → String // i is an integer; returns the text matching the
                             // i_th parenthesized matching group, 
                             // or raises BoundsError if there is no such group.
    whole → String           // returns the whole of the matching text
}
```
  

### Acknowlegements


The regular expression facility in Grace is implemented using the JavaScript Regular Expression system.
This documentation page is based on the 
[w3schools.com documentation page](https://www.w3schools.com/jsref/jsref_obj_regexp.asp)
for JavaScript regular expressions.
