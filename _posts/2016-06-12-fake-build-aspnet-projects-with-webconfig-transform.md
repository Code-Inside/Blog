---
layout: post
title: "FAKE: Build ASP.NET projects with web.config transformation (and without knowing a tiny bit of F#)"
description: "Using FAKE to build console or desktop applications is quite easy, but for ASP.NET projects a web.config transformation might be needed. This post will show you an easy solution with FAKE."
date: 2016-06-12 14:00
author: Robert Muehsig
tags: [FAKE, NuGet]
language: en
---
{% include JB/setup %}

_This is a follow-up to my other FAKE posts:_

* ["FAKE: Building C# projects without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/02/23/fake-building-with-fake/) 
* ["FAKE: Running xUnit Tests with FAKE without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/02/24/fake-running-xunit-tests-with-fake/)
* ["FAKE: Create NuGet Packages without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/06/21/fake-create-nuget-packages/)
* ["FAKE: Running MSTest Tests with FAKE without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/08/30/fake-running-mstest-tests-with-fake/)

## What's the difference between a ASP.NET and other projects

The most obvious difference is that the output is a bunch of dlls and content files. Additionally you might have a __web.debug.config or web.release.config__ in your source folder. 
Both files are important, because they are used during a Visual-Studio build as a [__Web.Config Transformation__](https://msdn.microsoft.com/en-us/library/dd465326(v=vs.110).aspx)

With a normal build the transformation will not kick in... so we need a way to trigger the transformation.

## Project Overview

The sample project consists of one ASP.NET project and the .fsx file. 

![x]({{BASE_PATH}}/assets/md-images/2016-06-12/project.png "Project Overview")

## The FAKE script

We reuse the MSBuild-Helper from FAKE and inject a couple of "Publish"-related stuff, which will trigger the transformation.

__Publish a ASP.NET project__

    ...
    Target "BuildWebApp" (fun _ ->
    trace "Building WebHosted Connect..."
    !! "**/*.csproj"
     |> MSBuild artifactsBuildDir "Package"
        ["Configuration", "Release"
         "Platform", "AnyCPU"
         "_PackageTempDir", (@"..\" + artifactsDir + @"Release-Ready-WebApp")
         ]
     |> Log "AppBuild-Output: "
    )
    ...
	
## Result

![x]({{BASE_PATH}}/assets/md-images/2016-06-12/output.png "Output")

This build will produce two artifacts - the build-folder just contains the normal build output, but __without__ a web.config transformation. 

The other folder contains a ready to deploy web application, __with the web.config applied__.

You can find the complete [sample & build script on GitHub](https://github.com/Code-Inside/Samples/tree/master/2016/LetsUseFake-AspNet).
