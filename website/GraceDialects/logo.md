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
draw images can on the screen by controlling a "virtual turtle" with Grace commands.

For more background, see [this wikipedia page][WikiTurtle1]. .

[WikiTurtle1]: https://en.wikipedia.org/wiki/Logo_(programming_language)


## Moving the Turtle

The turtle can be moved forward using `forward(distance)`. This moves our turtle the given distance in its current direction.

To change the direction of the turtle we can use the following methods: `turnRight(degrees)` and `turnLeft(degrees)` to turn the turtle
left and right the given number of degrees. 

**For example:**  

    forward(50)
    turnRight(π/4)
    forward 80

<br>

Notice that each command is followed by a number.  This number is called the “argument” to the command.  If the
number is a complicated expression (like `π/4`), it must be enclosed in parenthesis, so that Grace knows where it starts and ends.  If it's a simple constant like `50` or `80`, the parenthesis are not necessary (but they won't hurt).

***
<div style="text-align: center;" markdown="1">
### Examples
</div>
***

#### Example 1
An example to get us started! The code below draws a square. Modify it to draw a rectangle with
sides whose length = 75.

<object id="example-1" data="{{site.editor}}?square" width="100%" height="550px"> </object>

#### Example 2

This example will iterate across the integers from 50 to 80. Each time the turtle will move forward by i,  
and then turn right by i-7. In this type of iteration (loop), "i" is the current number between 50 and 80.

<object id="example-2" data="{{site.editor}}?logoFor" width="100%" height="550px"> </object>

### Example 3

This is a more complex example that draws a house. Modify it to make it more interesting. 

<object id="example-3" data="{{site.editor}}?LogoExample" width="100%" height="550px"> </object>

### Controlling the Pen

You can lift the virtual pen up using the command `penUp`, and put it back down using the command `penDown`.  

## Numbers

When you use Grace Logo, you will also need to use Numbers.  Grace Numbers behave pretty much as you would expect — `50` is a number, `-20` is a number, and `20/4.5` is a number.  

## Naming Values

It's often useful to give names to expressions involving numbers (or other things).  In Grace there are two kinds of named values: *definitions*, which don't change once they are made, and *variables*, which can be changed by the Grace program.

    def sideLength = 50

    var numberOfRepetitions := 10

Notice that *defs* define a name to be equal to a value, and use the `=` symbol: we are *defining* `sideLength` to be `50`.  Consequently, `sideLength` will always be `50`, so long as `sideLength` has a meaning.

In contrast, *vars* can change over time.  We “assign” a value to a variable using the assignment symbol `:=`.  Later, we can assign another value to the same variable.

    numberOfRepetitions := 9


### Turtle Attributes

In the Grace implementation of Logo, the turtle is an object that has the following attributes:

`lineWidth` is the width of the line to be drawn, such as `3`

`lineColor` is the color of the line to be drawn, such as `red`

Supported colors are: `red` `green` `blue` `black`.  
These attributes behave like variables to which you can assign new values.  

**For example:** you can change the attributes of the turtle by *assigning* to `lineWidth` or `lineColor`, like this:

    lineWidth := 4
    lineColor := red
    
You can change the speed at which the turtle walks by assigning to the variable `speed`

    speed := 1
    forward 20
    speed := 9
    forward 20

Attempts to set the speed to less than 1 are ignored.
  

