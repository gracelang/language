---
title: The Grace Language 
tags: [getting_started]
sidebar: home_sidebar
toc: false 
type: homepage
---

Welcome to the Grace programming language. Grace is easy to use; there is nothing to install, and you can use it on 
almost any computer that runs a web browser.  If you're just beginning programming, check out [**our tutorial**]({{site.baseurl}}/introduction/grace/).
If you have more experience, you can get started right away with the [web-based program editor](http://web.cecs.pdx.edu/~grace/ide/).

## Using this Website

This website aims to collect the documentation about Grace and its libraries.  This is the _Home page_; you can reach it at any time 
by clicking the house icon, or the words **Grace Documentation**, in the the blue navigation bar at the top of every page.  The other items in 
that navigation bar give access to several different kinds of information.

 * **Tutorial**: a set of pages that are intended to help beginning programmers. They aim to be like an online textbook that contains live examples.
   These pages are a work-in-progress.  The tutorial also describes [how to use Grace's web-based program editor]({{site.baseurl}}/IDE/introduction/).

 * **Specification**: the specification of the Grace programming language.  This is a document that describes the whole language as presently defined.
   Much of it will not be accessible to novices; it's intended for instructors, language implementors, and programming-language researchers.

 * **Modules**: this pull-down menu lists a growing collection of external modules that are available to the Grace programmer.
   Modules make available features that are useful to Grace programmers but that are not part of the base language.

 * **Dialects**: this pull-down menu lists available Grace dialects.  Dialects are special modules that extend or restrict the Grace language
   for specific purposes.  In particular, some of Grace's dialects are designed to support specific teaching objectives.  The Dialects menu also
   gives access to a page that describes how instructors can write their own dialects. One of the most important dialects is 
   [_standardGrace_]({{site.baseurl}}/dialects/standard), the dialect in which you are writing if you specify no other.  The documentation for _standardGrace_
   describes the methods available on the standard [_String_]({{site.baseurl}}/dialects/standard/#string), [_Number_]({{site.baseurl}}/dialects/standard/#number),
   and [_Collection_]({{site.baseurl}}/dialects/standard/#collection-objects) objects.

Within each section of the website, the _left sidebar_ provides additional navigation.  On this page, it gives quick access to materials that can also be found
using the top navigation bar.  Within each section, it provides local navigation; for example within the Tutorial, it lists the tutorial topics.

## What is Grace? 

Grace is a language designed specifically to make it easier for new programmers to learn to program.  It's small,
concise, and amazingly powerful. If you are a beginner, you needn't concern yourself with any of the material below, 
but if you are familiar with other languages, it may give you a better idea of how Grace is different.

<html>
 <div class="row">
        <div class="col-lg-12">
              <ul id="myTab" class="nav nav-tabs nav-justified">
                <li class="active"><a href="#service-one" data-toggle="tab"> Teaching</a>
                </li>
                <li class=""><a href="#service-two" data-toggle="tab"> Design</a>
                </li>
                <li class=""><a href="#service-three" data-toggle="tab"> Functionality</a>
                </li>
                <li class=""><a href="#service-four" data-toggle="tab"> Other</a>
                </li>
            </ul>
            <div id="myTabContent" class="tab-content">
                <div class="tab-pane fade active in" id="service-one">
                    <h4>Teaching</h4>
                    <p> Grace incorporates many recent programming language advances to make your programs shorter and simpler.  However, it is still
                    quite powerful enough to write "real" programs — for example, the Grace implementation is itself written in Grace.  Grace leaves 
                    out a lot of the boilerplate that lards other languages; this  makes it easier for new students to focus on the essentials of programming.</p>
                    <p>Grace also allows instructors to write <i>dialects</i>, which are variants of Grace with specific teaching objectives.
                       For example, there is a <i>logo</i> dialect for turtle graphics, and a <i>minitest</i> dialect for introducing test-driven programming.</p>
                </div>
                <div class="tab-pane fade" id="service-two">
                     <h4>Design</h4>
                     <p>Grace was designed as an object-oriented language, but with significant "functional" and "procedural" sub-components.
                        Dialects allow instructors to both add and remove features. In this way, Grace accommodates many different teaching styles. </p>
                </div>
                <div class="tab-pane fade" id="service-three">
                     <h4>Functionality</h4>
                     <p> Grace is a full-object-based language, and also includes some features that are not object-based, such as pattern matching.
                     This enables instructors to compare various programming styles without leaving the language.</p>
                     <p> Grace has an object-oriented type system, but its use is optional.  Variables and methods that are not annotated with types are
                     assumed to have type `Unknown`, and are not checked.  At the instructor's discretion, dialects can be used to require type annotations.</p>
                </div>
                <div class="tab-pane fade" id="service-four">
                     <h4>Other Resources</h4>
                     <p>Grace has been described in <a href="http://gracelang.org/applications/articles-projects/publications-about-grace/">several technical papers</a> presented at international programming language conferences.  The website for discussing Grace's design is <a href="http://gracelang.org">gracelang.org</a>.</p>
                </div>
            </div>
        </div>
 </div>
</html>
