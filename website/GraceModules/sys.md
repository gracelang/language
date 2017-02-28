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
for any identifier of your choice, e.g. `system`. The object `system` responds
to the following requests.

```
type Environment = interface {
    at(key:String) -> String
    at(key:String) put(value:String) -> Boolean
    contains(key:String) -> Boolean
}

argv -> Sequence⟦String⟧
// the command-line arguments to this program
    
elapsedTime -> Number
// the time in seconds, since an arbitrary epoch.  Take the difference of two elapsedTime
// values to measure a duration.
    
exit(exitCode:Number) -> Done
// terminates the whole program, with exitCode.

execPath -> String
// the directory in which the currently-running executable was found.
    
environ -> Environment
// the current environment.
 
```
