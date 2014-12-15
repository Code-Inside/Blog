---
layout: post
title: "The Retina/HiRes Displays are comming! HD-Web ahoi!"
date: 2012-05-24 10:32
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;



The best part of the IPad3? The Display. After <a href="http://www.codinghorror.com/blog/2007/06/where-are-the-high-resolution-displays.html">years of waiting for High Resolution Display</a> there are now some movements in the market. Of course this has an important influence on web-development because nobody wants to see washed-out Pictures or even worse: a totally broken design. How am I able to identify a High-Resolution Display? What do I have to take into consideration?

<em>I’m not a full-time Web Designer, so please forgive me if this article isn’t perfect at all <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile38.png" alt="Zwinkerndes Smiley" />. I’m glad to hear your suggestions in the comments! </em>

<em> </em>

<strong>What’s special about the Retina/High Resolution Displays?</strong>

The pixel density is much higher on these Displays so you are able to see pictures with many details. I found this comparison between iPad2 and iPad3 on <a href="http://www.theverge.com/">TheVerge.com</a>

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb688.png" border="0" alt="image" width="409" height="264" />

Impressing isn’t it?

<strong>High Resolution Pictures on Hi-Res / Retina Displays</strong>

At the moment more and more Javascript-libraries appear and their basic structure seems to be geared to Apple. With the introduction of the <a href="http://developer.apple.com/library/ios/#documentation/2DDrawing/Conceptual/DrawingPrintingiOS/SupportingHiResScreens/SupportingHiResScreens.html">iPhone 4 Apple published a naming scheme</a>:

<strong>Non-Retina-Displays:</strong> My-Picture.png

<strong>Retina-Displays:</strong> My-Pictue@2x.png

The idea is that the framework takes the high resolution pictures automatically if there are some. With that both Retina and Non-Retina-Displays get their chance to shine.

<strong>How Apple delivers Pictures for the iPad3 on Apple.com </strong>

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image1522.png" border="0" alt="image" width="540" height="326" />



<em>(Picture from <a href="http://apple.com/">Apple.com</a>)</em>

Of course first of all Apple implemented a support for the iPad3 Display on Apple.com. Here you will find a complete analyze what apple doe’s in detail. In fact it works like this:

- Usual Apple.com side will be downloaded including the pictures

- Script check if it’s an iPad with Retina Displays

- If it’s a Retina Display:

- For some pictures (for example the main picture on Apple.com) there is a HEAD request for the 2x.png picture (I don’t know why Apple leaved out the “@”)

- If a picture is found they are going to download it and replace it

If you want to test it for yourself enter this Codes into the Chrome Console:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:910d0256-5cbd-49bd-9035-ee7e4d817b2b" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">AC.Retina._devicePixelRatio = 2
new AC.Retina</pre>
</div>
It needs to be accented that this means a lot of work for the data line because the pictures needs to be downloaded twice and the Retina images are much bigger.

Non-Retina:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb689.png" border="0" alt="image" width="599" height="54" />

Retina-Display:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb690.png" border="0" alt="image" width="609" height="59" />

The Retina Version is <strong>three times</strong> bigger than the normal size!

<strong>Retina-JavaScripts for your own WebApp</strong>



<a href="http://retinajs.com/">Retina.js</a> works almost in the same way and it abides by the naming scheme from the iOS Device (with @2x)

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image1525.png" border="0" alt="image" width="524" height="336" />

All you have to do is to implement the Script and it will start searching for every img-Tag on the Site and check if there is a Retina Version.

For Background-pictures in CSS there is a <a href="https://github.com/imulus/retinajs/blob/master/src/retina.less">.LESS Mixin</a> which creates a Media-Query and deliver the adequate picture. That means Retina Displays get a HighRes Version and non HighRes gadgets get a normal version of the image.

The Code is on <a href="https://github.com/imulus/retinajs">GitHUb</a>. Disadvantages on this option: Like on Apple the pictures need to be downloaded twice.

Foresight.js is already working on this problem. The Script should be able to check if it’s a HighRes Display before the actual download of the pictures. There are <a href="http://foresightjs.appspot.com/demos/">some Demos</a> but unfortunately you need a HighRes Display (which I don’t have). From the Features only it seems to be a little bit smarter than Retina.js:

· <em>Request hi-res images according to device pixel ratio</em>

· <em>Estimates network connection speed prior to requesting an image</em>

· <em>Allows existing CSS techniques to control an image’s dimensions within the browser</em>

· <em>Implements image-set() CSS to control image resolution variants</em>

· <em>Does not make multiple requests for the same image</em>

· <em>Javascript library and framework independent (ie: jQuery not required)</em>

· <em>Image dimensions set by percents will scale to the parent element’s available width</em>

· <em>Default images will load without javascript enabled</em>

· <em>Does not use device detection through user-agents</em>

· <em>Minifies to 7K</em>

<strong>

Loading pages for Websites again soon? When High-Res doesn’t make fun at all….</strong>

On the one hand its grate if every website tries to shine with High-Resolution Pictures because clear and defined pictures make fun but if you don’t own a fast internet connection or if you try to surf on the way it could be very annoying. At the moment you can get UMTS everywhere but there is always a data limit and the <a href="http://www.zdnet.de/magazin/41515603/internet-per-umts-so-faelschen-deutsche-provider-webinhalte.htm">Provider manipulate the web</a> to save Bytes. If you are forced to see waiting pages before you are able to enter the website (like it happens with Flash in the past)?

<strong>SVGs, Icon-Fronts &amp; Responsive Designs</strong>



I’ve only spoken about pictures so far but of course there are many subjects left. One subject is how to deal with Icons – maybe Icon-Fonts are an interesting subject. The issue Responsive Design and SVGs plays an important role as well – for this topic I found an <a href="http://medialoot.com/blog/high-resolution-web/">interesting Blogpost</a>.



<strong>Will there be HighRes Displays for Windows as well and experiences with Web-development with HighRes Images?</strong>



Even though I’ve wrote about High-Res displays all the time the only one I know is the iPad 3 display. Does somebody know another one? Or will there be an upgrade <a href="http://blogs.msdn.com/b/b8/archive/2012/03/21/scaling-to-different-screens.aspx">with Windows 8</a>? If you own a Mac (and an iPad3) you are able to use it as a High-Res display. If you know alternatives in the world of Windows please tell me <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile38.png" alt="Zwinkerndes Smiley" /> Do you know somebody who is already providing special pictures for the iPad3?

By the way: If you think about getting an iPad3 you are welcome to do it via <a href="http://astore.amazon.de/codeinside-21/detail/B007IV5PI6">this Amazon link</a> and support our work <img class="wlEmoticon wlEmoticon-openmouthedsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-openmouthedsmile3.png" alt="Smiley mit geöffnetem Mund" />
