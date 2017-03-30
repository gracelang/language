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

The *io* module can be imported using `import "io" as transput`, for any identifier `transput` of your choice. The object `transput` will then respond to the following requests.

```
input -> FileStream        // returns stdin
output -> FileStream       // returns stdout
error -> FileStream        // returns stderr
ask (question:String) -> String
    // asks `question` interactively, and returns the user's answer
    
open (path:String, mode:String) -> FileStream
    // opens `path` in `mode`. `mode` may be "r", "w", "rw", etc.
    
system (command:String) -> Boolean
    // executes system command, returns true iff exit status is 0
    
exists (path:String) -> Boolean
    // returns true iff path exists in the file system
    
newer (path1:String, path2:String) -> Boolean
    // returns true iff the file at path1 is newer than the file at path2
    
realpath (path:String) -> String     // returns absolute path 
    
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

The type `FileStream` describes the interface of an opened file:

```
type FileStream = Object & type {
    read -> String
        // returns the whole contents of the underlying file.
    getline -> String
        // returns the next line in the file, up to and including the next
        // newline.  If the end of the input is reached before a newline is
        // found, the result will not have a final newline.  If eof is true,
        // returns the empty string.
    write (s:String) -> Done
        // writes s to the file at the current position of the read-write pointer.
    close -> Done
        // closes the file.
    seek (n: Number) -> FileStream
        // moves the read position to n
    seekForward (n:Number) -> FileStream
        // moves the read/write position forward by n
    seekBackward (n:Number) -> FileStream
        // moved the read/write position backward by n
    iterator -> FileStream
        // returns self
    hasNext -> Boolean
        // returns true is next will return a character,
        // and false if it will raise an exception.
    next -> String
        // returns the next Unicode character from the file.
        // Raises IteratorExhausted if there is none
    readBinary(n:Number) -> Object
        // Returns an array containing the next n bytes
    writeBinary(bytes:Object) -> Number
        // appends bytes to the file.  Returns the number
        // of bytes written.
    pathname -> String
        // the name of the file underlying this fileStream
    eof -> Boolean
        // true if the read–write position is at the end of the file.
    isatty -> Boolean
        // true if this fileStream is interactive
    == (other) -> Boolean
        // true if self and other are the same FileStream object.  Note that
        // it is possible to have several distinct fileStreams on the same
        // underlying file.
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
