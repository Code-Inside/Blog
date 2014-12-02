---
layout: post
title: "What does Adobe in the flash-free web? Magazine-Style Layouts with CSS Regions!"
date: 2012-04-09 15:46
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

Adobe is well known for Photoshop and Flash but of course there is a lot more. According to the <a href="http://code-inside.de/blog/2012/03/14/cutting-edge-chrome-web-platform-technologies/">“Future Post” from Google</a> Adobe declared one of their big subjects <a href="http://blogs.adobe.com/webplatform/2012/03/16/css-regions-one-year-in/">on a Blogpost</a>. I’m talking about the W3C Working Draft to CSS Regions. Adobe cooperates with the WebKit Team and W3C on this.

<strong> </strong>

<strong>What are CSS Regions?</strong>

CSS Regions are meant to amplify the options for Text-Layout in the web. Here is a video from adobe:

&nbsp;
<div id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:99a4b9d0-aa88-4af6-8787-508df8c4f4a7" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<div><object width="414" height="232"><param name="movie" value="http://www.youtube.com/v/SEdC2V9TTYs?hl=en&amp;hd=1" /><embed type="application/x-shockwave-flash" width="414" height="232" src="http://www.youtube.com/v/SEdC2V9TTYs?hl=en&amp;hd=1"></embed></object></div>
</div>
At first Adobe proposed a big standard with more Use-Cases. To bring the parts quicker through the standardization (and to make the standard more “serviceable”) there are three models:

<strong>CSS Regions</strong><em> </em><em>includes named flows and region chains that allow for complex, magazine-style layouts.</em><strong>CSS Exclusions</strong><em> </em><em>defines ways to flow inline content around and inside shapes that are either defined in CSS or extracted from content.</em><em> </em><strong>CSS Fragmentation</strong><em> </em><em>defines how content breaks between pages, columns or regions.</em>

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb648.png" border="0" alt="image" width="476" height="337" />

<img title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb649.png" border="0" alt="image" width="497" height="569" />

<em> </em>

CSS Fragmentation is the Working Draft to <a href="http://www.w3.org/TR/css3-multicol/">Multicolumn Layout</a> and <a href="http://www.w3.org/TR/css3-page/">Paged Media.</a>

The aim of all models is to put the varying design Layout from the world of magazines into the web.

<strong>Status of the standardization </strong>

According to Adobe there are still some dubieties. Standardization or not – It would be more interesting which Browser provider is going to support this?

<strong>Browser Support at the moment </strong>

<strong> </strong>

<span style="text-decoration: underline;">WebKit Nightlies</span>

<span style="text-decoration: underline;"> </span>

Not interesting at all for usual users because you are using WebKit via Chrome or Safari “indirectly” but for completeness – it is implemented into Nightlies and it works.

<span style="text-decoration: underline;">Chrome</span>

Implimented and activated in version 17 and 18 – but it will be deactivated in version 19 again and you need to reactivate on “about:flags” ( I guess the WebKit team was a little bit carefree <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile37.png" alt="Zwinkerndes Smiley" />). In the Chrome Nightlies (Canary Builds) it is usually deactivated as well.

<span style="text-decoration: underline;">Internet Explorer</span>

<span style="text-decoration: underline;"> </span>

What a big surprise: Implemented and activated in the IE 10 Developer Preview!

<span style="text-decoration: underline;">Firefox</span>

Mozilla included it into the <a href="https://wiki.mozilla.org/Platform/Roadmap">Roadmap for 2012</a> after all <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile37.png" alt="Zwinkerndes Smiley" />

<strong> </strong>

<strong>More Information’s</strong>

You will find more background information’s on the <a href="http://blogs.adobe.com/webplatform/2012/03/16/css-regions-one-year-in/">Adobe Blogpost</a> and there is also a <a href="http://www.youtube.com/watch?feature=player_detailpage&amp;v=zH5bJSG0DZk#t=6657s">video from Paul Irishih</a> (from the Chrome team) where he shows the Demos from Adobe as well.
