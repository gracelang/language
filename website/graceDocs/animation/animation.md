---
title: "Module: animation"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /Module:animation/
folder: grace-docs
---

### Methods
  
- `while ( condition: `[`BoolBlock`](/grace-documentation/BoolBlock)`)pausing ( pauseTime: `[`Number`]({{site.baseurl}}/404)`)do ( block: `[`Procedure`](/grace-documentation/Procedure)`) -> `[`Done`]({{site.baseurl}}/404)  
Repeatedly execute block while condition is true
- `while ( condition: `[`BoolBlock`](/grace-documentation/BoolBlock)`)pausing ( pauseTime: `[`Number`]({{site.baseurl}}/404)`)do ( block: `[`Procedure`](/grace-documentation/Procedure)`)finally ( endBlock: `[`Procedure`](/grace-documentation/Procedure)`) -> `[`Done`]({{site.baseurl}}/404)  
- `while ( condition: `[`BoolBlock`](/grace-documentation/BoolBlock)`)pauseVarying ( timeBlock)do ( block: `[`Procedure`](/grace-documentation/Procedure)`) -> `[`Done`]({{site.baseurl}}/404)  
- `for ( range': `[`Iterable`]({{site.baseurl}}/404)[`T`]({{site.baseurl}}/404)`)pausing ( pauseTime: `[`Number`]({{site.baseurl}}/404)`)do ( block: `[`Block`]({{site.baseurl}}/404)[`Number`]({{site.baseurl}}/404),[`Done`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
- `for ( range': `[`Iterable`]({{site.baseurl}}/404)[`T`]({{site.baseurl}}/404)`)pausing ( pauseTime)do ( block: `[`Block`]({{site.baseurl}}/404)[`Number`]({{site.baseurl}}/404),[`Done`]({{site.baseurl}}/404)`)finally ( endBlock: `[`Block`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  

### Types
- [`Animator`](/grace-documentation/Animator)  
type of object that can simulate parallel animations Repeatedly execute block while condition is true
- [`BoolBlock`](/grace-documentation/BoolBlock)  
type of a block that takes no parameters and returns a boolean
- [`NumberBlock`](/grace-documentation/NumberBlock)  
- [`Procedure`](/grace-documentation/Procedure)  
