---
title: "Class: containerFromElement"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /containerFromElement/
folder: grace-docs
---

### Definition
Class: containerFromElement  

### Description
Not currently available...  

### Properties
  
- `size -> `[`Number`]({{site.baseurl}}/404)  
Number of children
- `isEmpty -> `[`Boolean`]({{site.baseurl}}/404)  
Is it empty?
- `at ( index: `[`Number`]({{site.baseurl}}/404)`) -> `[`Component`](/grace-documentation/Component)  
Subcomponent at position index
- `at ( index: `[`Number`]({{site.baseurl}}/404)`)put ( aComponent: `[`Component`](/grace-documentation/Component)`) -> `[`Done`]({{site.baseurl}}/404)  
Replace subcomponent at index by aComponent
- `append ( aComponent: `[`Component`](/grace-documentation/Component)`) -> `[`Done`]({{site.baseurl}}/404)  
Add aComponent after all existing components in the container
- `prepend ( aComponent: `[`Component`](/grace-documentation/Component)`) -> `[`Done`]({{site.baseurl}}/404)  
Add aComponent before all existing components in the container
- `do ( f: `[`Procedure`](/grace-documentation/Procedure)[`Component`](/grace-documentation/Component)`) -> `[`Done`]({{site.baseurl}}/404)  
Apply f to all children of container.
- `fold ( f: `[`Function2`](/grace-documentation/Function2)[`T`]({{site.baseurl}}/404),[`Component`](/grace-documentation/Component),[`T`]({{site.baseurl}}/404)`)startingWith ( initial: `[`T`]({{site.baseurl}}/404)`) -> `[`T`]({{site.baseurl}}/404)  
Generalize binary function f to apply to all children of container. Value if no children is initial
- `flex -> `[`Done`]({{site.baseurl}}/404)  
Make container more flexible
- `arrangeHorizontal -> `[`Done`]({{site.baseurl}}/404)  
Arrange elements in rows
- `arrangeVertical -> `[`Done`]({{site.baseurl}}/404)  
Arrange elements in columns
- `asString -> `[`String`]({{site.baseurl}}/404)  
return description of container

### Definitions
- `children -> `  
