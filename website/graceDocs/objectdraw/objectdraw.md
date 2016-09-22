---
title: "Module: objectdraw"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /Module:objectdraw/
folder: grace-docs
---

### Methods
  
- `randomNumberFrom ( m: `[`Number`]({{site.baseurl}}/404)`)to ( n: `[`Number`]({{site.baseurl}}/404)`) -> `[`Number`]({{site.baseurl}}/404)  
A random number from m to n, inclusive.
- `randomIntFrom ( m: `[`Number`]({{site.baseurl}}/404)`)to ( n: `[`Number`]({{site.baseurl}}/404)`) -> `[`Number`]({{site.baseurl}}/404)  
- `color.`[`r()g()b`](/grace-documentation/r()g()b)`:: r(r': `[`Number`]({{site.baseurl}}/404)`)g(g': `[`Number`]({{site.baseurl}}/404)`)b(b': `[`Number`]({{site.baseurl}}/404)`) -> `[`Color`](/grace-documentation/Color)  
  
- `color.random -> `[`Color`](/grace-documentation/Color)  
Produce a random color.
- `randomColor -> `[`Color`](/grace-documentation/Color)  
- [`eventSource`](/grace-documentation/eventSource)`:: eventSource(source': `[`Component`](/grace-documentation/Component)`) -> `[`Event`](/grace-documentation/Event)  
  
- [`mouseEventSource()event`](/grace-documentation/mouseEventSource()event)`:: mouseEventSource(source': `[`Component`](/grace-documentation/Component)`)event(event': `[`Foreign`](/grace-documentation/Foreign)`) -> `[`MouseEvent`](/grace-documentation/MouseEvent)  
  
- [`keyEventSource()event`](/grace-documentation/keyEventSource()event)`:: keyEventSource(source': `[`Component`](/grace-documentation/Component)`)event(event': `[`Foreign`](/grace-documentation/Foreign)`) -> `[`KeyEvent`](/grace-documentation/KeyEvent)  
  
- [`componentFromElement`](/grace-documentation/componentFromElement)`:: componentFromElement(element') -> `[`Component`](/grace-documentation/Component)  
  
- [`componentOfElementType`](/grace-documentation/componentOfElementType)`:: componentOfElementType(tagName: `[`String`]({{site.baseurl}}/404)`) -> `[`Component`](/grace-documentation/Component)  
  
- [`containerOfElementType`](/grace-documentation/containerOfElementType)`:: containerOfElementType(tagName: `[`String`]({{site.baseurl}}/404)`) -> `[`Component`](/grace-documentation/Component)  
  
- [`containerFromElement`](/grace-documentation/containerFromElement)`:: containerFromElement(element') -> `[`Container`](/grace-documentation/Container)  
  
- [`containerEmpty`](/grace-documentation/containerEmpty)`::  -> `[`Container`](/grace-documentation/Container)  
  
- [`containerSize`](/grace-documentation/containerSize)`:: containerSize(width': `[`Number`]({{site.baseurl}}/404),`height': `[`Number`]({{site.baseurl}}/404)`) -> `[`Container`](/grace-documentation/Container)  
  
- [`inputFromElement`](/grace-documentation/inputFromElement)`:: inputFromElement(element') -> `[`Input`](/grace-documentation/Input)  
  
- [`inputOfElementType`](/grace-documentation/inputOfElementType)`:: inputOfElementType(elementType: `[`String`]({{site.baseurl}}/404)`) -> `[`Input`](/grace-documentation/Input)  
  
- [`inputOfType`](/grace-documentation/inputOfType)`:: inputOfType(inputType: `[`String`]({{site.baseurl}}/404)`) -> `[`Input`](/grace-documentation/Input)  
  
- [`labeledWidgetFromElement`](/grace-documentation/labeledWidgetFromElement)`:: labeledWidgetFromElement(element') -> `[`Labeled`](/grace-documentation/Labeled)  
  
- [`labeledWidgetOfElementType`](/grace-documentation/labeledWidgetOfElementType)`:: labeledWidgetOfElementType(elementType: `[`String`]({{site.baseurl}}/404)`) -> `[`Labeled`](/grace-documentation/Labeled)  
  
