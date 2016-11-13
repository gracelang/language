---
title: The Grace Language 
tags: [getting_started]
sidebar: home_sidebar
toc: false 
type: homepage
---

Welcome to the Grace programming language. These web pages are designed to provide a comprehensive overview of 
Grace and its accompanying documentation. 

## Using Grace 

Using Grace could not be easier. If you're just beginning programming, checkout [**our tutorial**]({{site.baseurl}}/introduction/grace/).
Otherwise, if you have more experience, you can get started with the [web-based editor](http://web.cecs.pdx.edu/~grace/ide/). 

## What Is Grace? 

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
                    quite powerful enough to write "real" programs — for example, the Grace implementation is itself written in Grace.  Grace leaves out a lot of the boilerplate that lards other languages; this  makes it easier for new students to focus on the essentials of programming.</p>
                    <p>Grace also allows instructors to write <i>dialects</i>, which are variants of Grace with sepcific teaching objectives.                      For example, there is a <i>logo</i> dialect for turtle graphics, and a <i>minitest</i> dialect for introducing test-driven programming.</p>
                </div>
                <div class="tab-pane fade" id="service-two">
                     <h4>Design</h4>
                     <p>Grace was designed as an object-oriented language, but with significant "functional" and "procedural" sub-components.                     Dialects allow instructors to both add and remove features. In this way, Grace accommodates many different teaching styles. </p>
                </div>
                <div class="tab-pane fade" id="service-three">
                     <h4>Functionality</h4>
                     <p> Grace is a full-object-based langauge, and also includes some features that are not object-based, such as pattern matching.
                     This enables instructors to compare various progarmming styles without leaving the language.</p>
                     <p> Grace has an object-oriented type system, but its use is optional.  Variables and methods that are not annotated with types are
                     assumed to have type `Unknown`, and are not checked.  At the instructor's discretion, dialects can be used to require type annotations.</p>
                </div>
                <div class="tab-pane fade" id="service-four">
                     <h4>Other Resources</h4>
                     <p>Grace has been described in <a href="http://gracelang.org/applications/articles-projects/publications-about-grace/">several technical papers</a> presented at international programming conferences.  The website for discussing Grace's design is <a href="http://gracelang.org">gracelang.org</a>.</p>
                </div>
            </div>
        </div>
 </div>
</html>
