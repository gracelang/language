---
title: "Using the Grace Editor"
keywords: find, find & replace, indent, outdent, undo, redo, comment, editor, web-editor, IDE, key bindings, download, upload, funny characters, Unicode, indentation, re-indentation, reindentation, replace, zip.
summary: The Grace Program Editor lets you create and run Grace programs in yor web browser.  It implements keyboard shortcuts, and regular-expression search.
sidebar: tutorial_sidebar
permalink: /IDE/introduction/
folder: tutorial
---

The Grace Program Editor works very much like any other editor: you place the cursor in the
editing window and start typing!  Double-clicking selects a word, and triple-clicking selects the whole
line.  Buttons at the top of the editor page let you **upload** a file into the editor, 
create a **new file**, create a **new folder** to organize your files, **download**
the current file onto your computer, ask for **help** (which takes you to this site), 
**search** (and replace) in the current file, and **delete** the current file. 
You can also rename the current file by typing over the current file name at the top of the editing pane.

## Running Grace Programs

To run your Grace program, click the `Run` bar at the bottom of the editor pane.
If Grace can't undersatnd what you have written, you will see some Red X boxes in the gutter, and probably an orange highlight over the bit of code that confused Grace.
Hovering the pointer over the Red X will show you a message.
Change the code, and try again.

Grace may also send you messages while running your program;
these show up in the "grass-catcher" window below the editor pane.

If your code `import`s another module of yours, you will need to `Run` that module first.

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
search, click the `\b` button.
This can be useful if you are searching for a variable `n`, but don't
want to find the `n`s in the phrase `kanga and roo`, 
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
    
## Funny Characters

Grace defines six equavalencies between pairs of ASCII characters and single Unicode characters.  The web editor will replace these ASCII sequences by the Unicode equivalents.


| ASCII | Unicode 
| :---: | :-----:
| >=    | ≥
| <=    | ≤
| !=    | ≠
| ->    | →
| ]]    | ⟧
| [[    | ⟦

If you don't like this repalcement, you can press the delete key immediatly after the conversion happens, and it will be undone.  There is also a `Replace Unicode` tool in the `Utilities` left sidebar which will replace all six of these Unicode characters by their ASCII equialents everywhere in the current file.

## Uploading and Downloading Files

Although the code in the Grace web editor is stored on your computer, it is not stored in the normal file system.
That is, it is not in the files that you can access from the computer's graphical interface or command line.
So, how do you move code into and out of the file system?

### Uploading: from the Editor to your computer 

If you have been working on some Grace code in the web editor, and want to turn it into a file,
click the `↯ Download` link, found above the top-left corner of the editor pane.
To download to a specific place on your computer, _right-click_ (or _shift-click_)
`↯ Download` and choose `Save Link As…`.
To download a whole folder as a _zip archive_ containing the individual files,
right-click the folder name in the `Files` sidebar, and select `Download`.
There is also a `↯ Download All Files` button in the `Utilities` sidebar.

### Downloading: from your computer to the Editor

If you have a file on your computer's disk that you want to start editing, first make sure that the `Files` sidebar is showing.  Then selct the folder in which you wish the file to be placed (it's name will turn red).  Finally, click the `Upload` button above the list of files, and navigate to the file that you wish to upload.
Note that theere cannot be two files in the web editor with the same name, even if they are in different folders. 

If your instructor gives you code at a web URL, first download that URL to your disk, and then upload into the editor as above.  
If instead you visit the URL with your browser, and copy and paste, you may find that your browser has misinterpreted some the code (for example, the `≠` operator might be turned into `â‰`).
You may be able to fix this by telling your web browser to use the **UTF-8** text encoding, but it's simpler to avoid the problem by downloading to a file.

## Indentation

The Web Editor knows a bit about Grace's indentation rules.
For example, if you end a line with `{`, the Editor will increase the indentation; when you start a line with `}`, the Editor will move it to match the line that contained the corresponding `}`.

If the indentation gets messed up, you can use the `Reindent File` tool in the `Utilities` pane.
However, you should note that _only you_ know where you want a continutaion line.
If your code increases the indentation at a place that is _not_ the start of a block,
the reindentation tool will assume that this marks a continuation line, and indent accordingly.

## The ACE Project

The text editor in the Grace IDE is not actually part of the Grace
project; it is a separate open-source project called ACE, documented at
<http://ace.c9.io/>.
