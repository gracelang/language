---
title: "Type: DrawingCanvas"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /DrawingCanvas/
folder: grace-docs
---

### Definition
`DrawingCanvas ->  `[`Component`](/grace-documentation/Component) `&``type``{...added methods below...}`

### Description
DrawingCanvas holding graphic objects

### Properties
- `startDrawing  —> `[`Done`]({{site.baseurl}}/404)  
redraws the canvas and its contents regularly as needed
  
- `add (d: `[`Graphic`](/grace-documentation/Graphic)`) —> `[`Done`]({{site.baseurl}}/404)  
add d to canvas
  
- `remove (d: `[`Graphic`](/grace-documentation/Graphic)`) —> `[`Done`]({{site.baseurl}}/404)  
remove d from canvas
  
- `notifyRedraw  —> `[`Done`]({{site.baseurl}}/404)  
Inform canvas that it needs to be redrawn
  
- `clear  —> `[`Done`]({{site.baseurl}}/404)  
clear the canvas
  
- `sendToFront (d: `[`Graphic`](/grace-documentation/Graphic)`) —> `[`Done`]({{site.baseurl}}/404)  
Send d to top layer of graphics
  
- `sendToBack (d: `[`Graphic`](/grace-documentation/Graphic)`) —> `[`Done`]({{site.baseurl}}/404)  
send d to bottom layer of graphics
  
- `sendForward (d: `[`Graphic`](/grace-documentation/Graphic)`) —> `[`Done`]({{site.baseurl}}/404)  
send d up one layer in graphics
  
- `sendBackward (d: `[`Graphic`](/grace-documentation/Graphic)`) —> `[`Done`]({{site.baseurl}}/404)  
send d down one layer in graphics
  
- `width  —> `[`Number`]({{site.baseurl}}/404)  
return the current dimensions of the canvas
  
- `height  —> `[`Number`]({{site.baseurl}}/404)  
  
- `size  —> `[`Point`]({{site.baseurl}}/404)  
  
