---
layout: post
title: "HowTo: Searchprovider / Browserplugin for IE7 and Firefox - the OpenSearchDescription"
date: 2008-04-09 20:21
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [Browser, Firefox, HowTo, IE, IE7, OpenSearchDescription, Xml]
language: en
---
{% include JB/setup %}
<p>Firefox (or Opera, Safari?) introduced a very handy feature: A little searchbox for all your favorite search engines. Microsoft added this in the Internet Explorer 7:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image3.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="225" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb3.png" width="244" border="0" /></a> </p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image4.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="157" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb4.png" width="244" border="0" /></a> </p>
<p>But how can I create my own plugin? The search provider should be installed with only one click.</p>
<p>The little search box and its provider relies on the &quot;<a href="http://msdn2.microsoft.com/en-us/library/bb891764.aspx">OpenSearchDescription</a>&quot; format. </p>
<p>I added a search provider for this blog - here is the XML:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1a234a8e-929d-464f-84a2-797162c1978d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
<pre name="code" class="c#">&lt;?xml version="1.0"?&gt;
&lt;OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/"&gt;
&lt;ShortName&gt;Code-Inside International Blog&lt;/ShortName&gt;
&lt;Description&gt;Blogging about .NET, ASP.NET, AJAX, Silverlight&lt;/Description&gt;
&lt;Image height="16" width="16" type="image/x-icon"&gt;{{BASE_PATH}}/favicon.ico&lt;/Image&gt;
&lt;Url type="text/html" method="get" template="{{BASE_PATH}}/?s={searchTerms}"/&gt;
&lt;/OpenSearchDescription&gt;
</pre>
</div>








<p>The most important tag is the &quot;<strong>Url</strong>&quot;-Tag with the &quot;searchTerm&quot; template to create later such an URL: <a title="{{BASE_PATH}}/?s=AJAX" href="{{BASE_PATH}}/?s=AJAX">{{BASE_PATH}}/?s=AJAX</a>&#160;</p>

<p><strong><u>Add the search provider to you browser</u></strong></p>

<ul>
  <li>You could use Javascript: </li>
</ul>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:78f9690a-8dcd-4939-808c-f556a70e9afb" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
<pre name="code" class="c#">&lt;a href="#" onclick='window.external.AddSearchProvider("{{BASE_PATH}}/browserplugin.xml");'&gt;Code-Inside International Blog&lt;/a&gt;  
</pre>
</div>








<p>The javascript &quot;AddSearchProvider&quot; method invoke the browser to promt such an interface: </p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image5.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="185" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb5.png" width="291" border="0" /></a> </p>

<ul>
  <li>The browser get noticed about the &quot;search plugin&quot;&#160; </li>
</ul>

<p>You can tell the clients browser that you offer an search plugin - just add this in the head section of your site:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b0002f1c-2755-4d8e-825f-1c304fb859a0" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
<pre name="code" class="c#">&lt;link rel="search" type="application/opensearchdescription+xml" href="{{BASE_PATH}}/browserplugin.xml" title="Code-Inside International Blog" /&gt;

</pre>
</div>


<p>You reference your XML file and (for example) the firefox &quot;search provider icon&quot; show us a glow effect:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image6.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="44" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb6.png" width="61" border="0" /></a> </p>

<p>One click - and you be done:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image7.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb7.png" width="238" border="0" /></a> </p>

<p>The same process with the Internet Explorer 7:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image8.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="111" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb8.png" width="244" border="0" /></a> </p>

<p><strong>Simple &amp; very usefull for each &quot;search&quot; site :)</strong></p>
