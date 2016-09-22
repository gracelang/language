---
title: "Type: Graphic"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /Graphic/
folder: grace-docs
---

### Definition
`Graphic ->  {...added methods below...}`

### Description
Objects that can be drawn on a canvas and moved around.

### Properties
- `location  —> `[`Point`]({{site.baseurl}}/404)  
The location of this object from the top-left corner of the screen.
  
- `x  —> `[`Number`]({{site.baseurl}}/404)  
The horizontal location of this object from the top-left corner of the screen.
  
- `y  —> `[`Number`]({{site.baseurl}}/404)  
The vertical location of this object from the top-left corner of the screen.
  
- `addToCanvas (canvas: `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) —> `[`Done`]({{site.baseurl}}/404)  
Add this object to the given canvas.
  
- `removeFromCanvas  —> `[`Done`]({{site.baseurl}}/404)  
Remove this object from its canvas.
  
- `isVisible  —> `[`Boolean`]({{site.baseurl}}/404)  
Whether this object is currently set to be visible on the canvas.
  
- `visible:= (value: `[`Boolean`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Set whether this object is currently visible on the canvas.
  
- `moveTo (location: `[`Point`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Move this object to the given point on the canvas.
  
- `moveBy (dx: `[`Number`]({{site.baseurl}}/404)`,dy: `[`Number`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Move this object by the given distances on the canvas.
  
- `contains (location: `[`Point`]({{site.baseurl}}/404)`) —> `[`Boolean`]({{site.baseurl}}/404)  
Whether the given location is inside this object.
  
- `overlaps (graphic: `[`Graphic2D`](/grace-documentation/Graphic2D)`) —> `[`Boolean`]({{site.baseurl}}/404)  
Whether any point in the given graphic is inside this object.
  
- `color:= (c: `[`Color`](/grace-documentation/Color)`) —> `[`Done`]({{site.baseurl}}/404)  
set the color of this object to c
  
- `color  —> `[`Color`](/grace-documentation/Color)  
return the color of this object
  
- `sendForward  —> `[`Done`]({{site.baseurl}}/404)  
Send this object up one layer on the screen
  
- `sendBackward  —> `[`Done`]({{site.baseurl}}/404)  
send this object down one layer on the screen
  
- `sendToFront  —> `[`Done`]({{site.baseurl}}/404)  
send this object to the top layer on the screen
  
- `sendToBack  —> `[`Done`]({{site.baseurl}}/404)  
send this object to the bottom layer on the screen
  