- [`labeledWidgetOfElementType()labeled`](/grace-documentation/labeledWidgetOfElementType()labeled)`:: labeledWidgetOfElementType(elementType: `[`String`]({{site.baseurl}}/404)`)labeled(newLabel: `[`String`]({{site.baseurl}}/404)`) -> `[`Labeled`](/grace-documentation/Labeled)  
  
- [`fieldOfType()labeled`](/grace-documentation/fieldOfType()labeled)`:: fieldOfType(inputType: `[`String`]({{site.baseurl}}/404)`)labeled(label': `[`String`]({{site.baseurl}}/404)`) -> `[`Input`](/grace-documentation/Input)  
  
- [`eventLogKind()response`](/grace-documentation/eventLogKind()response)`:: eventLogKind(kind': `[`String`]({{site.baseurl}}/404)`)response(response': `[`Procedure`](/grace-documentation/Procedure)`)`  
  
- [`applicationTitle()size`](/grace-documentation/applicationTitle()size)`:: applicationTitle(initialTitle: `[`String`]({{site.baseurl}}/404)`)size(dimensions': `[`Point`]({{site.baseurl}}/404)`) -> `[`Application`](/grace-documentation/Application)  
  
- [`drawingCanvasSize`](/grace-documentation/drawingCanvasSize)`:: drawingCanvasSize(dimensions': `[`Point`]({{site.baseurl}}/404)`) -> `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)  
  
- [`graphicApplicationSize`](/grace-documentation/graphicApplicationSize)`:: graphicApplicationSize(theDimension': `[`Point`]({{site.baseurl}}/404)`) -> `[`GraphicApplication`](/grace-documentation/GraphicApplication)  
  
