---
layout: post
title: "TLS/SSL problem: 'Could not create SSLTLS secure channel'"
description: "TL;DR: Update your machine..."
date: 2020-02-29 23:59
author: Robert Muehsig
tags: [TLS, SSL, HTTPS]
language: en
---

{% include JB/setup %}

# Problem

Last week I had some fun debugging a weird bug. Within our application one module makes HTTP requests to a 3rd party service and depending on the running Windows version this call worked or failed with:

    'Could not create SSLTLS secure channel'

I knew that older TLS/SSL versions are deprecated and that many services refuse those protocols, but we still didn't finally understand the issue:

* The HTTPS call worked without any issues on a Windows 10 1903 machine
* The HTTPS call didn't work on a Windows 7 SP1 (yeah... customers...) and a Windows 10 1803 machine.

Our software uses the .NET Framework 4.7.2 and therefore I thought [that this should be enough](https://docs.microsoft.com/en-us/dotnet/framework/network-programming/tls).

# Root cause

Both systems (or at least they represents two different customer enviroments) didn't enable TLS 1.2.

On Windows 7 (and I think on the older Windows 10 releases) there are multiple ways. On way is to set a [registry key to enable the newer protocols](https://support.microsoft.com/en-us/help/3140245/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-wi#easy). 

Our setup was a bit more complex than this and I needed like a day to figure everything out. A big mystery was, that some services were accessible even under the old systems till I figured out, that some sites even support a pure HTTP connection without any TLS.

Well... to summarize it: Keep your systems up to date. If you have any issues with TLS/SSL make sure your system does support it. 

Hope this helps!
