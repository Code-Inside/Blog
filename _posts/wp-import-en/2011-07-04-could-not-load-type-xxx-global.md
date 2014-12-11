---
layout: post
title: "“Could not load type ‚XXX.Global‘.”"
date: 2011-07-04 11:55
author: CI Team
comments: true
categories: [Fix]
tags: []
language: en
---
{% include JB/setup %}
<p>&#160;</p>  <p><b></b></p>  <p>These Blogpost belongs to the set “strange error messages and for hours of googling doesn’t help”. My associate Daniel Kubis received the following error message while he tried to start a ASP.NET application:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4aa5f320-a843-410d-853a-9cb5509d2b41" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Parser Error Message: Could not load type 'ApplicationName.Global'.

Source Error: Line 1: &lt;%@ Application Codebehind="Global.asax.cs" Inherits="ApplicationName.Global" %&gt; Source File: Path of Application \global.asax Line: 1</pre></div>

<p><a href="http://stackoverflow.com/questions/54001/could-not-load-type-xxx-global">This error</a> is quite usual and there are a lot of reasons how this could happen. In the case of my associate was the answer to this problem the following:</p>

<p>The Web.config from “C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config” was lost. Little background Information about the folder “C:\Windows\Microsoft.NET\Framework64\FRAMEWORK_VERSION\Config” In this folder we collected a lot of different “machine far” configurations and already the smallest manipulation of the files could create the strangest errors. It should be possible to copy the file from another computer without any problems otherwise you need to reactivate the .NET Framework Setup. </p>
