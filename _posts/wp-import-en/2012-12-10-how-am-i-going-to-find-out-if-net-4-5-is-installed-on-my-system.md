---
layout: post
title: "How am I going to find out if .NET 4.5 is installed on my system?"
date: 2012-12-10 18:06
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

It seems to be an easy question but there are also some traps. The reason is that theoretically it is possible to make a difference between CLR Version and Framework Version. In the times of .NET 3.5 it was usual to keep the CLR version still on version 2.0 because there are only new libraries added to the framework.

But “.NET Framework 4.5” usually means the combination of the “newest” frameworks and CLR Version. Although .NET 4.5 is an “in-place-upgrade” for .NET 4.0 what makes the whole situation even more complicated.

Good entrance (and I’m going to talk about this later again) is the post of Scott Hanselman:

<a href="http://www.hanselman.com/blog/NETVersioningAndMultiTargetingNET45IsAnInplaceUpgradeToNET40.aspx">.NET Versioning and Multi-Targeting - .NET 4.5 is an in-place upgrade to .NET 4.0</a>

<strong>Easy check for: Is the .NET Framework Version 4.5 installed or not? </strong>

<strong> </strong>

To clarify what version you’ve got installed you will find an helpful hint from the registry at the pad “Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full”

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb819.png" border="0" alt="image" width="542" height="219" />

In my cases it is: Jepp - .NET 4.5. Unfortunately this test will only work if you are the system-admin and in full control of the system and the applications.

<strong>Does my application run with .NET 4.5?</strong>

This doesn’t mean if the application is “compatible” to .NET 4.5 but if the application is able to use the .NET 4.5 features.

It’s kind of difficult to answer this question since this depends on the app.config or the web.config and if the IIS is in the game you have to configure the AppPool properly.

<em>If you read the <a href="http://www.hanselman.com/blog/NETVersioningAndMultiTargetingNET45IsAnInplaceUpgradeToNET40.aspx">Hanselman Post</a> you are now going to get a very short version of it <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile47.png" alt="Zwinkerndes Smiley" /></em>

<em> </em>

If you run a Desktop Application without the correct framework version in the <a href="http://msdn.microsoft.com/en-us/library/w4atty68.aspx">supportedRuntime Element</a> of the app.config you are going to receive an error message. That’s how I tell my Runtime that my app needs .NET 4.5:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:22338c3f-edfb-4ca9-b694-8f81b5044338" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">&lt;?xml version="1.0" encoding="utf-8" ?&gt;
&lt;configuration&gt;
    &lt;startup&gt;
        &lt;supportedRuntime version="v4.0" sku=".NETFramework,Version=v4.5" /&gt;
    &lt;/startup&gt;
&lt;/configuration&gt;</pre>
</div>
When there is no .NET 4.5 that’s your error message:

<a href="{{BASE_PATH}}/assets/wp-images-en/image1662.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1662" src="{{BASE_PATH}}/assets/wp-images-en/image1662_thumb.png" border="0" alt="image1662" width="523" height="266" /></a>

There is a similar element for Web-Application in the web.config:

If the Runtime the TargetFramework needs isn’t there you will see another error message if you try to run the Webapp.

<strong>Bets Practice: Feature Detection during the runtime</strong>

<strong>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4dd8ea3e-3204-4b7f-9fc6-953b2c07afcd" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">&lt;configuration&gt;
    &lt;system.web&gt;
        &lt;compilation debug="true" strict="false" explicit="true" targetFramework="4.5" /&gt;
    &lt;/system.web&gt;
&lt;/configuration&gt;</pre>
</div>
</strong>

<strong> </strong>

<strong> </strong>

Since the framework always includes several libraries and every library has a different version number and a different Runtime you might test properly if there is something like a special class for example.
