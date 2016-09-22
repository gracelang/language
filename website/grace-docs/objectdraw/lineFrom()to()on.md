---
title: "Class: lineFrom()to()on"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /lineFrom()to()on/
folder: grace-docs
---

### Definition
Class: lineFrom()to()on  

### Description
Not currently available...  

### Properties
  
- `start -> `[`Point`]({{site.baseurl}}/404)  
position of start of line
- `end -> `[`Point`]({{site.baseurl}}/404)  
position of end of line
- `start:= ( newStart: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
set start of line
- `end:= ( newEnd: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Set end of line
- `setEndPoints ( newStart: `[`Point`]({{site.baseurl}}/404),`newEnd: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Set start and end of line
- `draw ( ctx: `[`Foreign`](/grace-documentation/Foreign)`) -> `[`Done`]({{site.baseurl}}/404)  
Draw the line on the canvas
- `moveBy ( dx: `[`Number`]({{site.baseurl}}/404),`dy: `[`Number`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Moves the line by (dx, dy)
- `moveTo ( newLocn: `[`Point`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Moves this object to newLocn
- `dist2 ( v: `[`Point`]({{site.baseurl}}/404),`w: `[`Point`]({{site.baseurl}}/404)`) -> `[`Number`]({{site.baseurl}}/404)  
answers the square of the distance between v and w
- `distToSegmentSquared ( p: `[`Point`]({{site.baseurl}}/404),`v: `[`Point`]({{site.baseurl}}/404),`w: `[`Point`]({{site.baseurl}}/404)`) -> `[`Number`]({{site.baseurl}}/404)  
- `distToSegment ( p: `[`Point`]({{site.baseurl}}/404),`v: `[`Point`]({{site.baseurl}}/404),`w: `[`Point`]({{site.baseurl}}/404)`) -> `[`Number`]({{site.baseurl}}/404)  
Return the distance from p to the line through v and w
- `contains ( pt: `[`Point`]({{site.baseurl}}/404)`) -> `[`Boolean`]({{site.baseurl}}/404)  
Answers whether the line contains pt.  Returns true if pt is within 2 pixels of the line
- `asString -> `[`String`]({{site.baseurl}}/404)  
Answers a string representation of this line

### Definitions
- `var theEnd -> `[`Point`]({{site.baseurl}}/404)  