- [`drawableAt()on`](/grace-documentation/drawableAt()on)`:: drawableAt(location': `[`Point`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Graphic`](/grace-documentation/Graphic)  
  
- [`drawable2DAt()size()on`](/grace-documentation/drawable2DAt()size()on)`:: drawable2DAt(location': `[`Point`]({{site.baseurl}}/404)`)size(dimension': `[`Point`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Graphic2D`](/grace-documentation/Graphic2D)  
  
- [`resizable2DAt()size()on`](/grace-documentation/resizable2DAt()size()on)`:: resizable2DAt(location': `[`Point`]({{site.baseurl}}/404)`)size(dimensions': `[`Point`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Graphic2D`](/grace-documentation/Graphic2D)  
  
- [`framedRectAt()size()on`](/grace-documentation/framedRectAt()size()on)`:: framedRectAt(location': `[`Point`]({{site.baseurl}}/404)`)size(dimensions': `[`Point`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Graphic2D`](/grace-documentation/Graphic2D)  
  
- [`filledRectAt()size()on`](/grace-documentation/filledRectAt()size()on)`:: filledRectAt(location': `[`Point`]({{site.baseurl}}/404)`)size(dimensions': `[`Point`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Graphic2D`](/grace-documentation/Graphic2D)  
  
- [`framedOvalAt()size()on`](/grace-documentation/framedOvalAt()size()on)`:: framedOvalAt(location': `[`Point`]({{site.baseurl}}/404)`)size(dimensions': `[`Point`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Graphic2D`](/grace-documentation/Graphic2D)  
  
- [`filledOvalAt()size()on`](/grace-documentation/filledOvalAt()size()on)`:: filledOvalAt(location': `[`Point`]({{site.baseurl}}/404)`)size(dimensions': `[`Point`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Graphic2D`](/grace-documentation/Graphic2D)  
  
- [`framedArcAt()size()from()to()on`](/grace-documentation/framedArcAt()size()from()to()on)`:: framedArcAt(location': `[`Point`]({{site.baseurl}}/404)`)size(dimensions': `[`Point`]({{site.baseurl}}/404)`)from(startAngle: `[`Number`]({{site.baseurl}}/404)`)to(endAngle: `[`Number`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Graphic2D`](/grace-documentation/Graphic2D)  
  
- [`filledArcAt()size()from()to()on`](/grace-documentation/filledArcAt()size()from()to()on)`:: filledArcAt(location': `[`Point`]({{site.baseurl}}/404)`)size(dimensions': `[`Point`]({{site.baseurl}}/404)`)from(startAngle: `[`Number`]({{site.baseurl}}/404)`)to(endAngle: `[`Number`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Graphic2D`](/grace-documentation/Graphic2D)  
  
- [`drawableImageAt()size()url()on`](/grace-documentation/drawableImageAt()size()url()on)`:: drawableImageAt(location': `[`Point`]({{site.baseurl}}/404)`)size(dimensions': `[`Point`]({{site.baseurl}}/404)`)url(url: `[`String`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Graphic2D`](/grace-documentation/Graphic2D)  
  
- [`lineFrom()to()on`](/grace-documentation/lineFrom()to()on)`:: lineFrom(start': `[`Point`]({{site.baseurl}}/404)`)to(end': `[`Point`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Line`](/grace-documentation/Line)  
  
- [`lineFrom()length()direction()on`](/grace-documentation/lineFrom()length()direction()on)`:: lineFrom(pt: `[`Point`]({{site.baseurl}}/404)`)length(len: `[`Number`]({{site.baseurl}}/404)`)direction(radians: `[`Number`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Line`](/grace-documentation/Line)  
  
- [`textAt()with()on`](/grace-documentation/textAt()with()on)`:: textAt(location': `[`Point`]({{site.baseurl}}/404)`)with(contents': `[`String`]({{site.baseurl}}/404)`)on(canvas': `[`DrawingCanvas`](/grace-documentation/DrawingCanvas)`) -> `[`Text`](/grace-documentation/Text)  
  
- [`textBoxWith`](/grace-documentation/textBoxWith)`:: textBoxWith(contents': `[`String`]({{site.baseurl}}/404)`) -> `[`TextBox`](/grace-documentation/TextBox)  
  
- [`buttonLabeled`](/grace-documentation/buttonLabeled)`:: buttonLabeled(label': `[`String`]({{site.baseurl}}/404)`) -> `[`Button`](/grace-documentation/Button)  
  
- [`textFieldLabeled`](/grace-documentation/textFieldLabeled)`:: textFieldLabeled(label': `[`String`]({{site.baseurl}}/404)`) -> `[`TextField`](/grace-documentation/TextField)  
  
- [`textFieldUnlabeled`](/grace-documentation/textFieldUnlabeled)`::  -> `[`TextField`](/grace-documentation/TextField)  
  
- [`passwordFieldLabeled`](/grace-documentation/passwordFieldLabeled)`:: passwordFieldLabeled(lab: `[`String`]({{site.baseurl}}/404)`) -> `[`Input`](/grace-documentation/Input)  
  
- [`passwordFieldUnlabeled`](/grace-documentation/passwordFieldUnlabeled)`::  -> `[`TextField`](/grace-documentation/TextField)  
  
- [`numberFieldLabeled`](/grace-documentation/numberFieldLabeled)`:: numberFieldLabeled(label': `[`String`]({{site.baseurl}}/404)`) -> `[`NumberField`](/grace-documentation/NumberField)  
  
- [`numberFieldUnlabeled`](/grace-documentation/numberFieldUnlabeled)`::  -> `[`NumberField`](/grace-documentation/NumberField)  
  
- [`selectBoxOptionsFrom()labeled`](/grace-documentation/selectBoxOptionsFrom()labeled)`:: selectBoxOptionsFrom(options: `[`Iterable`]({{site.baseurl}}/404)`)labeled(label': `[`String`]({{site.baseurl}}/404)`) -> `[`Choice`](/grace-documentation/Choice)  
  
- [`selectBoxOptionsFrom`](/grace-documentation/selectBoxOptionsFrom)`:: selectBoxOptionsFrom(options: `[`Iterable`]({{site.baseurl}}/404)`) -> `[`Choice`](/grace-documentation/Choice)  
  
- [`audioUrl`](/grace-documentation/audioUrl)`:: audioUrl(source': `[`String`]({{site.baseurl}}/404)`) -> `[`Audio`](/grace-documentation/Audio)  
  

### Definitions
- `def frameRate -> `[`Number`]({{site.baseurl}}/404)  
The frame rate of the drawing.
- `def pi -> `[`Number`]({{site.baseurl}}/404)  
A rough approximation of the value of pi.
- `def document -> `[`Foreign`](/grace-documentation/Foreign)  
- `def ColorOutOfRange -> `  
Exception that may be thrown if the r, b, or g components are not between 0 and 255 (inclusive)
- `def color -> `  
Simple color class
- `def color.white -> `[`Color`](/grace-documentation/Color)  
- `def color.black -> `[`Color`](/grace-documentation/Color)  
- `def color.green -> `[`Color`](/grace-documentation/Color)  
- `def color.red -> `[`Color`](/grace-documentation/Color)  
- `def color.gray -> `[`Color`](/grace-documentation/Color)  
- `def color.blue -> `[`Color`](/grace-documentation/Color)  
- `def color.cyan -> `[`Color`](/grace-documentation/Color)  
- `def color.magenta -> `[`Color`](/grace-documentation/Color)  
- `def color.yellow -> `[`Color`](/grace-documentation/Color)  
- `def color.neutral -> `[`Color`](/grace-documentation/Color)  
- `def white -> `[`Color`](/grace-documentation/Color)  
Predefined colors.  Deprecated: use color.white, etc.
- `def black -> `[`Color`](/grace-documentation/Color)  
- `def green -> `[`Color`](/grace-documentation/Color)  
- `def red -> `[`Color`](/grace-documentation/Color)  
- `def gray -> `[`Color`](/grace-documentation/Color)  
- `def blue -> `[`Color`](/grace-documentation/Color)  
- `def cyan -> `[`Color`](/grace-documentation/Color)  
- `def magenta -> `[`Color`](/grace-documentation/Color)  
- `def yellow -> `[`Color`](/grace-documentation/Color)  
- `def neutral -> `[`Color`](/grace-documentation/Color)  
- `def maxClickTime -> `[`Number`]({{site.baseurl}}/404)  
The maximum number of milliseconds for which the mouse-button can be held down in order for the event to be registered as a click.

### Types
- [`Application`](/grace-documentation/Application)  
A standalone window which contains other components.
- [`Audio`](/grace-documentation/Audio)  
An audio file that can be played
- [`Button`](/grace-documentation/Button)  
type of button component in window
- [`Choice`](/grace-documentation/Choice)  
Type for pop-up menus
- [`Color`](/grace-documentation/Color)  
- [`Component`](/grace-documentation/Component)  
The super-type of all components in a GUI.
- [`ComponentFactory`](/grace-documentation/ComponentFactory)` -> T`  
where T <: Component
- [`Container`](/grace-documentation/Container)  
The type of components that contain other components.
- [`DrawingCanvas`](/grace-documentation/DrawingCanvas)  
DrawingCanvas holding graphic objects
- [`Event`](/grace-documentation/Event)  
Generic event containing source of the event.
- [`Foreign`](/grace-documentation/Foreign)  
- [`Function`](/grace-documentation/Function)` -> T,R`  
Types of blocks representing functions taking an argument of type T and returning a value of type R
- [`Function2`](/grace-documentation/Function2)` -> T,U,R`  
Types of blocks representing functions taking two arguments of type T and U and returning a value of type R
- [`Graphic`](/grace-documentation/Graphic)  
Objects that can be drawn on a canvas and moved around.
- [`Graphic2D`](/grace-documentation/Graphic2D)  
Two-dimensional objects that can also be resized
- [`GraphicApplication`](/grace-documentation/GraphicApplication)  
Type of object that runs a graphical application that draws objects on a canvas included in the window and responds to mouse actions canvas holds graphic objects on screen
- [`Input`](/grace-documentation/Input)  
Component that can take input and respond to an event
- [`KeyEvent`](/grace-documentation/KeyEvent)  
Type of an event associated with a key press character → String
- [`KeyResponse`](/grace-documentation/KeyResponse)  
type of an action taking a KeyEvent as a parameter
- [`Labeled`](/grace-documentation/Labeled)  
Component of window that holds text
- [`Line`](/grace-documentation/Line)  
One-dimensional objects start and end of line
- [`MouseEvent`](/grace-documentation/MouseEvent)  
Mouse event containing mouse location when event generated
- [`MouseResponse`](/grace-documentation/MouseResponse)  
type of an action taking a MouseEvent as a parameter
- [`NumberField`](/grace-documentation/NumberField)  
Component in window taking user numeric input
- [`Procedure`](/grace-documentation/Procedure)` -> T`  
Type of block taking argument of type T and returning Done
- [`Response`](/grace-documentation/Response)  
type of an action taking an Event as a paramter
- [`Text`](/grace-documentation/Text)  
Text that can be drawn on a canvas.
- [`TextBox`](/grace-documentation/TextBox)  
Component of window that holds text
- [`TextField`](/grace-documentation/TextField)  
Component in window taking user text input
