---
title: "Type: Text"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /Text/
folder: grace-docs
---

### Definition
`Text ->  `[`Graphic`](/grace-documentation/Graphic) `&``type``{...added methods below...}`

### Description
Text that can be drawn on a canvas.

### Properties
- `contents  —> `[`String`]({{site.baseurl}}/404)  
return the contents displayed in the item
  
- `contents:= (s: `[`String`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
reset the contents displayed to be s
  
- `width  —> `[`Number`]({{site.baseurl}}/404)  
return width of text item (currently inaccurate)
  
- `fontSize  —> `[`Number`]({{site.baseurl}}/404)  
return size of the font used to display the contents
  
- `fontSize:= (size: `[`Number`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
Set the size of the font used to display the contents
  
