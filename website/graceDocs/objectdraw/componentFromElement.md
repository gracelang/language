---
title: "Class: componentFromElement"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /componentFromElement/
folder: grace-docs
---

### Definition
Class: componentFromElement  

### Description
Not currently available...  

### Properties
  
- `width -> `[`Number`]({{site.baseurl}}/404)  
width of component
- `height -> `[`Number`]({{site.baseurl}}/404)  
height of component
- `size -> `[`Point`]({{site.baseurl}}/404)  
dimensions of component
- `on ( event': `[`String`]({{site.baseurl}}/404)`)do ( f: `[`Procedure`](/grace-documentation/Procedure)[`Foreign`](/grace-documentation/Foreign)`) -> `[`Done`]({{site.baseurl}}/404)  
assocate action f with event' on component
- `on ( kind: `[`String`]({{site.baseurl}}/404)`)withPointDo ( f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
associate response f to mouse event of kind
- `mouseEventSource()eventmouseEventSource (source':)event (event':)`  
- `asString -> `[`Done`]({{site.baseurl}}/404)  
- `onMouseClickDo ( f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associates action f with mouse click event
- `onMousePressDo ( f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associate action f to mouse press event
- `onMouseReleaseDo ( f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associate action f to mouse release event
- `onMouseMoveDo ( f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associate action f to mouse move event
- `onMouseDragDo ( f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associate action f to mouse drag event
- `onMouseEnterDo ( f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associate action f to mouse enter (of window) event
- `onMouseExitDo ( f: `[`MouseResponse`](/grace-documentation/MouseResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associate action f to mouse exit event
- `eventSourceeventSource (source': `[`Component`](/grace-documentation/Component)`) -> `[`Event`](/grace-documentation/Event)  
- `asString -> `[`String`]({{site.baseurl}}/404)  
- `keyEventSource()eventkeyEventSource (source': `[`Component`](/grace-documentation/Component)`)event (event': `[`Foreign`](/grace-documentation/Foreign)`) -> `[`KeyEvent`](/grace-documentation/KeyEvent)  
- `asString -> `[`String`]({{site.baseurl}}/404)  
String representation of the key event
- `on ( kind: `[`String`]({{site.baseurl}}/404)`)withKeyDo ( f: `[`KeyResponse`](/grace-documentation/KeyResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associate action f to key event of kind
- `onKeyPressDo ( f: `[`KeyResponse`](/grace-documentation/KeyResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associate action f to key press event
- `onKeyReleaseDo ( f: `[`KeyResponse`](/grace-documentation/KeyResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associate action f to key release event
- `onKeyTypeDo ( f: `[`KeyResponse`](/grace-documentation/KeyResponse)`) -> `[`Done`]({{site.baseurl}}/404)  
Associate action f tokey type (press & release) event
- `isFlexible -> `[`Boolean`]({{site.baseurl}}/404)  
Does component have some flex in size
- `flexible:= ( value: `[`Boolean`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Set whether component is flexibile
- `asString -> `[`String`]({{site.baseurl}}/404)  
string representation of component

### Definitions
- `element -> `  
- `source -> `  
- `at -> `  
- `source -> `[`Component`](/grace-documentation/Component)  
- `code -> `[`Number`]({{site.baseurl}}/404)  
def character is public = dom.window.String.fromCharCode(event'.which)
