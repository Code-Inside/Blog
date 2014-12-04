---
layout: post
title: "OWIN – what is it about and why is it so cool?"
date: 2012-06-12 10:14
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

<a href="http://owin.org/#projects">OWIN</a> stands for “Open Web Interface for .NET” and it is a specification for the communication between .NET Web Server and Web applications.

<strong>.NET Web Server – did you mean the IIS?</strong>

<strong> </strong>

A highlight at first: there are several other .NET Web Server. Of course IIS is the one we usual use but at the same time it is a very “tough” application.

<strong>OWIN – Big Picture</strong>

<strong> </strong>

<a href="http://whereslou.com/">Louis DeJardin</a>, a Microsoft employee in the ASP.NET team created this little picture to show the connection between OWIN and his <a href="https://github.com/owin/owin-sandbox/">OWIN-sandbox project</a>. There is also a fantastic <a href="http://whereslou.com/2012/05/14/owin-compile-once-and-run-on-any-server/">blogpost</a> which I’m going to repeat in parts.

&nbsp;

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb726.png" border="0" alt="image" width="426" height="497" />

<strong>Let’s take a deeper look to the several parts:</strong>

Katana.exe is a kind of “sandbox” for the whole Webstack.

First blue box with “server.dll”, “Kayak”, “HttpListener”: These are the different “Web Server”. The server.dll represents what we already know from IIS. The HttpListener is also an operation system / Framework components and was often used in the WCF and WebApi world before. <a href="http://kayakhttp.com/">Kayak</a> instead is a .NET Web Server <a href="https://github.com/kayak/kayak">written in C#</a> (!).

The orange line: That’s what OWIN describes. What follows is the “Middleware” later in the Code you are going to find it in the Namespace “Gate”.

At the end of the pipeline there are some Web Frameworks for example <a href="http://nancyfx.org/">NancyFx</a> or the WebApi. Also SignalR is “OWIN” compatible.

<strong>OWIN Sandbox Project</strong>

<strong> </strong>

As far as I can tell from my researches this project is the easiest way to enter the OWIN universe.

<a href="http://code-inside.de/blog-in/wp-content/uploads/image1566.png"><img style="background-image: none; margin: 0px 20px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; padding-top: 0px; border: 0px;" title="image1566" src="http://code-inside.de/blog-in/wp-content/uploads/image1566_thumb.png" border="0" alt="image1566" width="131" height="355" align="left" /></a>The download includes a solution with several Web-projects and different ways to use OWIN.

If you start the projects from the Visual Studio there aren’t any big surprises waiting for you.

<strong> </strong>

<strong> </strong>

<strong> </strong>

<strong> </strong>

<strong> </strong>

<strong> </strong>

<strong> </strong>

<strong>Now Katana enters the game:</strong>

After you’ve downloaded <a href="https://github.com/Katana/katana#readme">Katana</a> (maybe from <a href="http://code-inside.de/blog/2012/05/15/chocolateyapt-get-fr-windows/">Chocolatey</a>) the magic begins:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9d1e23d9-a489-4923-89ce-59351427323a" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">cinst katana
git clone https://github.com/owin/owin-sandbox.git
cd owin-sandbox\src\Case05_JustNancy
msbuild
katana --server kayak</pre>
</div>
(The MSBuild order only works when you register the program in the Powershell or when it comes from the VS Shell).

With the following order we allow Katana to create a Kayak Server – and voila:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb730.png" border="0" alt="image" width="588" height="69" />

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb729.png" border="0" alt="image" width="244" height="71" />

Without the use of IIS Express, Cassini or HttpListener we are able to use NancyFx!

Hint: Visual Studio instances need to be closed – otherwise there seem to be some conflicts with the connection to Socket.

<strong>Freedom offers creativity</strong>

Actually I don’t know where I can use this at the moment but other frameworks already work with it – especially in the ruby world and inspired several Web frameworks. The freedom is able to inspire some fresh and interesting constellations and is also followed by the Microsoft ASP.NET team. Cool isn’t it? ;-)

<strong>Additional Links</strong>

Of course Hanselman <a href="http://www.hanselman.com/blog/HanselminutesPodcast244KayakOWINOpenSourceWebServersAndMoreWithBenjaminVanDerVeen.aspx">already blogged</a> about it and recorded a Podcast with the creator of Kayak.

You will find an <a href="https://github.com/owin/owin/wiki">OWIN wiki</a> on GitHub with some more information’s and outlooks.
