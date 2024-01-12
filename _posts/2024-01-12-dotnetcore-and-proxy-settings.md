---
layout: post
title: ".NET ('.NET Core') and Proxy Settings"
description: "How to set proxy settings 'global'..."
date: 2024-01-12 22:55
author: Robert Muehsig
tags: [.NET, Proxy]
language: en
---

{% include JB/setup %}

If your .NET (".NET Core") program is running on a system that specifies strict proxy settings, you must either handle these settings in your application itself or use these environment variables.

Since I had this problem from time to time and the procedure was not 100% clear to me, I am now recording it here on the blog.

__"DefaultProxy"__

If you don't specify any proxy, then the `DefaultProxy` is used and depending on your operation system the following will be used:

(Copied from [here](https://learn.microsoft.com/en-us/dotnet/api/system.net.http.httpclient.defaultproxy?view=net-8.0))

> For Windows: Reads proxy configuration from environment variables or, if those are not defined, from the user's proxy settings.
>
> For macOS: Reads proxy configuration from environment variables or, if those are not defined, from the system's proxy settings.
> 
> For Linux: Reads proxy configuration from environment variables or, in case those are not defined, this property initializes a non-configured instance that bypasses all addresses.
> The environment variables used for DefaultProxy initialization on Windows and Unix-based platforms are:
> 
> HTTP_PROXY: the proxy server used on HTTP requests.
> HTTPS_PROXY: the proxy server used on HTTPS requests.
> ALL_PROXY: the proxy server used on HTTP and/or HTTPS requests in case HTTP_PROXY and/or HTTPS_PROXY are not defined.
> NO_PROXY: a comma-separated list of hostnames that should be excluded from proxying. Asterisks are not supported for wildcards; use a leading dot in case you want to match a subdomain. Examples: > NO_PROXY=.example.com (with leading dot) will match www.example.com, but will not match example.com. NO_PROXY=example.com (without leading dot) will not match www.example.com. This behavior might be > revisited in the future to match other ecosystems better.

__Scenario: Web-App that needs external & "internal" Web-APIs__

We often had the following problem: 
Our web application needs to contact external services. This means, that we __must use__ the proxy.
At the same time, our web application also wants to communicate with other web APIs on the same machine, but the proxy does not allow this (the proxy can't return the request to the same machine - not sure why).

It should be noted that the "IIS account" or "Network Service" did NOT have a proxy setting itself, i.e. the "User Proxy Settings" were always empty.

__Solution:__

We used the following proxy settings and it worked:

```
ALL_PROXY = proxyserver.corp.acme.com
NO_Proxy = internalserver.corp.acme.com
```

Our web application and our internal web api were running on "internalserver.corp.acme.com". Each request to external services were routed through the proxy and each "internal" request didn't touch the proxy. 

__IE-Proxy Settings:__

This solution should work fine on "Server-Environments". If you have a desktop application, then the "Default Proxy" handling should do the trick. In some special cases the "IE proxy setting" handling might be needed. If you want to learn more about this, read this blogpost: [How to use IE proxy settings with HttpClient](https://blog.codeinside.eu/2022/03/28/how-to-use-ie-proxy-settings-with-httpclient/).

Hope this helps!