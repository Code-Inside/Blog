---
layout: post
title: "dnSpy - a OSS IL decompiler and debugger"
description: "If you ever needed a small tool to debug your .NET application, but don't want to pollute the system with a full blown VS and don't want to fight against VS remote debugging? Maybe take a look at dnSpy."
date: 2017-09-30 23:15
author: Robert Muehsig
tags: [dnSpy, IL, Debugger, Decompiler]
language: en
---
{% include JB/setup %}

My colleague was fighting against a nasty bug, that only occures on one machine. Unfortunatly this machine was not a development machine (no VS installed) and we didn't want to mess with VS remote debugging, because (AFAIK) his would need some additional setup but we were not allowed to install anything.

Soooo... he searched around and found this:

## dnSpy - a .NET assembly editor, decompiler, and debugger

The title contains the major points. It is a decompiler, like IL Spy, but addionaly it has a super nice debugger and it looks like a small Visual Studio.

Some pictures how I just decompile Paint.NET and attach the debugger:

![x]({{BASE_PATH}}/assets/md-images/2017-09-30/dnspy.png "dnSpy without debugging")

![x]({{BASE_PATH}}/assets/md-images/2017-09-30/dnspy_start_debug.png "Start debugging")

![x]({{BASE_PATH}}/assets/md-images/2017-09-30/dnspy_debugging.png "Debugging")

I think this is just awesome and it helped my colleague alot. 

## OSS & Free

The complete project is hosted __[on GitHub](https://github.com/0xd4d/dnSpy)__ and is __"Open Source (GPLv3) and Free Forever"__

Checkout the GitHub project page - it contains a lot more information. The tool itself was just 18mb zipped and can be run everywhere. 

## Its a decompiler!

And just to make sure you keep this in mind: The debugging works with every .NET application (at least in theory), because it decompiles the .NET IL language to C#. It is not a 1:1 debugger, but maybe it can help you.

__[Check out the dnSpy GitHub Site](https://github.com/0xd4d/dnSpy)__




 