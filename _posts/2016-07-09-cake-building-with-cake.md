---
layout: post
title: "CAKE: Building solutions with C# & Roslyn"
description: "Instead of writing MSBuild-XML or F# build scripts with FAKE, let's see how a C# based build system works. So, let's play with CAKE - C# Make."
date: 2016-07-09 14:15
author: Robert Muehsig
tags: [CAKE, Build, MSBuild]
language: en
---
{% include JB/setup %}

![x]({{BASE_PATH}}/assets/md-images/2016-07-09/cake.png "CAKE - C# Make")

## CAKE - C# Make

- A DSL for build tasks (e.g. build following projects, copy stuff, deploy stuff etc.)
- It's just C# code that gets compiled via Roslyn
- [Active community, OSS & written in C#](https://github.com/cake-build/cake)
- You can get CAKE via [NuGet](https://www.nuget.org/packages/Cake)
- Before we begin you might want to check out the actual website of [CAKE](http://cakebuild.net/) 
- Cross Platform support

Our goal: Building, running tests, package NuGet Packages etc.

## Related: MSBuild and FAKE blogposts

I already did a couple of MSBuild and FAKE related blogposts, so if you are interested on these topics as well go ahead (some are quite old, there is a high chance that some pieces might not apply anymore):

* [MSBuild & Stylecop](http://blog.codeinside.eu/2010/12/15/howto-msbuild-stylecop/)
* [MSBuild & Building solutions](http://blog.codeinside.eu/2010/11/12/howto-build-msbuild-solutions/)
* [MSBuild & MSDeploy](http://blog.codeinside.eu/2010/11/21/howto-msdeploy-msbuild/)
* [MSBuild & MSTest 1](http://blog.codeinside.eu/2010/11/24/howto-open-mstest-with-msbuild-2/)
* [MSBuild & MSTest 2](http://blog.codeinside.eu/2010/11/29/howto-open-mstest-with-msbuild/)
* [MSBuild & NUnit](http://blog.codeinside.eu/2011/01/06/howto-msbuild-nuit/)
* [MSBuild & Web.config Transformations](http://blog.codeinside.eu/2010/12/06/howto-web-config-transformations-with-msbuild/)

* ["FAKE: Building C# projects without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/02/23/fake-building-with-fake/) 
* ["FAKE: Running xUnit Tests with FAKE without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/02/24/fake-running-xunit-tests-with-fake/)
* ["FAKE: Create NuGet Packages without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/06/21/fake-create-nuget-packages/)
* ["FAKE: Running MSTest Tests with FAKE without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/08/30/fake-running-mstest-tests-with-fake/)
* ["FAKE: Build ASP.NET projects with web.config transformation (and without knowing a tiny bit of F#)"](http://blog.codeinside.eu/2016/06/12/fake-build-aspnet-projects-with-webconfig-transform/)

Ok... now back to CAKE.

## Let's start with the basics: Building

I created a pretty simple WPF app and [followed these instructions](http://cakebuild.net/docs/tutorials/setting-up-a-new-project). 

## The build.cake script

My script is a simplified version [of this build script](https://github.com/cake-build/example/blob/master/build.cake):

    // ARGUMENTS
    var target = Argument("target", "Default");
    
    // TASKS
    Task("Restore-NuGet-Packages")
        .Does(() =>
    {
        NuGetRestore("CakeExampleWithWpf.sln");
    });
    
    Task("Build")
        .IsDependentOn("Restore-NuGet-Packages")
        .Does(() =>
    {
          MSBuild("CakeExampleWithWpf.sln", settings =>
            settings.SetConfiguration("Release"));
    
    });
    
    // TASK TARGETS
    Task("Default").IsDependentOn("Build");
    
    // EXECUTION
    RunTarget(target);

If you know FAKE or MSBuild, this is more or less the same structure. You define tasks, which may depend on other tasks. At the end you invoke one task and the dependency chain will do its work.
	
## Invoke build.cake

The "build.ps1" will invoke "tools/cake.exe" with the input file "build.cake". 

__"build.ps1" is just a helper.__ 
This Powershell script will download nuget.exe and download the CAKE NuGet-Package and extract it under a /tools folder. If you don't have problems with binary files in your source control, you don't need this Powershell script.

## Our first CAKE script!

The output is very well formatted and should explain the mechanics behind it good enough:

    Time Elapsed 00:00:02.86
    Finished executing task: Build
    
    ========================================
    Default
    ========================================
    Executing task: Default
    Finished executing task: Default
    
    Task                          Duration
    --------------------------------------------------
    Restore-NuGet-Packages        00:00:00.5192250
    Build                         00:00:03.1315658
    Default                       00:00:00.0113019
    --------------------------------------------------
    Total:                        00:00:03.6620927
    
The first steps are pretty easy and it's much easier than MSBuild and feels good if you know C#.

The super simple intro code can be found on [__GitHub__](https://github.com/Code-Inside/Samples/tree/master/2016/CakeIntro).
