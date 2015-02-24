---
layout: post
title: "FAKE: Building C# projects without knowing a tiny bit of F#"
description: "I was looking for a alternative to pure MSBuild and heard of FAKE, which stands for 'F# Make - A DSL for build tasks.'. See how to get stuff running (... building...) even if you don't know anything about F# (like me)."
date: 2015-02-23 19:15
author: robert.muehsig
tags: [FAKE, Build, MSBuild]
language: en
---
{% include JB/setup %}

MSBuild is the default build engine in the .NET world, but if you do more with MSBuild you will find yourself in a XML-mess, so that's the reason why I tried out __FAKE__. You can find [a](http://blog.codeinside.eu/2010/12/15/howto-msbuild-stylecop/) [couple](http://blog.codeinside.eu/2010/11/12/howto-build-msbuild-solutions/) [of](http://blog.codeinside.eu/2010/11/21/howto-msdeploy-msbuild/) [MSBuild](http://blog.codeinside.eu/2010/11/24/howto-open-mstest-with-msbuild-2/) [related](http://blog.codeinside.eu/2011/01/06/howto-msbuild-nuit/) [posts](http://blog.codeinside.eu/2010/11/29/howto-open-mstest-with-msbuild/) [here](http://blog.codeinside.eu/2010/12/06/howto-web-config-transformations-with-msbuild/).

## Enough from MSBuild, now meet FAKE:
- A DSL for build tasks (e.g. build following projects, copy stuff, deploy stuff etc.)
- [Active community, OSS & written in F#](https://github.com/fsharp/FAKE)
- You don't need to learn F# for using it (at least the basic tasks are easy)
- You can get FAKE via [NuGet](https://www.nuget.org/packages/Fake)
- Before we begin you might want to check out the actual website of [FAKE](http://fsharp.github.io/FAKE/) 

Our goal: Building, running tests, package NuGet Packages etc.

## Let's start with the basics: Building

I created a new console application and downloaded the [NuGet Command-line utility](http://docs.nuget.org/consume/installing-nuget):

![x]({{BASE_PATH}}/assets/md-images/2015-02-23/start.png "Starting point")

## The build.fsx script

So, now we get in touch with a very simple build script. _(Scroll down to read the description of each section)_

    // include Fake lib
    #r "packages/FAKE/tools/FakeLib.dll"
    open Fake
    
    RestorePackages()
    
    // Properties
    let artifactsDir = @".\artifacts\"
    let artifactsBuildDir = "./artifacts/build/"
    
    // Targets
    Target "Clean" (fun _ ->
        trace "Cleanup..."
        CleanDirs [artifactsDir]
    )
    
    Target "BuildApp" (fun _ ->
       trace "Building App..."
       !! "**/*.csproj"
         |> MSBuildRelease artifactsBuildDir "Build"
         |> Log "AppBuild-Output: "
    )
    
    Target "Default" (fun _ ->
        trace "Default Target invoked."
    )
    
    // Dependencies
    "Clean"
      ==> "BuildApp"
      ==> "Default"
    
    // start build
    RunTargetOrDefault "Default"

The top line is a __reference to the FAKE helper libraries__ (included via the #r keyword) and a 'using':

    #r "packages/FAKE/tools/FakeLib.dll"
    open Fake

The next important line is the [__RestorePackages()-line__](http://fsharp.github.io/FAKE/apidocs/fake-restorepackagehelper.html). With this line all NuGet packages will be restored from NuGet.org or your own NuGet-Repository. If you check-in your NuGet packages then you don't need this.	

Then I define some general __properties__, e.g. my build output folders:

    let artifactsDir = @".\artifacts\"
    let artifactsBuildDir = "./artifacts/build/"
	
Now the interesting part: Like in MSBuild you define a couple of "__Targets__":

    Target "Clean" (fun _ ->
        trace "Cleanup..."
        CleanDirs [artifactsDir]
    )
    
    Target "BuildApp" (fun _ ->
       trace "Building App..."
       !! "**/*.csproj"
         |> MSBuildRelease artifactsBuildDir "Build"
         |> Log "AppBuild-Output: "
    )
    
    Target "Default" (fun _ ->
        trace "Default Target invoked."
    )
	
The first target cleans the _artifactsDir_ via the [FileHelper](http://fsharp.github.io/FAKE/apidocs/fake-filehelper.html). The next one is responsible for calling __MSBuild (which builds the actual project)__ (via [MSBuildHelper](http://fsharp.github.io/FAKE/apidocs/fake-msbuildhelper.html)). 
This is maybe the most awkward part of the build script for a C# dev, but this "pipelining" is part of F#'s nature. I can't explain it right now, but it works (I didn't lie when I said that I have not a tiny bit of knowledge about F#). 

 At the end of the file you define the dependency graph for each target: 
 
    "Clean"
      ==> "BuildApp"
      ==> "Default"
	  
After that we invoke the 'Default' target with this line:

    RunTargetOrDefault "Default"
	
## Invoke the build.fsx

Now that we have our project in place and a valid FAKE script we need to invoke the script. The easiest option on Windows is a batch file like this:

    @echo off
    cls
    ".nuget\NuGet.exe" "Install" "FAKE" "-OutputDirectory" "packages" "-ExcludeVersion"
    "packages\FAKE\tools\Fake.exe" build.fsx

First we need to load FAKE via NuGet and after that we invoke our __build.fsx__ file with __Fake.exe__. 

Now you or any build machine can invoke the batch file and start the build!

## Our first FAKE script!

The output is very well formatted and should explain the mechanics behind it good enough:

    Package "FAKE" is already installed.
    Building project with version: LocalBuild
    Shortened DependencyGraph for Target Default:
    <== Default
    <== BuildApp
    <== Clean
    
    The resulting target order is:
    - Clean
    - BuildApp
    - Default
    Starting Target: Clean
    Cleanup...
    Creating C:\Users\Robert\Documents\Visual Studio 2013\Projects\LetsUseFake\artifacts\
    Finished Target: Clean
    Starting Target: BuildApp (==> Clean)
    Building App...
    Building project: C:\Users\Robert\Documents\Visual Studio 2013\Projects\LetsUseFake\LetsUseFake\LetsUseFake.csproj
    ... (standard MSBuild output, nothing special...)
    
    Time Elapsed 00:00:01.24
    AppBuild-Output: C:\Users\Robert\Documents\Visual Studio 2013\Projects\LetsUseFake\artifacts\build\LetsUseFake.exe
    AppBuild-Output: C:\Users\Robert\Documents\Visual Studio 2013\Projects\LetsUseFake\artifacts\build\LetsUseFake.exe.config
    AppBuild-Output: C:\Users\Robert\Documents\Visual Studio 2013\Projects\LetsUseFake\artifacts\build\LetsUseFake.pdb
    Finished Target: BuildApp
    Starting Target: Default (==> BuildApp)
    Default Target invoked.
    Finished Target: Default
    
    ---------------------------------------------------------------------
    Build Time Report
    ---------------------------------------------------------------------
    Target     Duration
    ------     --------
    Clean      00:00:00.0032838
    BuildApp   00:00:01.5844651
    Default    00:00:00.0007512
    Total:     00:00:01.6153969
    Status:    Ok
    ---------------------------------------------------------------------

The resulting build artifact:
	
![x]({{BASE_PATH}}/assets/md-images/2015-02-23/result.png "Result")

You can find the complete [sample on GitHub](https://github.com/Code-Inside/Samples/tree/master/2015/LetsUseFake-Build/LetsUseFake)
