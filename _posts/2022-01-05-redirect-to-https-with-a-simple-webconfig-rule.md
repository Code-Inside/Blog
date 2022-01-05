---
layout: post
title: "Redirect to HTTPS with a simple web.config rule"
description: "A simple solution to a common problem..."
date: 2022-01-05 23:45
author: Robert Muehsig
tags: [IIS, web.config]
language: en
---

{% include JB/setup %}

The scenario is easy: My website is hosted in an IIS and would like to redirect all incomming HTTP traffic to the HTTPS counterpart. 

This is your solution - a "simple" rule:

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <system.webServer>
        <rewrite>
            <rules>
                <rule name="Redirect to https" stopProcessing="true">
                    <match url=".*" />
                    <conditions logicalGrouping="MatchAny">
                        <add input="{HTTPS}" pattern="off" />
                    </conditions>
                    <action type="Redirect" url="https://{HTTP_HOST}{REQUEST_URI}" redirectType="Found" />
                </rule>
            </rules>
        </rewrite>
    </system.webServer>
</configuration>
```

We used this in the past to setup a "catch all" web site in an IIS that redirects all incomming HTTP traffic.
The actual web applications had only the HTTPS binding in place.

Hope this helps!