---
title: The logo Dialect
keywords: Logo, drawing, turtle graphics
summary: "Logo is a dialect used to intorduce simple graphics.  The Logo “turtle” can be moved around the screen, leaving a trail of ink behind it."
sidebar: dialects_sidebar
permalink: /dialects/logo/
toc: false
folder: Dialects
---

## Introduction

Welcome to a beginners guide to using _Logo_ in Grace. In case you have not heard of Logo before, it is a educational programming language that dates back to the 1960s, and best known for _Turtle Graphics_.

Imagine a mechanical turtle-like robot that holds a pen and can walk around the floor, on which is spread a large sheet of paper.  As the turtle moves, it draws a line — unless it lifts the pen off of the paper, in which case it moves without drawing.

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


### Example 1
Here is an example to get us started! The code below draws a square. Modify it to instead draw a rectangle of width 150 and height 75.

<object id="example-1" data="{{site.editor}}?square" width="100%" height="550px"> </object>



### Example 2

This example draws a five-pointed star.
It shows a new construct, `repeat(_)times(_)`,
which you can use to tell Grace to repeat an action
several times.

When you want to repeat a series of actions a known number
of times, here, `5`, you could type the commands 5
times — that's what we did when drawing the square
in Example 1.
But it's shorter, and easier to understand,
to use a `repeat(_)times(_)`, as shown here.
Notice that the block of code that we want to repeat is
indicated in **two** ways:
it is indented, and it is enclosed in `{` braces `}`.
Grace requires us to do _both_.

<object id="example-2" data="{{site.editor}}?5-star-simple" width="100%" height="550px"> </object>

<p></p>
Run the code.
The star looks as though it's standing rather uncomfortably on one leg!
Can you modify the program so that the
star is standing upright on two of its legs?

## Defining Methods

Grace Logo's turtle knowns how to do a very limited number of things: move
`forward(distance)`, `turnRight(angle)`, and so on.  We can make it more
capable by teaching it a method for doing something new.  As its
programmer, you are in charge of teaching your turtle new methods.

### Example 3

This example also draws a five-pointed star.
This time, though, we first "teach"
the turtle how to draw a star (lines 3--8).
To do this, we tell Grace about the _method_ for drawing a star
using the _method declaration_ on lines 3 to 8

A method declaration contains 6 parts:
 1. It starts with the _keyword_ `method`.
 2. This is followed by a name, chosen by the programmer, in this case `fiveStar`.
 3. Then comes a left brace `{`; this indicates the start of the _method body_
 4. After the brace is a comment, in English, that describes what the method does.
This comment appears on a line by itself.
We know that it's a comment because it starts with `//`.  Comments are
there to help the programmer; they are ignored by Grace.
 5. Following the comment, we write the commands that we want the turtle
to execute when we request it to do a `fiveStar`.
 6. After the last command, we write a right brace `}` on a line by itself.
The right brace should be immediately below the keyword `method`, because it
marks the end of the method declaration.

One we have defined a method in this way, we can request that the turtle does
what we have just taught it.
We make this request on line 14, simply by writing the name of the method.
If we give our methods meaningful names,
we can make our programs much more readable by
first teaching Grace a method, and then requesting that method by name.

<object id="example-3" data="{{site.editor}}?5-star" width="100%" height="550px"> </object>



## Controlling the Pen

You can lift the virtual pen up using the command `penUp`,
and put it back down using the command `penDown`.
When the pen is "up", it's tip isn't touching the
"paper", so it doesn't draw a line.

As we saw in Example 3, you can also change the color of the pen by _assigning_ to
the variable `penColor`.  The turtle knows about the colors `red`, `green`, `blue`,
`black`, `yellow`, `white`, `magenta`, `cyan`, and `sienna` (a shade of brown).

Example 3 illustrates one more thing that you can change about the turtle:
the speed with which it moves.

### Example 4

This is like Example 3, but we use the `star` method _twice_,
to draw two stars of differing colors.
Before we draw the second star, we move the turtle to the left,
with the pen up.

<object id="example-3" data="{{site.editor}}?5-star-twice" width="100%" height="550px"> </object>

<p></p>
Can you apply your fix—the one that stands the star firmly on its own
two legs—to this program?
Notice that if you modify the method `fiveStar`,
then _both_ stars will stand up straight.


## Numbers

When you use Grace Logo, you will also need to use Numbers.
In fact, we have been using numbers all along in the
examples. Grace Numbers behave pretty much as you would expect:
`50` is a number, `-20` is a number, `2 + 3` is a number, and `20/4.5` is a number.
Grace also knows about the number `π` (3.1415926535897932…).

