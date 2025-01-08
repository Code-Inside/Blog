---
layout: post
title: "WinINet, WinHTTP and the HttpClient from .NET"
description: "What is WinINet, WinHTTP and how is it related to the HttpClient from .NET?"
date: 2025-01-09 00:30
author: Robert Muehsig
tags: [Windows, HttpClient, WinINet, WinHTTP]
language: en
---

{% include JB/setup %}

*This is more of a "Today-I-Learned" post and not a "full-blown How-To article." If something is completely wrong, please let me know - thanks!* 

A customer inquiry brought the topic of "[WinINet](https://learn.microsoft.com/en-us/windows/win32/wininet/about-wininet)" and "[WinHTTP](https://learn.microsoft.com/en-us/windows/win32/winhttp/winhttp-start-page)" to my attention. This blog post is about finding out what this is all about and how and whether or not these components are related to the HttpClient of the .NET Framework or .NET Core.

# General

Both WinINet and WinHTTP are APIs for communication via the HTTP/HTTPS protocol and Windows components. A detailed comparison page can be found [here](https://learn.microsoft.com/en-us/windows/win32/wininet/wininet-vs-winhttp).

# WinINet

WinINet is intended in particular for client applications (such as a browser or other applications that communicate via HTTP). 
In addition to pure HTTP communication, WinINet also has configuration options for proxies, cookie and cache management. 

However, WinINet is not intended for building server-side applications or very scalable applications.

# WinHTTP 

WinHTTP is responsible for the last use case, which even runs a “kernel module” and is therefore much more performant. 

# .NET HttpClient 

At first glance, it sounds as if the HttpClient should access WinINet from the .NET Framework or .NET Core (or .NET 5, 6, 7, ...) - but this is __not__ the case. 

__Instead:__

The .NET Framework relies on __WinHTTP__. Until .NET Core 2.1, the substructure was also based on __WinHTTP__.

Since .NET Core 2.1, however, a platform-independent "[SocketsHttpHandler](https://learn.microsoft.com/en-us/dotnet/api/system.net.http.socketshttphandler)" works under the HttpClient by default.
However, the HttpClient can partially read the __Proxy settings from the WinINet__ world.

The "[WinHttpHandler](https://learn.microsoft.com/en-us/dotnet/api/system.net.http.winhttphandler)" is still available as an option, although the use case for this is unknown to me.

During my research, I noticed this [GitHub issue](https://github.com/dotnet/runtime/issues/1384). This issue is about the new SocketsHttpHandler implementation not being able to access the same WinINet features for cache management. The topic is rather theoretical and the issue is already several years old.

# Summary

What have we learned now? Microsoft has implemented several Http stacks and in "modern" .NET the HttpClient uses its own handler.

Hope this helps!
