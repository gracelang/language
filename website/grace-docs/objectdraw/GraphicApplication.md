---
title: "Type: GraphicApplication"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /GraphicApplication/
folder: grace-docs
---

### Definition
`GraphicApplication ->  `[`Application`](/grace-documentation/Application) `&``type``{...added methods below...}`

### Description
Type of object that runs a graphical application that draws objects on a canvas included in the window and responds to mouse actions canvas holds graphic objects on screen

### Properties
- `canvas  —> `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)  
  
- `onMouseClick (mouse: `[`Point`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse click (press and release) in the canvas at the given point.
  
- `onMousePress (mouse: `[`Point`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse press in the canvas at the given point.
  
- `onMouseRelease (mouse: `[`Point`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse release in the canvas at the given point.
  
- `onMouseMove (mouse: `[`Point`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse move in the canvas at the given point.
  
- `onMouseDrag (mouse: `[`Point`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse drag (move during press) in the canvas at the given point.
  
- `onMouseEnter (mouse: `[`Point`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse entering the canvas at the given point.
  
- `onMouseExit (mouse: `[`Point`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Respond to a mouse exiting the canvas at the given point.
  
- `startGraphics  —> `[`Done`]({{site.baseurl}}/404)  
must be invoked to create window and its contents as well as prepare the window to handle mouse events
  
