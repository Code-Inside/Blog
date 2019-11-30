---
layout: post
title: "Did you know that you can build .NET Core apps with MSBuild.exe?"
description: "... or how to avoid: 'The Microsoft.Build.Tasks.AL task could not be loaded from the assembly Microsoft.Build.Tasks.Core...'"
date: 2019-11-30 23:45
author: Robert Muehsig
tags: [MSBuild, .NET Core]
language: en
---

{% include JB/setup %}

# The problem

We recently updated a bunch of our applications to .NET Core 3.0. Because of the compatibility changes to the "old framework" we try to move more and more projects to .NET Core, but some projects still target ".NET Framework 4.7.2", but they should work "ok-ish" when used from .NET Core 3.0 applications.

The first tests were quite successful, but unfortunately when we tried to build and pulish the updated .NET Core 3.0 app via 'dotnet publish' (with a reference to a .NET Framework 4.7.2 app) we faced this error:

    C:\Program Files\dotnet\sdk\3.0.100\Microsoft.Common.CurrentVersion.targets(3639,5): error MSB4062: The "Microsoft.Build.Tasks.AL" task could not be loaded from the assembly Microsoft.Build.Tasks.Core, Version=15.1.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a.  Confirm that the <UsingTask> declaration is correct, that the assembly and all its dependencies are available, and that the task contains a public class that implements Microsoft.Build.Framework.ITask. 

# The root cause

After some experiments we saw a pattern: 

Each .NET Framework 4.7.2 based project with a '.resx' file would result in the above error. 

# The solution

'.resx' files are still a valid thing to do, so we checked out if we could work around this problem, but unfortunately this was not super successful. We moved some resources, but in the end some resources must stay in the corresponding file.

We used the 'dotnet publish...' command to build and publish .NET Core based applications, but then I tried to build the .NET Core application from MSBuild.exe and discovered that this worked.

# Lessons learned

If you have a mixed environment with "old" .NET Framework based applications with resources in use and want to use this in combination with .NET Core: Try to use the "old school" MSBuild.exe way. 

MSBuild.exe is capable of building .NET Core applications and it is more or less the same. 

## Be aware

Regarding ASP.NET Core applications: The 'dotnet publish' command will create a web.config file - if you use the MSBuild approach this file will not be created automatically. I'm not sure if there is a hidden switch, but if you just treat .NET Core apps like .NET Framework console applications the web.config file is not generated. 
This might lead to some problems when you deploy this to an IIS.

Hope this helps!
