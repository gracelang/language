---
title: "Type: Animator"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /Animator/
folder: grace-docs
---

### Definition
`Animator ->  {...added methods below...}`

### Description
type of object that can simulate parallel animations Repeatedly execute block while condition is true

### Properties
- `while (condition: `[`BoolBlock`](/grace-documentation/BoolBlock)`) pausing (pauseTime: `[`Number`]({{site.baseurl}}/404)`) do (block: `[`Procedure`](/grace-documentation/Procedure)`) —> `[`Done`]({{site.baseurl}}/404)  
  
- `while (condition: `[`BoolBlock`](/grace-documentation/BoolBlock)`) pausing (pauseTime: `[`Number`]({{site.baseurl}}/404)`) do (block: `[`Procedure`](/grace-documentation/Procedure)`) finally (endBlock: `[`Procedure`](/grace-documentation/Procedure)`) —> `[`Done`]({{site.baseurl}}/404)  
Repeatedly execute block while condition is true, pausing pauseTime between iterations when condition fails, execute endBlock.
  
- `while (condition: `[`BoolBlock`](/grace-documentation/BoolBlock)`) pauseVarying (pauseTime: `[`Number`]({{site.baseurl}}/404)`) do (block: `[`Procedure`](/grace-documentation/Procedure)`) —> `[`Done`]({{site.baseurl}}/404)  
Repeatedly execute block while condition is true pausing variable amount of time (obtained by evaluating timeBlock) between iterations when condition fails, execute endBlock.
  
- `for (range': Iterable `[`T`]({{site.baseurl}}/404)`) pausing (pauseTime: `[`Number`]({{site.baseurl}}/404)`) do (block: Block1 `[`T`]({{site.baseurl}}/404)`,`[`Done`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Repeatedly execute block while condition is true
  
- `for (range': Iterable `[`T`]({{site.baseurl}}/404)`) pausing (pauseTime: `[`Number`]({{site.baseurl}}/404)`) do (block: Block1 `[`T`]({{site.baseurl}}/404)`,`[`Done`]({{site.baseurl}}/404)`) finally (endBlock: `[`Procedure`](/grace-documentation/Procedure)`) —> `[`Done`]({{site.baseurl}}/404)  
Repeatedly execute block while condition is true when condition fails, execute endBlock.
  
