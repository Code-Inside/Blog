---
layout: post
title: "HowTo: Setup IIS7 as development server in Visual Studio 2008"
date: 2009-03-23 23:39
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, HowTo, IIS7, Vista]
language: en
---
{% include JB/setup %}
<p><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="117" alt="image_thumb3" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb3-thumb2.png" width="161" align="left" border="0" />Webdevelopment with Visual Studio is really easy - just hit F5 and you jump into the debugger. VS use (as default) the built-in &quot;<a href="http://msdn.microsoft.com/de-de/library/58wxa9w5(VS.80).aspx">ASP.NET Development Server&quot; called &quot;Cassini&quot;</a>. But there are some pitfalls if you use this server, because the behavior of the IIS and Cassini are sometimes a bit <strong>different</strong> and the dev server is much <strong>slower</strong>! The good news: With few clicks you can debug and deploy your application right on IIS7 (on Vista/Server 2008).</p> 


  <p><strong>Setup IIS      <br /></strong>If you develop under Windows Vista (I have only a german Vista here - sorry)you can use the IIS7 - Win XP users have to use IIS6 (which I will not cover in this blogpost, but the way should be similar).</p>
<p><strong>1. Install IIS 7      <br /></strong>System Control -&gt; Programs -&gt; Windows Functions:</p>
<p>If you have not installed IIS7 click on the IIS-service checkbox:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb610.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="255" alt="image_thumb6" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb6-thumb2.png" width="290" border="0" /></a> </p>
<p>Important for us are the following settings: Add the ASP.NET Feature:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb94.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="219" alt="image_thumb9" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb9-thumb3.png" width="292" border="0" /></a> </p>
<p>... and for the Visual Studio &quot;integration&quot; you have to install these features:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb133.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="276" alt="image_thumb13" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb13-thumb2.png" width="369" border="0" /></a>&#160;</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb151.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="285" alt="image_thumb15" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb15-thumb.png" width="336" border="0" /></a> </p>
<p><strong>2. Edit Visual Studio Project</strong></p>
<p>*right click* on the project and go to the properties:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb171.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="266" alt="image_thumb17" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb17-thumb.png" width="474" border="0" /></a> </p>
<p>Save these settings and now hit F5 - done :)</p>
<p><strong>Pros- &amp; Cons about using IIS instead of Cassini      <br /></strong>I recommand using IIS instead of Cassini, because it&#180;s much faster and it&#180;s more like the real deployment server. Look at these two questions on stackoverflow.com to see what other developers think about it: <a href="http://stackoverflow.com/questions/281667/asp-net-development-server-or-localhost-iis">this link</a> or <a href="http://stackoverflow.com/questions/103785/what-are-the-disadvantages-of-using-cassini-instead-of-iis">this link</a>.</p>
