---
layout: post
title: "FAKE: Running xUnit Tests with FAKE without knowing a tiny bit of F#"
description: "After building should be the next priority to run tests (which we all have, right?). So how can I run xUnit tests with FAKE?"
date: 2015-02-24 22:00
author: robert.muehsig
tags: [FAKE, Test, MSBuild, xUnit]
language: en
---
{% include JB/setup %}

_This is a follow-up to my first FAKE post ["FAKE: Building C# projects without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/02/23/fake-building-with-fake/)_.

## xUnit Test Project

We start with a simple test project, which is basically a normal library project, and add [xUnit via NuGet](http://www.nuget.org/packages/xunit/).

![x]({{BASE_PATH}}/assets/md-images/2015-02-24/start.png "Starting point")

The actual test is just stupid, but should work for the demo:

    public class FoobarTests
    {
        [Fact]
        public void DoAStupidTest()
        {
            Assert.True(true);
        }
    }

## Get the xUnit Runners

Next we need the xUnit runner (to run the tests...), which can be installed [via NuGet](http://www.nuget.org/packages/xunit.runners/) on the Solution Level. 

![x]({{BASE_PATH}}/assets/md-images/2015-02-24/runner.png "Already installed xUnit runner")

If you do this via the UI you should see a __package.config__ in your solution directory:

    <?xml version="1.0" encoding="utf-8"?>
    <packages>
      <package id="xunit.runners" version="1.9.2" />
    </packages>

## Adding the test to the build.fsx script

This time I will only show the important parts for the tests (skipping the targets from the first post).

    // include Fake lib
    ...
	
    // Properties
	...
    let artifactsTestsDir  = "./artifacts/tests/"
	
    // Targets
    Target "BuildTests" (fun _ ->
    trace "Building Tests..."
    !! "**/*Tests.csproj"
      |> MSBuildDebug artifactsTestsDir "Build"
      |> Log "TestBuild-Output: "
    )

    Target "RunTests" (fun _ ->
        trace "Running Tests..."
        !! (artifactsTestsDir + @"\*Tests.dll") 
          |> xUnit (fun p -> {p with OutputDir = artifactsTestsDir })
    )
    ...
    // Dependencies
    "Clean"
      ==> "BuildApp"
      ==> "BuildTests"
      ==> "RunTests"
      ==> "Default"
    
    // start build
    RunTargetOrDefault "Default"

This time I added a new __property__, which points to the build output of the test project:

    let artifactsTestsDir  = "./artifacts/tests/"
	
This path is now used in the __build__ target. With this call I build all projects that ends with _Tests.csproj_. 

    Target "BuildTests" (fun _ ->
    trace "Building Tests..."
    !! "**/*Tests.csproj"
      |> MSBuildDebug artifactsTestsDir "Build"
      |> Log "TestBuild-Output: "
    )

Now we need the runner. FAKE already have a [xUnitHelper](http://fsharp.github.io/FAKE/apidocs/fake-xunithelper.html), so we don't need to call the runner and check the response - so this is really, really easy:

    Target "RunTests" (fun _ ->
        trace "Running Tests..."
        !! (artifactsTestsDir + @"\*Tests.dll") 
          |> xUnit (fun p -> {p with OutputDir = artifactsTestsDir })
    )
	
Pointed to the test directory and FAKE will do all the hard work.

The last change is the Build-Dependency-Graph, which now contains the steps for building the test project and run the tests. 

    // Dependencies
    "Clean"
      ==> "BuildApp"
      ==> "BuildTests"
      ==> "RunTests"
      ==> "Default"
	  
In this demo FAKE will build the test project two times, but in real life I would split the source and the test projects in different directories to get a more granular control what I want to build.
	
## Invoke the build.fsx

I don't need to change anything inside the batch file and can just invoke the batch:

    Package "FAKE" is already installed.
    C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\.nuget\nuget.exe  "install" "C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\.nuget\packages.config" "-OutputDirectory" "C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\packages"
    All packages listed in packages.config are already installed.
    C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\.nuget\nuget.exe  "install" "C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\LetsUseFake.Tests\packages.config" "-OutputDirectory" "C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\packages"
    All packages listed in packages.config are already installed.
    Building project with version: LocalBuild
    Shortened DependencyGraph for Target Default:
    <== Default
    <== RunTests
    <== BuildTests
    <== BuildApp
       <== Clean
    
    The resulting target order is:
     - Clean
     - BuildApp
     - BuildTests
     - RunTests
     - Default
    Starting Target: Clean
    Cleanup...
    Deleting contents of .\artifacts\
    Finished Target: Clean
    Starting Target: BuildApp (==> Clean)
    Building App...
    ... (MSBuild for the Console and Test Project)
    AppBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\build\LetsUseFake.exe
    AppBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\build\LetsUseFake.exe.config
    AppBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\build\LetsUseFake.pdb
    AppBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\build\LetsUseFake.Tests.dll
    AppBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\build\LetsUseFake.Tests.pdb
    AppBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\build\xunit.dll
    AppBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\build\xunit.xml
    Finished Target: BuildApp
    Starting Target: BuildTests (==> BuildApp)
    Building Tests...
    ... (MSBuild for the Test Project) ...
    TestBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\tests\LetsUseFake.Tests.dll
    TestBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\tests\LetsUseFake.Tests.pdb
    TestBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\tests\xunit.dll
    TestBuild-Output: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\tests\xunit.xml
    Finished Target: BuildTests
    Starting Target: RunTests (==> BuildTests)
    Running Tests...
    C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\packages\xunit.runners.1.9.2\tools\xunit.console.clr4.exe "C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\tests\LetsUseFake.Tests.dll"
    xUnit.net console test runner (64-bit .NET 4.0.30319.0)
    Copyright (C) 2013 Outercurve Foundation.
    
    xunit.dll:     Version 1.9.2.1705
    Test assembly: C:\Users\Robert\Documents\GitHub\Samples\2015\LetsUseFake-Test\LetsUseFake\artifacts\tests\LetsUseFake.Tests.dll
    
    1 total, 0 failed, 0 skipped, took 0.512 seconds
    Finished Target: RunTests
    Starting Target: Default (==> RunTests)
    Default Target invoked.
    Finished Target: Default
    
    ---------------------------------------------------------------------
    Build Time Report
    ---------------------------------------------------------------------
    Target       Duration
    ------       --------
    Clean        00:00:00.0219014
    BuildApp     00:00:01.3671003
    BuildTests   00:00:00.7714649
    RunTests     00:00:01.7558856
    Default      00:00:00.0007886
    Total:       00:00:03.9697467
    Status:      Ok
    ---------------------------------------------------------------------

The resulting build artifact:
	
![x]({{BASE_PATH}}/assets/md-images/2015-02-24/result.png "Result")

You can find the complete [sample & build script on GitHub](https://github.com/Code-Inside/Samples/tree/master/2015/LetsUseFake-Test/LetsUseFake)