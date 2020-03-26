---
layout: post
title: "Escape enviroment variables in MSIEXEC parameters"
description: "TL;DR: If you invoke MSIEXEC via CMD use %%var%% instead of %var%"
date: 2020-03-26 23:59
author: Robert Muehsig
tags: [CMD, MSIEXEC, MSI, Windows]
language: en
---

{% include JB/setup %}

# Problem

Customers can install our [product](https://oneoffixx.com/) on Windows with a standard MSI package. To automate the installation administrators can use [MSIEXEC](https://docs.microsoft.com/de-de/windows/win32/msi/command-line-options?redirectedfrom=MSDN) and MSI parameters to configure our client. 

A simple installation can look like this:

    msiexec /qb /i "OneOffixx.msi" ... CACHEFOLDER="D:/OneOffixx/"

The "CACHEFOLDER" parameter will be written in the .exe.config file and our program will read it and stores offline content under the given location.

So far, so good.

For Terminal Server installations or "multi-user" scenarios this will not work, because each cache is bound to a local account. To solve this we could just insert the "%username%" enviroment variable, right?

Well... no... at least not with the obvious call, because this:

    msiexec /qb /i "OneOffixx.msi" ... CACHEFOLDER="D:/%username%/OneOffixx/"

will result in a call like this:

    msiexec /qb /i "OneOffixx.msi" ... CACHEFOLDER="D:/admin/OneOffixx/"

# Solution

I needed a few hours and some Google-Fu to found the answer.

To "escape" those variables we need to invoke it like this:

    msiexec /qb /i "OneOffixx.msi" ... CACHEFOLDER="D:/%%username%%/OneOffixx/"

__Be aware:__ This stuff is a mess. It depends on your scenario. Checkout [this Stackoverflow answer](https://stackoverflow.com/a/31420292) to learn more. The double percent did the trick for us, so I guess it is "ok-ish".

Hope this helps!
