---
title: The sys Module
keywords: System, Sys, arguments, time, exit, env, environment, environ, execPath, elapsed, argv, command-line
sidebar: modules_sidebar
permalink: /modules/sys/
toc: false
folder: Modules
author:
- 'Andrew P. Black'
- 'Kim B. Bruce'
---

## System Facilities


The *sys* module object can be imported using `import "sys" as system`,
for any identifier `system` of your choice. The object `system` responds
to the following requests.

```
type Environment = interface {
    at(key:String) -> String
    at(key:String) put(value:String) -> Boolean
    contains(key:String) -> Boolean
}

argv -> Sequence⟦String⟧
// the command-line arguments to this program

cwd -> String
// the absolute pathname of the current working directory
    
elapsedTime -> Number
// the time in seconds, since an arbitrary epoch.  Subtract one elapsedTime
// from another to measure the time between them.
    
exit(exitCode:Number) -> Done
// terminates the whole program, with exitCode.

execPath -> String
// the directory in which the currently-running executable was found.
    
environ -> Environment
// the current environment.
 
```
