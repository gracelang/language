---
title: "Class: graphicApplicationSize"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /graphicApplicationSize/
folder: grace-docs
---

### Definition
Class: graphicApplicationSize  

### Description
Not currently available...  

### Properties
  
- `prepend ( aComponent: `[`Component`](/grace-documentation/Component)`) -> `[`Done`]({{site.baseurl}}/404)  
Add a component to the top of the window.
- `append ( aComponent: `[`Component`](/grace-documentation/Component)`) -> `[`Done`]({{site.baseurl}}/404)  
Add a component to the bottom of the window.
- `onMouseClick ( pt: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
The following methods are defind to be called in response to mouse actions.  They will be overridden in subclasses to provide appropriate behavior, as now they do nothing! Method to handle mouse click at pt
- `onMousePress ( pt: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Method to handle mouse press at pt
- `onMouseRelease ( pt: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Method to handle mouse release at pt
- `onMouseMove ( pt: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Method to handle mouse move at pt
- `onMouseDrag ( pt: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Method to handle mouse drag at pt
- `onMouseEnter ( pt: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Method to handle mouse enter of canvas at pt
- `onMouseExit ( pt: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Method to handle mouse exit of canvas at pt
- `startGraphics -> `[`Done`]({{site.baseurl}}/404)  
Create window and its contents as well as prepare the window to handle mouse events
- `asString -> `[`String`]({{site.baseurl}}/404)  

### Definitions
- `canvas -> `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)  
- `before -> `[`Container`](/grace-documentation/Container)  
- `after -> `[`Container`](/grace-documentation/Container)  
