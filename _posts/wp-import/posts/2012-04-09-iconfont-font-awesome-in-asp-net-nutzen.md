---
layout: post
title: "Iconfont “Font awesome” in ASP.NET nutzen"
date: 2012-04-09 23:29
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, Font, Web]
---
{% include JB/setup %}
<p>Vor <a href="http://code-inside.de/blog/2012/03/12/metro-monochrome-icons-als-font-family-fr-web-apps/">einiger Zeit</a> hatte ich schon auf das <a href="http://fortawesome.github.com/Font-Awesome/">Font Awesome Projekt</a> hingewiesen. Ursprung des Projektes ist das <a href="http://twitter.github.com/bootstrap/">Twitter Bootstrap UI Kit</a>, allerdings kann man es auch ganz ohne Bootstrap in seine Anwendung integrieren.</p> <p><strong>Default ASP.NET (MVC…) WebApp erstellen</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1498.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb669.png" width="157" height="244"></a></p> <p><strong>“Font Awesome” Fonts und CSS <a href="http://fortawesome.github.com/Font-Awesome/">runterladen</a> und ins Projekt intergrieren</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1499.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb670.png" width="244" height="180"></a></p> <p><strong>Font-Sourcen überprüfen</strong></p> <p>Wenn man es nach meiner Struktur macht, muss man die <strong>font-awesome.css</strong> noch bearbeiten und die Links zu den Schriftarten anpassen, so wie hier:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6b9d6af6-ac20-481d-b20b-6d5a25b6f596" class="wlWriterEditableSmartContent"><pre name="code" class="c#">@font-face {
    font-family: 'FontAwesome';
    src: url('font/fontawesome-webfont.eot');
    src: url('font/fontawesome-webfont.eot?#iefix') format('embedded-opentype'), url('font/fontawesome-webfont.woff') format('woff'), url('font/fontawesome-webfont.ttf') format('truetype'), url('font/fontawesome-webfont.svgz#FontAwesomeRegular') format('svg'), url('font/fontawesome-webfont.svg#FontAwesomeRegular') format('svg');
    font-weight: normal;
    font-style: normal;
}</pre></div>
<p>&nbsp;</p>
<p>Dann noch in der Layouts einbinden:</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;link rel="stylesheet" type="text/css" href="Url.Content(“~/Content/font-awesome.css”)" /&gt;</p>
<p><em>Leider ist es mir bislang nicht gelungen die CSS über <a href="http://code-inside.de/blog/2010/02/08/howto-javascript-und-css-datein-gebndelt-und-komprimiert-mit-combres-asp-net-mvc-ausliefern/">Combres</a> oder (in MVC 4 neu) über die Bundles mit auszuliefern. Das ganze endet darin, dass die Font-Dateien nicht gefunden wurden. Mhh…</em></p>
<p>Und benutzen:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:06b20e89-d2df-47aa-a146-d7f9b66f8961" class="wlWriterEditableSmartContent"><pre name="code" class="c#">                    &lt;p class="site-title"&gt;&lt;i class="icon-cog"&gt;&lt;/i&gt; ASP.NET &lt;i class="icon-heart" style="font-size: 50px;"&gt;&lt;/i&gt; Icon Fonts!&lt;/p&gt;</pre></div><a href="{{BASE_PATH}}/assets/wp-images/image1500.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb671.png" width="544" height="161"></a>
<p>&nbsp;</p>
<p>Alles was man mit CSS machen kann, kann man natürlich auf diese Icons anwenden. Was ziemlich genial ist!</p>
