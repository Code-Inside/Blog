---
layout: post
title: "WPF, Chrome Embedded and WebApi Selfhosted"
description: "... or how to ditch XAML and use Web-Technology for a desktop app."
date: 2015-09-23 23:30
author: robert.muehsig
tags: [WPF, CEF, WebAPI]
language: en
---
{% include JB/setup %}

Building "rich desktop clients" is not a very easy task. WPF can be a good choice, but if you have zero knowledge in XAML you might end up in hell. If you are more a "web guy" or just want to reuse existing code from your Web-App and want to stick to your .NET know-how this blogpost might come handy.

## The idea

The idea is clever and kinda stupid together: We want to build a small app that embeds a browser __and__ a server. The host should be a WPF application, because with this we could combine interesting frameworks in one application.

## Building blocks: The Browser

If you just want to display "Web-Content" you can just use the __[WebBrowser-Control](https://msdn.microsoft.com/en-us/library/system.windows.controls.webbrowser(v=vs.110).aspx)__. The most common and annoying problem is that the default rendering engine is stuck in the stone age: Internet Explorer 7. Even on Windows 10 the default rendering engine will be set to IE7.
To fix this you can use some [Registry-Magic](https://weblog.west-wind.com/posts/2011/May/21/Web-Browser-Control-Specifying-the-IE-Version), but this is not very elegant.

Another solution would be to take a deeper look at the [Chromium Embedded Framework for .NET](https://github.com/cefsharp/CefSharp). It is the rendering engine of Chrome - which gives you a super powerful platform. The only downside: You need to [compile your app for x86 or x64](https://github.com/cefsharp/CefSharp/issues/576#issuecomment-61926661).

