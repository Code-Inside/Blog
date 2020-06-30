---
layout: post
title: "Can a .NET Core 3.0 compiled app run with a .NET Core 3.1 runtime?"
description: "A short lesson in the version selection of .NET Core"
date: 2020-06-30 23:30
author: Robert Muehsig
tags: [.NET Core]
language: en
---

{% include JB/setup %}

Within [our product](https://oneoffixx.com) we move more and more stuff in the .NET Core land.
Last week we had a disussion around needed software requirements and in the __.NET Framework__ land this question was always easy to answer:

> .NET Framework 4.5 or higher.

With __.NET Core__ the answer is sligthly different:

In _theory_ major versions are compatible, e.g. if you compiled your app with .NET Core 3.0 and a .NET Core runtime 3.1 is the only installed 3.X runtime on the machine, this runtime is used. 

This system is called ["Framework-dependent apps roll forward"](https://docs.microsoft.com/en-us/dotnet/core/versions/selection#framework-dependent-apps-roll-forward) and sounds good. 

# The bad part

Unfortunately this didn't work for us. Not sure why, but our app refuses to work because a .dll is not found or missing. The reason is currently not clear. Be aware that Microsoft has written a hint that such things might occure:

> It's possible that 3.0.5 and 3.1.0 behave differently, particularly for scenarios like serializing binary data.

# The good part

With .NET Core we could ship the framework with our app and it should run fine wherever we deploy it. 

# Summery

Read the docs about the "app roll forward" approach if you have similar concerns, but test your app with that combination. 

As a sidenote: 3.0 is not supported anymore, so it would be good to upgrade it to 3.1 anyway, but we might see a similar pattern with the next .NET Core versions.

Hope this helps!