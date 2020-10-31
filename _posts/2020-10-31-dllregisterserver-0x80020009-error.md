---
layout: post
title: "DllRegisterServer 0x80020009 Error"
description: "How I hate COM stuff... and maybe take a look at your file encodings."
date: 2020-10-31 23:45
author: Robert Muehsig
tags: [COM]
language: en
---

{% include JB/setup %}

Last week I had a very strange issue and the solution was really "easy", but took me a while.

# Scenario

For our products we build Office COM Addins with a C++ based "Shim" that boots up our .NET code (e.g. something [like this](https://github.com/NetOfficeFw/ShimmingExample).
As the nature of COM: It requires some pretty dumb registry entries to work and in theory our toolchain should "build" and automatically "register" the output.

# Problem

The registration process just failed with a error message like that:

    The module xxx.dll was loaded but the call to DllRegisterServer failed with error code 0x80020009

After some research you will find some very old stuff or only some general advises like in this [Stackoverflow.com question](https://stackoverflow.com/questions/2727563/registering-a-dll-returns-0x80020009-error), e.g. "run it as administrator". 

# The solution 

Luckily we had another project were we use the same approach and this worked without any issues. After comparing the files I notices some subtile differences: The __file encoding__ was different!

In my failing project some C++ files were encoded with __UTF8-BOM__. I changed everything to __UTF8__ and after this change it worked.

My reaction:

    (╯°□°）╯︵ ┻━┻

I'm not a C++ dev and I'm not even sure why some files had the wrong encoding in the first place. It "worked" - at least Visual Studio 2019 was able to build the stuff, but register it with "regsrv32" just failed.

I needed some hours to figure that out.

Hope this helps!