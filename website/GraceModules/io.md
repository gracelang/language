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

type FileStream = Object & interface {
    read -> Object
    getline -> Object
    write (s:String) -> Object
    close -> Object
    seek -> Object
    seekForward (n:Number) -> Object
    seekBackward (n:Number) -> Object
    iterator -> Object
    hasNext -> Object
    next -> Object
    readBinary -> Object
    writeBinary -> Object
    pathname -> String
    eof -> Boolean
    isatty -> Boolean
}

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
