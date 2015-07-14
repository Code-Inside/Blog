---
layout: post
title: "Using PCLs in ASP.NET"
description: "... or how to fix 'The type System.Object is defined in an assembly that is not reference'."
date: 2015-07-14 20:00
author: robert.muehsig
tags: [PCL, ASP.NET]
language: en
---
{% include JB/setup %}

## Weird Error Message:

    Compilation Error

    Description: An error occurred during the compilation of a resource required to service this request. Please review the following specific error details and modify your source code appropriately.

    Compiler Error Message: CS0012: The type ‘System.Object’ is defined in an assembly that is not referenced. You must add a reference to assembly ‘System.Runtime, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a’.

## Fix:

Put this Assembly-Reference in the web.config:

    <compilation debug="true" targetFramework="4.5">
        <assemblies>
            <add assembly="System.Runtime, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
        </assemblies>
    </compilation>

## Reason:

This error occures when you are using Portable Class Libraries (PCLs) inside ASP.NET Projects. __[This Blogpost](http://www.lyalin.com/2014/04/25/the-type-system-object-is-defined-in-an-assembly-that-is-not-reference-mvc-pcl-issue/)__ provides a pretty good answer. In short: It's an issue between runtime and build time - PCLs that are used in Razor are runtime stuff.

I (re-)blogged this because I had this issue more than once ;)

Hope this helps!
