---
layout: post
title: "ByeBye .NET Client Profile with .NET 4.5"
date: 2013-01-26 21:42
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

With .NET 3.5 they’ve published two new deployment-methods for the framework:

- Full Framework

- Client Profile

<span style="text-decoration: underline;">Shortcut:</span> With .NET 4.5 the construct that caused us all a lot of headache is gone.

<strong>Why all this? </strong>

<strong> </strong>

The initial idea was to create a totally new and slim Framework. Other ideas might be about the security because why should a client pc provide components for server applications?

<strong>The problem</strong>

<strong> </strong>

As a web- or “server” developer you are usually never get in touch with the .NET client profile. It will be a problem if you try to take some components from a “client profile” application which might have some kind of reference on the whole big framework.

You will find a nice overview about the subject on the <a href="http://stackoverflow.com/questions/2759228/difference-between-net-4-client-profile-and-full-framework-download">Stackoverflow</a> answers.

<strong>Example: </strong>

.NET 4 client profile application:

<img title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb860.png" border="0" alt="image" width="559" height="205" />

As far as I remember Visual Studio 2010 doesn’t act as clever (what lead to <a href="http://rantdriven.com/post/2011/01/07/NET-Framework-4-Client-Profile-The-Devil-Itself!.aspx">this errors</a>) as Visual Studio 2012 and didn’t show this hint:

<img title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb861.png" border="0" alt="image" width="482" height="129" />

<strong>With .NET 4.5 there isn’t a client profile</strong>

<strong> </strong>

<em>“Starting with the .NET Framework 4.5, the Client Profile has been discontinued and only the full redistributable package is available. Optimizations provided by the .NET Framework 4.5, such as smaller download size and faster deployment, have eliminated the need for a separate deployment package. The single redistributable streamlines the installation process and simplifies your app’s deployment options.”</em>

<em> </em>

<em><a href="http://msdn.microsoft.com/en-us/library/cc656912.aspx">Source: MSDN</a></em>

<em> </em>

<strong>Result</strong>

<a href="http://code-inside.de/blog-in/wp-content/uploads/image1704.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1704" src="http://code-inside.de/blog-in/wp-content/uploads/image1704_thumb.png" border="0" alt="image1704" width="478" height="249" /></a>
