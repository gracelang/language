---
title: "Type: Audio"
keywords: mydoc
sidebar: grace-doc-sidebar
toc: false
permalink: /Audio/
folder: grace-docs
---

### Definition
`Audio ->  {...added methods below...}`

### Description
An audio file that can be played

### Properties
- `source  —> `[`String`]({{site.baseurl}}/404)  
The source URL of the audio.
  
- `source:= (value: `[`String`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
  
- `play  —> `[`Done`]({{site.baseurl}}/404)  
Play the audio.
  
- `pause  —> `[`Done`]({{site.baseurl}}/404)  
Pause playing the audio.
  
- `isLooping  —> `[`Boolean`]({{site.baseurl}}/404)  
does the audio loop back to the start?
  
- `looping:= (value: `[`Boolean`]({{site.baseurl}}/404)`) —> `[`Done`]({{site.baseurl}}/404)  
determine whether the audio will loop
  
- `isEnded  —> `[`Boolean`]({{site.baseurl}}/404)  
whether the audio has finished
  
