---
title: "Class: textAt()with()on"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /textAt()with()on/
folder: grace-docs
---

### Definition
Class: textAt()with()on  

### Description
Not currently available...  

### Properties
  
- `width -> `[`Number`]({{site.baseurl}}/404)  
- `draw ( ctx: `[`Foreign`](/grace-documentation/Foreign)`) -> `[`Done`]({{site.baseurl}}/404)  
Draw the text
- `contents -> `[`String`]({{site.baseurl}}/404)  
Return the string held in the text item (i.e., its contents)
- `contents:= ( newContents: `[`String`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Reset the contents to newContents
- `fontSize:= ( size': `[`Number`]({{site.baseurl}}/404)`) -> `[`Done`]({{site.baseurl}}/404)  
Reset the font size to size'
- `fontSize -> `[`Number`]({{site.baseurl}}/404)  
Return the size of the font
- `asString -> `[`String`]({{site.baseurl}}/404)  
Return string representation of the text item

### Definitions
- `var theContents -> `[`String`]({{site.baseurl}}/404)  
- `var fsize -> `[`Number`]({{site.baseurl}}/404)  
- `var wid -> `[`Number`]({{site.baseurl}}/404)  
Return approximation of the width of the text
