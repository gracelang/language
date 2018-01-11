---
title: The io module
keywords: io, input, output
sidebar: modules_sidebar
permalink: /modules/io/
toc: false
folder: Modules
author:
- 'Andrew P. Black'
- 'Kim B. Bruce'
---

## Input and Output

The *io* module can be imported using `import "io" as inout`, for any identifier `inout` of your choice. The object `inout` will then respond to the following requests.

```
input -> FileStream        // returns stdin
output -> FileStream       // returns stdout
error -> FileStream        // returns stderr
ask (question:String) -> String
    // asks `question` interactively, and returns the user's answer
    
open (path:String, mode:String) -> FileStream
    // opens path in mode, which is one of the following:
    // "r" - Open file for reading. An exception occurs if the file does not exist.
    // "w" - Open file for writing. The file is created (if it does not exist) or truncated (if it exists).
    // "rw" - Open file for reading and writing. The file is created (if it does not exist)
    //       or truncated (if it exists).
    // "a" - Open file for appending. The file is created if it does not exist.
    //       Appending means that the read–write position is at the end of the file.
    
system (command:String) -> Boolean
    // executes system command, returns true iff exit status is 0
    
exists (path:String) -> Boolean
    // returns true iff path exists in the file system

unlink (path:String) -> Done
    // removes path from the file system; raises an exception if it wasn't there

newer (path1:String, path2:String) -> Boolean
    // returns true iff the file at path1 is newer than the file at path2
    
realpath (path:String) -> String     // returns the absolute path 
    
listdir (dirPath:String) -> Sequence⟦String⟧
    // returns the names of the files in the directory at `dirPath`
    
changeDirectory (dirPath:String)
    // changes the current directory to `dirPath`
    
env -> Dictionary⟦String,String⟧
    // returns a Dictionary mapping names of environment variables to
    // their values
    
spawn (executable:String, args:Collection⟦String⟧) -> Process
    // creates a new Process `executable` using `args` as its arguments
```

The type `FileStream` describes the interface of an opened file.  Notice that `FileStream` conforms to `Iterator`, so a FileStream can also be treated like an Iterator.

```
type FileStream = Object & type {
    read -> String
        // returns the whole contents of the underlying file.
        // ignores the position of the read-write pointer, and does not change it.
    size -> Number
        // returns the total number of characters in this stream.
        // This is the size of the string returned by read, not the number of characters remaining.
    hasNext -> Boolean
        // returns true if next will return a character,
        // and false if it will raise an exception.
    next -> String
        // returns the next character from the file.
        // Raises IteratorExhausted if there are are no more characters to be read.
    nextLine -> String
        // returns the next line in the file, up to and including the next
        // newline, or the end of the file.  The newline character itself 
        // is not part of the result.
        // Raises IteratorExhausted if there are no more lines to be read.
    write (s:String) -> Done
        // writes s to the file at the current position of the read-write
        // pointer. Writes will not appear on the file until the FileStream is
        // closed.  As a special case, writes to the output window in the
        // Grace editor will also appear after a newline has been written.
    close -> Done
        // closes the stream.  Output is pushed to its destination, and further
        // writes will raise an exception.
    seek (n: Number) -> FileStream
        // moves the read position to n
    seekForward (n:Number) -> FileStream
        // moves the read/write position forward by n
    seekBackward (n:Number) -> FileStream
        // moved the read/write position backward by n
    iterator -> FileStream
        // returns self
    pathname -> String
        // the name of the file underlying this FileStream
    isatty -> Boolean
        // true if this fileStream is interactive
    == (other) -> Boolean
        // true if self and other are the same FileStream object.  Note that
        // it is possible to have several distinct fileStreams on the same
        // underlying file.
    clear -> FileStream
        // makes the contents of this FileStream empty. The read/write position becomes 0
}
```
The type `Process` defines the interface of a process.

```
type Process = Object & interface {
    wait -> Number
        // wait for me to terminate, and answer my exit status.
        // +ve indicates that I terminated normally.  Other
        // Unix status codes are negated.
    success -> Boolean
        // waits for me to terminate, and returns true if I
        // exited normally (status = 0)
    terminated -> Boolean
        // returns true if I've terminated.
    status -> Number
        // waits for me to terminate, if necessary.  Returns the
        // cached status.
}
```
