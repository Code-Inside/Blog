---
layout: post
title: "Visual Studio Toolbars & Context-Menu cleanup / adjust"
date: 2011-08-14 20:59
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: [Visual Studio]
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

Visual Studio has a lot of functions and shows in the standard adjustment a lot of overloaded Toolbars and Context-Menus. The result is that Visual Studio seems to be much overcharged – at least for me. So here comes the ultimate Quick tip: we are going to blend out everything that is not necessary.

<strong>Adjust Toolbars</strong>

<strong> </strong>

That’s what my VS Toolbar looked like before:

<strong><img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb512.png" border="0" alt="image" width="609" height="62" /></strong>

<strong>Problem:</strong>

a) There are two lines because the “Toolbar-Categorys” are placed unpractical

b) I’ve never used some of this Symbols

<strong>Solution:</strong>

Click right on the Toolbar and erase the dispensable symbols.

In my case it was just the “Web Platform Installer” (I didn’t get why this is useful anyway but so what)

Intermediate result:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb513.png" border="0" alt="image" width="573" height="49" />

Now to my point b)

At the arrows you can adjust the visible Buttons with “Add or Remove Buttons”:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb514.png" border="0" alt="image" width="329" height="272" />

Some Toolbars are depending on the filetype – XSLT and XML buttons you will find only in files which includes XML.

Result (because I didn’t used the other buttons):

&nbsp;

<a href="http://code-inside.de/blog/wp-content/uploads/image1333.png"><img title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb515.png" border="0" alt="image" width="423" height="70" /></a>

Same thing in the Debug view:

Way better <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile23.png" alt="Zwinkerndes Smiley" />

<strong> </strong>

<strong>Edit the Context-menus </strong>

<strong> </strong>

It’s also possible to edit the Context-menus but in fact depending on which Plugins/SDKs you have installed there are numerous options and it’s not easy to find the right on. I’m sure it’s possible to edit every button of the Context-menus:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb517.png" border="0" alt="image" width="385" height="405" />

Sometimes the Buttons/Functions are double because of this I didn’t found out how to get the “Convert to Web Application” Button out of the Project Context-Menu (after 15 Minutes of searching I’ve aborted it.

But it’s possible to add new functions like for example “Start <a href="http://www.rickglos.com/post/How-to-run-windows-batch-files-from-Visual-Studio-2010-Solution-Explorer.aspx">Batch Files on a Context-Menu Entry”.</a>

<strong>Erase dispensable Buttons </strong>

Test it out if you need all of the Buttons in the 5 Toolbars of Visual Studio. For me it’s very confortable to work with the slim Visual Studio. If you have installed for example the Visual Studio Power Tools you should think of using the Solution Navigator instead of the classic Solution Explorer – both is IMHO dispensable (both have their Advantages and Disadvantages <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile23.png" alt="Zwinkerndes Smiley" /> ).

Reslut: It’s possible to edit the Context-Menu of Visual Studio but it takes a lot of time <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile23.png" alt="Zwinkerndes Smiley" />.
