# Grace Documentation Website

This is the source for a website that documents the Grace language amnd its libraries, and for tutorial meterial on using Grace.  Examples on the website can be made "live", so that users can edit and run them.

The liveness depends on a simple IDE being installed elsewhere (to which this site will link).  The current location of that IDE is http://www.cs.pdx.edu/~grace/embedded-web-editor; it is sourced from another github repository (http://github.com/gracelang/embedded-web-editor).  The example code referred to
by the tutorials must go in the `examples/` directory of that repository.)

After making changes to this site, `make build` will regenerate it, and `make deploy` will push it to the ~grace/doc at PSU (assuming that you have permssion to login as user "grace").

## How to Add to and Change this Website


### To create a new tutorial folder:

    Open the directory _data/sidebars/tutorial_sidebar.yml
    Type the following: (the vertical bars represent the left of the file)
        |  - title: FolderTitle
        |    output: web
        |    folderitems:
    where FolderTitle is a title of your choosing.

### To create a new tutorial page:

Open the directory _data/sidebars/tutorial_sidebar.yml

Find the tutorial folder it you want to put the tutorial in.

Starting on the line underneath "folderitems:" insert the following: (the vertical bars represent the left of the file)

        |    - title: TutorialTitle
        |      url: someURL
        |      output: web

where TutorialTitle is a title for your tutorial that will appear in the sidebar, and someURL is the in-browser url of your new tutorial page. For example, someURL for the "Conditionals" tutorial in the "Variables" folder might be `/variables/conditionals/`.

Now go to /tutorial/ and create a markdown file for your new tutorial.

The header of the markdown file should be: (the vertical bars represent the left of the file)

        |---
        |title: TutorialTitle
        |keywords: tutorialKeywords
        |summary: Description
        |sidebar: tutorial_sidebar
        |permalink: someURL
        |folder: tutorial
        |---

where TutorialTitle is the title that will appear on the top of your page, tutorialKeywords is a list of keywords in the tutorial, separated by commas, and someURL is the same as the previous someURL.

The last line of your markdown file should be the following: (the vertical bars represent the left of the file)

        |<object id="example-1" data="{{site.editor}}?graceFile" width="100%" height="550px"> </object>

where graceFile is the name of the grace file that corresponds to this tutorial (without the .grace extension).

Finally, create a corresponding Grace program for the embedded web editor and save it into the embedded-web-editor git repository under `examples/`.

## Navigation

The folder structure of the source files is irrelevant.  Each source file will be converted by Jekyll into an file in `_site` at a position dictated by the permalink in its header.
Navigation is contolled by files in the `_data` directory:
 
 * `_data/topnav.yml` controls what appears in the blue bar at the top of every page in the site
 * `_data/sidebars/*.yml` contols what appears in the sidebar of the corresponding named pages, so (I presume) that `sidbars/tutorial_sidebar.yml` determines the sidebar for tutorials.

## To change the site's base URL

Edit `_config.yml`'s _url_ and _baseurl_ values (located near the top) to contain the site's desired location.  Notice that (counterintuitively) _url_ already includes _baseurl_ as a suffix; in other words, _baseulr_ is the part of _url_ after the protocol and host name.

Similarly, to specify the embedded web editor's location, edit `_config.yml`'s _editor_ value.
