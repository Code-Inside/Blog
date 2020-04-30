---
layout: post
title: "Blazor for Office Add-ins: First look"
description: "TL;DR: Severside Blazor might work, WebAssembly unfortunately no"
date: 2020-04-30 21:30
author: Robert Muehsig
tags: [Office Addin, Blazor, WebAssembly, .NET]
language: en
---

{% include JB/setup %}

Last week I did some research and tried to build a pretty basic Office Addin (within the "new" [web based Addin model](https://docs.microsoft.com/en-us/office/dev/add-ins/overview/office-add-ins)) with __[Blazor](https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor)__.

Side note: Last year I blogged about how to build [Office Add-ins with ASP.NET Core](https://blog.codeinside.eu/2019/01/31/office-addins-with-aspnet-core/).

# Why Blazor?

My daily work home is in the C# and .NET land, so it would be great to use Blazor for Office Addins, right? 
A Office Add-in is just a web application with a "communication tunnel" to the hosting Office application - not very different from the real web.

# What (might) work: Serverside Blazor

My first try was with a "standard" serverside Blazor application and I just pointed the dummy Office Add-in manifest file to the site and it (obviously) worked:

<blockquote class="twitter-tweet"><p lang="et" dir="ltr">Mhh... maybe?🤔😏<a href="https://twitter.com/hashtag/Blazor?src=hash&amp;ref_src=twsrc%5Etfw">#Blazor</a> <a href="https://twitter.com/hashtag/OfficeDev?src=hash&amp;ref_src=twsrc%5Etfw">#OfficeDev</a> <a href="https://t.co/BzdVQzIeqA">pic.twitter.com/BzdVQzIeqA</a></p>&mdash; Robert Muehsig (@robert0muehsig) <a href="https://twitter.com/robert0muehsig/status/1253351161236787202?ref_src=twsrc%5Etfw">April 23, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

I assume that serverside Blazor is for the client not very "complicated" and it would probably work.

After my initial tweet __[Manuel Sidler](https://twitter.com/manuelsidler)__ jumped in and made a simple demo project, which also invokes the __Office.js__ APIs from C#!

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Building an <a href="https://twitter.com/hashtag/Office?src=hash&amp;ref_src=twsrc%5Etfw">#Office</a> Add-In based on <a href="https://twitter.com/hashtag/Blazor?src=hash&amp;ref_src=twsrc%5Etfw">#Blazor</a> (Server) could be possible. Whether it&#39;s a good idea or not is another story ;) <a href="https://t.co/LdSPYl4SRh">https://t.co/LdSPYl4SRh</a> (thanks <a href="https://twitter.com/robert0muehsig?ref_src=twsrc%5Etfw">@robert0muehsig</a> to get me jump up on this idea) <a href="https://t.co/1w29212qdS">pic.twitter.com/1w29212qdS</a></p>&mdash; Manuel Sidler (@manuelsidler) <a href="https://twitter.com/manuelsidler/status/1253668691956445184?ref_src=twsrc%5Etfw">April 24, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Checkout his __[repository on GitHub](https://github.com/manuelsidler/blazor-office-addin)__ for further information.

# What won't work: WebAssembly (if I don't miss anything)

Serverside Blazor is cool, but has some problems (e.g. a server connection is needed and scaling is not that easy) - what about __WebAssembly__?

Well... Blazor WebAssembly is still in preview and I tried the same setup that worked for serverside blazor. 

__Result:__

The desktop PowerPoint (I tried to build a PowerPoint addin) keeps crashing after I add the addin. On Office Online it seems to work, but not for a very long time:

<blockquote class="twitter-tweet" data-conversation="none"><p lang="en" dir="ltr">Blazor WebAssembly seems not to work or at least the startup is super weird :-/ <a href="https://t.co/IvnecQFMj2">pic.twitter.com/IvnecQFMj2</a></p>&mdash; Robert Muehsig (@robert0muehsig) <a href="https://twitter.com/robert0muehsig/status/1254726027684777986?ref_src=twsrc%5Etfw">April 27, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

__Possible reasons:__

The default Blazor WebAssembly installs a service worker. I removed that part, but I'm not 100% sure if I did it correctly. At least they are currently not supported from the [Office Add-in Edge WebView](https://docs.microsoft.com/en-us/office/dev/add-ins/concepts/browsers-used-by-office-web-add-ins#service-workers-are-not-working). My experience with Office Online and the Blazor addin failed as well and I don't think that service workers are the problem.

I'm not really sure why its not working, but its quite early for Blazor WebAssembly, so... time will tell.

# What does the Office Dev Team think of Blazor?

Currently I just found one comment on [this blogpost](https://developer.microsoft.com/en-us/office/blogs/office-add-ins-community-call-november-13-2019/) regarding Blazor:

    Will Blazor be supported for Office Add-ins?

    No, it will be a React Office.js add-in. We don’t have any plans to support Blazor yet. For that, please put a note on our UserVoice channel: https://officespdev.uservoice.com. There are several UserVoice items already on this, so know that we are listening to your feedback and prioritizing based on customer requests. The more requests we get for particular features, the more we will consider moving forward with developing it. 

Well... vote for it! ;)
