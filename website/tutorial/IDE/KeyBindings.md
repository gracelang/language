---
title: "Using the Grace Editor"
keywords: find, find & replace, indent, outdent, undo, redo, comment
summary: The Grace editor implements several useful keyboard shortcuts, and a powerful regular-expression search
sidebar: tutorial_sidebar
permalink: /IDE/introduction/
folder: tutorial
---
The text editor in the Grace IDE is not actually part of the Grace
project; it's a separate open-source project called ACE, documented at
<http://ace.c9.io/>.

## Key Bindings

The editor works in basically the same way on Chromebooks,
Macs, Linux and Windows. However, the particular keys that you use for
some actions are different on Mac and Windows. (Chromebooks use
the Windows key bindings). Here is the table of key bindings.

  |----------------------+---------------------------------+---------------------------------
  |**action**            | **Mac binding**                 | **Windows binding**
  |----------------------+---------------------------------+---------------------------------
  |find                  |Command-F                        |Ctrl-F
  |find & replace        |Command-Option-F                 |Ctrl-H
  |find next             |Command-G                        |Ctrl-K
  |find previous         |Command-Shift-G                  |Ctrl-Shift-K
  |indent                |Tab (but only at start of line)  |Tab (but only at start of line)
  |outdent               |Shift-Tab                        |Shift-Tab
  |indent block          |Ctrl-\]                          |Ctrl-\]
  |outdent block         |Ctrl-\[                          |Ctrl-\[
  |undo                  |Command-Z                        |Ctrl-Z
  |redo                  |Command-Shift-Z, or Command-Y    |Ctrl-Shift-Z, or Ctrl-Y
  |comment-out (toggle)  |Command-/                        |Ctrl-/
  |----------------------+---------------------------------+---------------------------------
  |----------------------+---------------------------------+---------------------------------

## Searching

The search function can also be activated by clicking on the search button
just above the text pane; this button and the _find_ and _find & replace_ 
keybindings open the same search dialog box.
 * By default, _search_ ignores the case of letters, so searching for `wombatPaw`
will find `WombatPaw` and `wombatpaw`.  You can make search
case-sensitive by clicking the `Aa` button. 
 * To turn on whole-word
search, which can be useful if you are searching for a variable `n`, but don't
want to find the `n`s in the phrase `kanga and roo`, click the `\\b` button.
 * The default search is a text search, which looks for the text you type in the
 search dialog. You can turn on
"regular expression" search using the `.*` button. 
The regular expression syntax is similar to that of other editors, and 
has the following conventions. 

    -   Most characters other than those listed below search for themselves
    -   \\w searches for a "word" character, i.e., a letter or digit
    -   \\W for a _non_-word character
    -   \\d for a digit
    -   \\D for a non-digit
    -   \\b for a break between words
    -   \[ and \] enclose characters, any of which can match, so `[xy\d]`
        will match an `x`, a `y`, or a digit
    -   ^ matches at the start of a line
    -   \$ matches at the end of a line
    -   ( and ) are used for grouping
    -   | represents the "or" of two other regular expressions, so `a|b`
        matches `a` or `b`
    -   \* means zero or more repetitions of the preceding regular
        expression
    -   \+ means one or more repetitions of the preceding regular expression
    -   ? makes the preceding regular expression optional
    -   \\ preceding a special character cancels its "special" meaning, so
        \\( matches a left parenthesis

    In the replacement text, \$1, \$2, etc., represent the first, second,
    etc., parenthesized regular expression in the search expression.
