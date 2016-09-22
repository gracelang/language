---
title: "Type: Container"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /Container/
folder: grace-docs
---

### Definition
`Container ->  `[`Component`](/grace-documentation/Component) `&``type``{...added methods below...}`

### Description
The type of components that contain other components.

### Properties
- `size  —> `[`Number`]({{site.baseurl}}/404)  
The number of components inside this container.
  
- `at (index: `[`Number`]({{site.baseurl}}/404)`) —> `[`Component`](/grace-documentation/Component)  
Retrieve the component at the given index.
  
- `at (index: `[`Number`]({{site.baseurl}}/404)`) put (component: `[`Component`](/grace-documentation/Component)`) —> `[`Done`]({{site.baseurl}}/404)  
Put the given component at the given index.
  
- `append (component: `[`Component`](/grace-documentation/Component)`) —> `[`Done`]({{site.baseurl}}/404)  
Add a component to the end of the container.
  
- `prepend (component: `[`Component`](/grace-documentation/Component)`) —> `[`Done`]({{site.baseurl}}/404)  
Add a component to the start of the container.
  
- `do (f: Procedure `[`Component`](/grace-documentation/Component)`) —> `[`Done`]({{site.baseurl}}/404)  
Perform an action for every component inside this container.
  
- `arrangeHorizontal  —> `[`Done`]({{site.baseurl}}/404)  
Arrange the contents of this container along the horizontal axis. Components which exceed the width of the container will wrap around.
  
- `arrangeVertical  —> `[`Done`]({{site.baseurl}}/404)  
Arrange the contents of this container along the vertical axis. Components which exceed the height of the container will wrap around.
  