## Naming Values

It's often useful to give names to expressions involving numbers (or other things).
In Grace there are two kinds of names:
_**def**initions_, which don't change once they are made,
and _**var**iables_, which can be changed by the Grace program.

    def sideLength = 50

    var numberOfRepetitions := 10

Notice that a `def` defines a name to be equal to a value; it uses the `=` symbol:
we are *defining* `sideLength` to be `50`.
Consequently, `sideLength` will _always_ be `50`, so long as `sideLength` has a meaning.

In contrast, a `var` can change over time.  We “assign” a value to a variable
using the assignment symbol `:=`.
Later, we can assign a _different_ value to the same variable, like this:

    numberOfRepetitions := 9

## Method with Parameters

You will have noticed that in Example 4, the two methods that we defined were
pretty specific: `fiveStar` drew a star with lines of length 100, and `moveLeft`
moved the turtle left by 120 pixels.

Using Grace's ability to name and remember values, we can make these method more
general, and thus more useful.  We do this by adding a declaration of a
_parameter_ after the name of the method, like this:

```
method fiveStar(size:Number) {
    // draws a 5-pointed star using 5 lines of length `size`
    repeat 5 times {
        forward(size)
        turnRight 144
    }
}
```

The name of the parameter is `size`, and it is expected to be a `Number`.  When
we request that the turtle execute this method, we have to say exactly what number;
we do this by providing an _argument_ in the request, for example:

```
fiveStar(100)
fiveStar(10)
fiveStar(150)
```

Now, when Grace executes the method, it will replace the parameter `size` by the value
of the argument: `100`, `10`, and `150` in these examples.

Notice that the name of the method has also been changed: it was `fiveStar`,
and is now `fiveStar(_)`.  In Grace, methods that have parameters have
parenthesis in their names; when we request them, we have to provide arguments
to "fill" those parentheses.

### Example 5

Here we add parameters to both `fiveStar` and `moveLeft`, and provide arguments
when we request them.  This tells the turtle to draw two stars with different sizes.

<object id="example-3" data="{{site.editor}}?5-star-params" width="100%" height="550px"> </object>


### Example 6

This example draws a stylized house. It's a bit more complex because we start
(on line 8) by telling the turtle to `moveToBottomLeft`,
which isn't something that it already knows how to do.
Scroll down and you will see that on lines 44–54 we *teach* the turtle how to
`moveToBottomLeft` by declaring a _method_ with that name.
The method defines `moveToBottomLeft` in terms of simpler things that the
turtle *does* know how to do.

Similarly, this example (on lines 33–43) teaches the
turtle a method for drawing a `wall(_,_)`.
This is used on line 9.

Try modifying this example to give the house a door and a window.

<object id="example-3" data="{{site.editor}}?house" width="100%" height="550px"> </object>


## Turtle Attributes

In the Grace implementation of Logo, the turtle is an object that has the following attributes:

 * `penWidth` is the width of the pen, and thus of the line that it will draw.

 * `penColor` is the color of the pen, and thus of the line that it will draw.  The pre-defined colors are `red` `green` `blue`, `black`,
`yellow`, `white`, `magenta`, `cyan` and `sienna`.   If you want other colors, you can define them using **r g b** coordinates; you can
find the **r g b** coordinates for colors on the web, e.g., [here](http://cloford.com/resources/colours/500col.htm).

These attributes behave like variables to which you can assign new values.

**For example:** you can change the attributes of the turtle by *assigning* to `penWidth` or `penColor`, like this:

    penWidth := 4
    penColor := red
    forward 10
    def darkOrange = r 255 g 140 b 0
    penColor := darkOrange

 * `speed` is the speed at which the turtle walks. You can change the speed by assigning to the variable `speed`.

**For example:**

    speed := 1
    forward 20
    speed := 9
    forward 20

Attempts to set the speed to less than 1 are ignored.

You can ask for the turtle's current position using `position` and its heading using `angle`.
The position is a `Point` object, like 56@12.  The turtle always starts out in the center of the canvas.
The angle is measured in degrees, with North being zero.

## Bigger Pictures

By default, logo draws on a small embedded "canvas".  If you want a larger canvas, you can create one in a pop-up window using

    createCanvas(500 @ 300)

The argument to `createCanvas` gives the width (here, `500` pixels) and the height (`300` pixels).
(You don't need to know this yet, but `(500 @ 300)` is another kind of value: a value of type `Point` that defines a 2-dimensional vector.)

If you use `createCanvas`, be sure that your web browser is set
to [allow pop-up windows](http://www.cengage.com/lms_docs/system_check/popupsfailed/popupsfailed_chrome.htm).
