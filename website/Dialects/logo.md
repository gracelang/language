---
title: The Logo Dialect
keywords: Logo
sidebar: dialects_sidebar 
permalink: /dialects/logo/ 
toc: false
folder: Dialects
---

Welcome to a beginners guide to using Logo in Grace! In case you have not heard of Logo before, it is a
simple concept where images can be drawn onscreen using simple commands for a paintbrush — or as it is refereed to in logo – the turtle.
For more background reading, please see [this wikipedia page][WikiTurtle1]. In essence, you can think of moving the turtle across the screen to draw images
as controlling a printer arm, deciding where the ink should go on the page. This is a simple dialect that allows easy access to [turtle graphics][WikiTurtle2].

[WikiTurtle1]: https://en.wikipedia.org/wiki/Logo_(programming_language)
[WikiTurtle2]: https://en.wikipedia.org/wiki/Turtle_graphics

### Variables
In Grace we can declare many types of
different variables. Below are some of the simple ones:

`Number`  like `var i := 50`

`Boolean` like `var i := true`

`String`  like `var i := "Hello World"`




### Turtle Attributes

In the Grace implementation of Logo, the turtle is an object that has the following attributes:

`lineWidth` is the width of the line to be drawn, such as `3`

`lineColor` is the color of the line to be drawn, such as `red`

Supported colors are: `red` `green` `blue` `black`    

**For example:** they can simply be edited by writing `lineWidth := 2` or `lineColor := blue`

  
  

### Turtle Methods

The turtle can be moved forward using `forward(units:Number)`. This moves our turtle a number of units in its current direction.
To change the direction of the turtle we can use the following methods: `turnRight(degree:Number)` and `turnLeft(degree:Number)` to turn the turtle
left and right a number of degrees. The number of units or the number of degrees are specified in the function call.

**For example:**  `forward(50)` or  `turnRight(30)`

<br>

***
<div style="text-align: center;" markdown="1">
## Examples ##
</div>
***

### Example 1 ###
An example to get us started! The code below draws a square. Modify it to draw a rectangle with
sides whose length = 75.

<object id="example-1" data="{{site.baseurl}}/embedded-web-editor/?square" width="100%" height="550px"> </object>

### Example 2 ###

This example will iterate across the integers from 50 to 80. Each time the turtle will move forward by i,  
and then turn right by i-7. In this type of iteration (loop), "i" is the current number between 50 and 80.

<object id="example-2" data="{{site.baseurl}}/embedded-web-editor/?logoFor" width="100%" height="550px"> </object>

### Example 3 ###

This is a more complex example that draws a house. Modify it to make it more interesting. 

<object id="example-3" data="{{site.baseurl}}/embedded-web-editor/?LogoExample" width="100%" height="550px"> </object>


***

<div style="text-align: center;" markdown="1">
### Developer Stuff
Don't bother looking if you are just using the library!
</div>
<p style="page-break-before: always">

This library requires the use of lazy initialization. You can't use
anything that you see at the top level! If you want to expand it with a
new field for the top level, especially an object, you need to do it in
steps. At the top level, create a private field(remember that fields
are private by default in Grace), and add a "\_" prefix to it in order
to distinguish it as the private version. Then set that to the
notInitialized object. Create a accessor method by using what you would
want to name your field, and after checking if it is the the
notInitialized object currently, assign it to your liking. if you want
this field to be assignable, also create a ":=" method that just assigns
the private field whatever is in the argument, which is is effectively
just the left side of an assignment operation for the user.

We also have the `asRadian(degree)`,`asDegree(radians)` to convert our
units, as well as `asAngle` to automatically set The degree of our
heading within 360, with 0 point right along the x-axis and 90 pointing
directly up.
