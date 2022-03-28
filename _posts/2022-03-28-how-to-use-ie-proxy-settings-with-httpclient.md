---
layout: post
title: "How to use IE proxy settings with HttpClient"
description: "How to use IE proxy (e.g. PAC) settings with .NET"
date: 2022-03-28 23:45
author: Robert Muehsig
tags: [IE, proxy, HttpClient]
language: en
---

{% include JB/setup %}

Internet Explorer is - mostly - dead, but some weird settings are still around and "attached" to the old world, at least on Windows 10. 
If your system administrator uses some advanced proxy settings (e.g. a [PAC-file](https://developer.mozilla.org/en-US/docs/Web/HTTP/Proxy_servers_and_tunneling/Proxy_Auto-Configuration_PAC_file)), those will be attached to the users IE setting. 

If you want to use this with a HttpClient you need to code something like this:


```
    string target = "https://my-target.local";
    var targetUri = new Uri(target);
    var proxyAddressForThisUri = WebRequest.GetSystemWebProxy().GetProxy(targetUri);
    if (proxyAddressForThisUri == targetUri)
    {
        // no proxy needed in this case
        _httpClient = new HttpClient();
    }
    else
    {
        // proxy needed
        _httpClient = new HttpClient(new HttpClientHandler() { Proxy = new WebProxy(proxyAddressForThisUri) { UseDefaultCredentials = true } });
    }
```

The [GetSystemWebProxy()](https://docs.microsoft.com/de-de/dotnet/api/system.net.webrequest.getsystemwebproxy?view=net-6.0) gives access to the system proxy settings from the current user. Then we can query, what proxy is needed for the target. If the result is the same address as the target, then no proxy is needed. Otherwise, we inject a new WebProxy for this address.

Hope this helps!

__Be aware:__ Creating new HttpClients is (at least in a server environment) not recommended. Try to reuse the same HttpClient instance!

Also note: The proxy setting in Windows 11 are now built into the system settings, but the API still works :)

![x]({{BASE_PATH}}/assets/md-images/2022-03-28/windows11.png "Windows 11")
