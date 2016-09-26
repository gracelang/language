---
title: The Logo Dialect
keywords: Logo
sidebar: dialects_sidebar 
permalink: /dialects/logo/ 
toc: false
folder: Dialects
---

Welcome to a beginners guide to using Logo in Grace. In case you have not heard of Logo before, it is a educational programming language that dates back to the 1960s, and best known for _Turtle Graphics_.

Imagine a turtle-like robot that holds a pen and can walk around the floor, on which is spread a large sheet of paper.  As the turtle moves, it draws a line — unless it lifts the pen off of the paper, in which case it moves without drawing.

We don't use mechanical turtles, but we can simulate them 
on the screen of a modern computer.  Grace Logo lets you
draw pictures on the screen by controlling a "virtual turtle" with Grace commands.

For more background, see [this wikipedia page][WikiTurtle1].

[WikiTurtle1]: https://en.wikipedia.org/wiki/Logo_(programming_language)


## Moving the Turtle

The turtle can be moved forward using `forward(distance)`. This moves our turtle the given distance in its current direction.

To change the direction of the turtle use the following commands: `turnRight(degrees)` and `turnLeft(degrees)`.
These commands turn the turtle
left and right the given number of degrees. 

**For example:**  

    forward(50)
    turnRight(π/4)
    forward 80

<br>

Notice that each command is followed by a number.  This number is called the “argument” to the command.  If the
number is a complicated expression (like `π/4`), it must be enclosed in parenthesis, so that Grace knows where it starts and ends.  If it's a simple constant like `50` or `80`, the parenthesis are not necessary (but they won't hurt).


#### Example 1
Here is an example to get us started! The code below draws a square. Modify it to instead draw a rectangle of width 150 and height 75.

<object id="example-1" data="{{site.editor}}?square" width="100%" height="550px"> </object>



#### Example 2

This example draws a five-pointed star.  The star looks as though it's staggering, though.  Can you modify the program so that the star is standing upright on two of its points? 

<object id="example-2" data="{{site.editor}}?5-star" width="100%" height="550px"> </object>


### Controlling the Pen

You can lift the virtual pen up using the command `penUp`, and put it back down using the command `penDown`.  

## Numbers

When you use Grace Logo, you will also need to use Numbers.  Grace Numbers behave pretty much as you would expect: `50` is a number, `-20` is a number, and `20/4.5` is a number. Grace also knows about `π`.

## Naming Values

It's often useful to give names to expressions involving numbers (or other things).  In Grace there are two kinds of named values: *definitions*, which don't change once they are made, and *variables*, which can be changed by the Grace program.

    def sideLength = 50

    var numberOfRepetitions := 10

Notice that *defs* define a name to be equal to a value, and use the `=` symbol: we are *defining* `sideLength` to be `50`.  Consequently, `sideLength` will always be `50`, so long as `sideLength` has a meaning.

In contrast, *vars* can change over time.  We “assign” a value to a variable using the assignment symbol `:=`.  Later, we can assign another value to the same variable.

    numberOfRepetitions := 9


### Example 3

This example draws a stylized house. It's a bit more complex because we start (on line 6) by telling the turtle to `moveToBottomLeft`, which isn't seomthing that it already knows how to do.  Scroll down and you will see that on lines 29–37 we *teach* the turtle how to `moveToBottomLeft` by giving it a _method_ with that name.
The method defines `moveToBottomLeft` in terms of simpler thangs that the Turtle *does* know how to do.

Similarly, this example (on lines 22–27) teaches the turtle a method for drawing a `square(_)`.   This is used on line 9.

Try modifying this example to give the house a door and a window. 

<object id="example-3" data="{{site.editor}}?house" width="100%" height="550px"> </object>


### Turtle Attributes

In the Grace implementation of Logo, the turtle is an object that has the following attributes:

`penWidth` is the width of the pen, and thus of the line that it will draw.

`penColor` is the color of the pen, and thus of th eline that it will draw.
Supported colors are: `red` `green` `blue` and `black`.  
These attributes behave like variables to which you can assign new values.  

**For example:** you can change the attributes of the turtle by *assigning* to `penWidth` or `penColor`, like this:

    penWidth := 4
    penColor := red
    
You can also change the speed at which the turtle walks by assigning to the variable `speed`

    speed := 1
    forward 20
    speed := 9
    forward 20

Attempts to set the speed to less than 1 are ignored.
  

### Bigger Pictures

By default, logo draws on a small embedded "canvas".  If you want a larger canvas, you can create one in a pop-up window using

    createCanvas(500 @ 300)

The argument to `createCanvas` gives the width (here, `500` pixels) and the height (`300` pixels).  
(You don't need to know this yet, but `(500 @ 300)` is another kind of value: a value of type `Point` that defines a 2-dimensional vector.) 

If you use `createCanvas`, be sure that your web browser is set to [allow pop-up windows](http://www.cengage.com/lms_docs/system_check/popupsfailed/popupsfailed_chrome.htm).
