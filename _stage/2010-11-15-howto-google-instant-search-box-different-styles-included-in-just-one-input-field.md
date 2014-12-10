---
layout: post
title: "HowTo: Google Instant Search-box – different styles included in just one input-field?"
date: 2010-11-15 18:59
author: antje.kilian
comments: true
categories: [HowTo]
tags: []
language: en
---
{% include JB/setup %}
<p>&#160;</p>  <p><img title="image" border="0" alt="image" align="left" src="http://code-inside.de/blog/wp-content/uploads/image_thumb254.png" width="218" height="121" />From time to time I have the passion to think about the basics of web: HTML. I asked myself how google made it possible to mix two different styles into one input-field. If you know it, the answer is easy....</p>  <p>&#160;</p>  <!--more-->  <p><b></b></p>  <p><b></b></p>  <p><b></b></p>  <p><b>two Styles - "one" input box:</b></p>  <p><img title="image" border="0" alt="image" align="left" src="http://code-inside.de/blog/wp-content/uploads/image_thumb255.png" width="137" height="71" />"Autocomplete" text-boxes are nothing new but there is one detail google made a nice little realization of. My keyword was "Tel" (black letters) and it is continued with the first choice (in gray), How does this work?</p>  <p><b>HTML inputfield - just one style</b></p>  <p>For your HTML inputfield you can change the color in every way you want. But you can only choose ONE color.</p>  <p><b>The clue</b></p>  <p><b></b></p>  <p>Because the HTML of googles front page is very complex I searched the Internet for an equal website and found: YouTube instant (Im not sure but I think the clever developer now works for google as well <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile1.png" /> ) - not so difficult and because of this I rebuild the Input-box:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image94.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb3.png" width="182" height="51" /></a></p>  <p>Here we have two input elements above each other. The one with the text offer is gray and the usual search-box in black.</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image95.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb4.png" width="556" height="79" /></a></p>  <p>Here comes the whole HTML:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:fc6e5347-c342-41b6-ab2e-5946d7c2dcb8" class="wlWriterEditableSmartContent"><pre name="code" class="xml">&lt;html&gt;
&lt;head&gt; 

&lt;style&gt;
#searchBox {width:570px;float:right;border:1px solid #A2BFF0;}
#grayText, #search{
	background:none;
	position:absolute;
	width:540px;
	height:30px;
	z-index:100;
	padding-left:5px;

}
#queryBox {height:30px;}
#grayText {z-index:0;color:#C0C0C0;}
&lt;/style&gt;
&lt;/head&gt;
&lt;body&gt;
	&lt;div id="searchBox"&gt;
		&lt;input type="text" id="grayText" disabled="disabled" autocomplete="off" value="Das ist der Suchtext" size="60"&gt;
		&lt;input type="text" autocomplete="off" id="search" value="Das ist der" size="60" name="q"&gt;
	&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;</pre></div>

<p>Now I understand how the Masked Input jQuery Plugins work (I think so, doesn't tested it so far)</p>

<p>For all of you HTML / CSS / Javascrpit experts out there who are laughing about this block post: I really don't know how it works till now. Maybe it's because I'm so in love with .NET. <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile1.png" /></p>
