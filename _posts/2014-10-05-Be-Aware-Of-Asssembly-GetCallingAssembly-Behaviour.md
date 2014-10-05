---
layout: post
title: "Be aware of Assembly.GetCallingAssembly() Behaviour"
description: "Assembly.GetCallingAssembly() can be dangerous, so be aware if you use it."
date: 2014-10-05 13:25
author: robert.muehsig
tags: [Reflection, Assembly, .NET]
---
{% include JB/setup %}

Last week I worked on an old ASP.NET WebApp. The WebApp uses normal Resource Files for localization and it worked well in our Development-Environment. We could switch between Debug and Release Mode with IIS Express and the application picked the correct resources.

## Problem: On IIS with Release no resources were found
I deployed the WebApp to our Staging-Environment and all Localized Texts were not loaded. I redeployed it with Debug and now everything was fine. 

## Problem Source: Assembly.GetCallingAssembly()
It took me a while and I needed to pull out some decade old code to see how the localization was done in this project. Root problem was this line: [__"Assembly.GetCallingAssembly"__](http://msdn.microsoft.com/en-us/library/system.reflection.assembly.getcallingassembly(v=vs.110).aspx). This code line was hidden in a "base-framework" (with controls and stuff). 
The idea was that the base framework would load the "calling" assembly and use this as the localization source for the [ResourceManager](http://msdn.microsoft.com/en-us/library/system.resources.resourcemanager(v=vs.110).aspx). 

## Why did it break only on IIS with Release mode?
From [Assembly.GetCallingAssembly-MSDN](http://msdn.microsoft.com/en-us/library/system.reflection.assembly.getcallingassembly(v=vs.110).aspx):

> If the method that calls the GetCallingAssembly method is expanded inline by the just-in-time (JIT) compiler, or if its caller is expanded inline, the assembly that is returned by GetCallingAssembly may differ unexpectedly.

In IIS Express and IIS with Debug mode everything worked as expected, but on IIS with Release "Assembly.GetCallingAssembly" returned the System.Web.dll instead of our own assemblies with the correct localizations.

## TL;DR
Don't use Assembly.GetCallingAssembly for such scenarios. Thanks to [this blogpost](http://blog.idm.fr/2011/09/why-getcallingassembly-is-dangerous.html) I fixed the bug.