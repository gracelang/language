---
title: "Class: drawableAt()on"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /drawableAt()on/
folder: grace-docs
---

### Definition
Class: drawableAt()on  

### Description
Not currently available...  

### Properties
  
- `x -> `[`Number`]({{site.baseurl}}/404)  
x coordinate of object
- `y -> `[`Number`]({{site.baseurl}}/404)  
y coordinate of object
- `== ( other) -> `[`Done`]({{site.baseurl}}/404)  
Object identity. This doesn't seem right to apb, but it's what the rest of the code assumes.
- `color -> `[`Color`](/grace-documentation/Color)  
- `color:= ( newColor: `[`Color`](/grace-documentation/Color)`) -> `[`Done`]({{site.baseurl}}/404)  
- `frameColor -> `[`Color`](/grace-documentation/Color)  
- `frameColor:= ( newfColor: `[`Color`](/grace-documentation/Color)`) -> `[`Done`]({{site.baseurl}}/404)  
- `visible:= ( b: `[`Boolean`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Set whether object is visible or hidden
- `addToCanvas ( c: `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Done`]({{site.baseurl}}/404)  
Add this object to canvas c
- `removeFromCanvas -> `[`Done`]({{site.baseurl}}/404)  
Remove this object from its canvas
- `moveTo ( newLocn: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
move this object to newLocn
- `moveBy ( dx: `[`Number`]({{site.baseurl}}/404),`dy: `[`Number`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
move this object dx to the right and dy down
- `contains ( locn: `[`Point`]({{site.baseurl}}/404)`) -> `[`Boolean`]({{site.baseurl}}/404)  
Determine whether this object contains the point at locn
- `overlaps ( otherObject: `[`Graphic2D`](/grace-documentation/Graphic2D)`) -> `[`Boolean`]({{site.baseurl}}/404)  
Determine whether this object overlaps otherObject
- `sendForward -> `[`Done`]({{site.baseurl}}/404)  
Send this object up one layer on the screen
- `sendBackward -> `[`Done`]({{site.baseurl}}/404)  
send this object down one layer on the screen
- `sendToFront -> `[`Done`]({{site.baseurl}}/404)  
send this object to the top layer on the screen
- `sendToBack -> `[`Done`]({{site.baseurl}}/404)  
send this object to the bottom layer on the screen
- `notifyRedraw -> `[`Done`]({{site.baseurl}}/404)  
Tell the canvas that the screen needs to be repainted
- `draw ( ctx: `[`Foreign`](/grace-documentation/Foreign)`) -> `[`Done`]({{site.baseurl}}/404)  
Draw this object on the applet !! confidential
- `asString -> `[`String`]({{site.baseurl}}/404)  
Return a string representation of the object

### Definitions
- `var location -> `[`Point`]({{site.baseurl}}/404)  
location of object on screen
- `var canvas -> `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)  
The canvas this object is part of
- `var theColor -> `[`Color`](/grace-documentation/Color)  
the color of this object
- `var theFrameColor -> `[`Color`](/grace-documentation/Color)  
- `var isVisible -> `[`Boolean`]({{site.baseurl}}/404)  
Determine if object is shown on screen
