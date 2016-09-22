---
title: "Type: Component"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /Component/
folder: grace-docs
---

### Definition
`Component ->  {...added methods below...}`

### Description
The super-type of all components in a GUI.

### Properties
- `element  —> `[`Done`]({{site.baseurl}}/404)  
The underlying DOM element of the component.
  
- `width  —> `[`Number`]({{site.baseurl}}/404)  
The width of this component.
  
- `height  —> `[`Number`]({{site.baseurl}}/404)  
The height of this component.
  
- `size  —> `[`Point`]({{site.baseurl}}/404)  
The size (width, height) of this component
  
- `onMouseClickDo (f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse click (press and release) in this component with the given event.
  
- `onMousePressDo (f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse press in this component with the response f.
  
- `onMouseReleaseDo (f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse release in this component with the response f.
  
- `onMouseMoveDo (f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse move in this component with the response f.
  
- `onMouseDragDo (f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse drag (move during press) in this component with the response f.
  
- `onMouseEnterDo (f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse entering this component with the response f.
  
- `onMouseExitDo (f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse exiting this component with the response f.
  
- `onKeyTypeDo (f: `[`KeyResponse`](/grace-documentation/KeyResponse)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a key type (press and release) in this component with the response f.
  
- `onKeyPressDo (f: `[`KeyResponse`](/grace-documentation/KeyResponse)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a key press in this component with the response f.
  
- `onKeyReleaseDo (f: `[`KeyResponse`](/grace-documentation/KeyResponse)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a key release in this component with the response f.
  
- `isFlexible  —> `[`Boolean`]({{site.baseurl}}/404)  
Whether this component will dynamically fill up any empty space in the direction of its parent container.
  
- `flexible:= (value: `[`Boolean`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Set whether this component will dynamically fill up any empty space in the direction of its parent container.
  
