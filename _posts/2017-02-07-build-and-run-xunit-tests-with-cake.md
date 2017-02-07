---
layout: post
title: "Build & run xUnit tests with Cake"
description: "Let's have a look deeper look at Cake and build some xUnit tests with it!"
date: 2017-02-07 23:45
author: Robert Muehsig
tags: [Cake, xUnit]
language: en
---
{% include JB/setup %}

Last year I already covered the __[basic usage of Cake]__(https://blog.codeinside.eu/2016/07/09/cake-building-with-cake/), which stands for "C# Make". This time we want to build and run __[xUnit](https://xunit.github.io/)__ tests with Cake.

## Scenario

![x]({{BASE_PATH}}/assets/md-images/2017-02-07/proj.png "Demo proj")

Let's say we have this project structure. Be aware that all our tests have the suffix "Tests" in the project name.

The files are organized like this, so we have all "Tests" in a "tests" folder and the actual code under "src":

    src/Sloader.Config
    src/Sloader.Engine
    src/Sloader.Hosts.Console
    src/Sloader.Result
    tests/Sloader.Config.Tests
    tests/Sloader.Engine.Tests
    tests/Sloader.Result.Tests
    .gitignore
    build.cake
    build.ps1
    LICENSE
    Sloader.sln

## Goal

Now we want to build all tests projects and run them with the xUnit console runner. Be aware that there are multiple ways of doing it, but I found this quite good.

## build.cake

    #tool "nuget:?package=xunit.runner.console"
    //////////////////////////////////////////////////////////////////////
    // ARGUMENTS
    //////////////////////////////////////////////////////////////////////
    
    var target = Argument("target", "Default");
    var configuration = Argument("configuration", "Release");
    
    //////////////////////////////////////////////////////////////////////
    // PREPARATION
    //////////////////////////////////////////////////////////////////////
    
    // Define directories.
    var artifactsDir  = Directory("./artifacts/");
    var rootAbsoluteDir = MakeAbsolute(Directory("./")).FullPath;
    
    //////////////////////////////////////////////////////////////////////
    // TASKS
    //////////////////////////////////////////////////////////////////////
    
    Task("Clean")
        .Does(() =>
    {
        CleanDirectory(artifactsDir);
    });
    
    Task("Restore-NuGet-Packages")
        .IsDependentOn("Clean")
        .Does(() =>
    {
        NuGetRestore("./Sloader.sln");
    });
    
    Task("Build")
        .IsDependentOn("Restore-NuGet-Packages")
        .Does(() =>
    {
    
         
    });
    
    Task("BuildTests")
        .IsDependentOn("Restore-NuGet-Packages")
        .Does(() =>
    {
    	var parsedSolution = ParseSolution("./Sloader.sln");
    
    	foreach(var project in parsedSolution.Projects)
    	{
    	
    	if(project.Name.EndsWith(".Tests"))
    		{
            Information("Start Building Test: " + project.Name);
    
            MSBuild(project.Path, new MSBuildSettings()
                    .SetConfiguration("Debug")
                    .SetMSBuildPlatform(MSBuildPlatform.Automatic)
                    .SetVerbosity(Verbosity.Minimal)
                    .WithProperty("SolutionDir", @".\")
                    .WithProperty("OutDir", rootAbsoluteDir + @"\artifacts\_tests\" + project.Name + @"\"));
    		}
    	
    	}    
    
    });
    
    Task("RunTests")
        .IsDependentOn("BuildTests")
        .Does(() =>
    {
        Information("Start Running Tests");
        XUnit2("./artifacts/_tests/**/*.Tests.dll");
    });
    
    //////////////////////////////////////////////////////////////////////
    // TASK TARGETS
    //////////////////////////////////////////////////////////////////////
    
    Task("Default")
        .IsDependentOn("RunTests");
    
    //////////////////////////////////////////////////////////////////////
    // EXECUTION
    //////////////////////////////////////////////////////////////////////
    
    RunTarget(target);

## Explanation: BuildTests?

The default target "Default" will trigger "RunTests", which depend on "BuildTests".

Inside the "BuildTests"-target we use a handy helper from Cake and we parse the .sln file and search all "Test"-projects.
With that information we can build each test individually and don't have to worry over "overlapping" files. 
The output of this build will be saved at __"artifacts/_tests"__.

## Running xUnit

To run [xUnit](http://cakebuild.net/dsl/xunit-v2/) we have to include the runner at the top of the cake file:

    #tool "nuget:?package=xunit.runner.console"
	
Now we can just invoke XUnit2 and scan for all Tests.dlls and we are done:

    XUnit2("./artifacts/_tests/**/*.Tests.dll");


## Result

The console output should make the flow pretty clear:

    PS C:\Users\Robert\Documents\GitHub\Sloader> .\build.ps1
    Preparing to run build script...
    Running build script...
    Analyzing build script...
    Processing build script...
    Installing tools...
    Compiling build script...
    
    ========================================
    Clean
    ========================================
    Executing task: Clean
    Creating directory C:/Users/Robert/Documents/GitHub/Sloader/artifacts
    Finished executing task: Clean
    
    ========================================
    Restore-NuGet-Packages
    ========================================
    Executing task: Restore-NuGet-Packages
    MSBuild auto-detection: using msbuild version '14.0' from 'C:\Program Files (x86)\MSBuild\14.0\bin'.
    All packages listed in packages.config are already installed.
    Finished executing task: Restore-NuGet-Packages
    
    ========================================
    BuildTests
    ========================================
    Executing task: BuildTests
    Start Building Test: Sloader.Config.Tests
    Microsoft (R) Build Engine version 14.0.25420.1
    Copyright (C) Microsoft Corporation. All rights reserved.
    
      Sloader.Config -> C:\Users\Robert\Documents\GitHub\Sloader\artifacts\_tests\Sloader.Config.Tests\Sloader.Config.dll
      Sloader.Config.Tests -> C:\Users\Robert\Documents\GitHub\Sloader\artifacts\_tests\Sloader.Config.Tests\Sloader.Config
      .Tests.dll
    Start Building Test: Sloader.Result.Tests
    Microsoft (R) Build Engine version 14.0.25420.1
    Copyright (C) Microsoft Corporation. All rights reserved.
    
      Sloader.Result -> C:\Users\Robert\Documents\GitHub\Sloader\artifacts\_tests\Sloader.Result.Tests\Sloader.Result.dll
      Sloader.Result.Tests -> C:\Users\Robert\Documents\GitHub\Sloader\artifacts\_tests\Sloader.Result.Tests\Sloader.Result
      .Tests.dll
    Start Building Test: Sloader.Engine.Tests
    Microsoft (R) Build Engine version 14.0.25420.1
    Copyright (C) Microsoft Corporation. All rights reserved.
    
      Sloader.Config -> C:\Users\Robert\Documents\GitHub\Sloader\artifacts\_tests\Sloader.Engine.Tests\Sloader.Config.dll
      Sloader.Result -> C:\Users\Robert\Documents\GitHub\Sloader\artifacts\_tests\Sloader.Engine.Tests\Sloader.Result.dll
      Sloader.Engine -> C:\Users\Robert\Documents\GitHub\Sloader\artifacts\_tests\Sloader.Engine.Tests\Sloader.Engine.dll
      Sloader.Engine.Tests -> C:\Users\Robert\Documents\GitHub\Sloader\artifacts\_tests\Sloader.Engine.Tests\Sloader.Engine
      .Tests.dll
    Finished executing task: BuildTests
    
    ========================================
    RunTests
    ========================================
    Executing task: RunTests
    Start Running Tests
    xUnit.net Console Runner (64-bit .NET 4.0.30319.42000)
      Discovering: Sloader.Config.Tests
      Discovered:  Sloader.Config.Tests
      Starting:    Sloader.Config.Tests
      Finished:    Sloader.Config.Tests
      Discovering: Sloader.Engine.Tests
      Discovered:  Sloader.Engine.Tests
      Starting:    Sloader.Engine.Tests
      Finished:    Sloader.Engine.Tests
      Discovering: Sloader.Result.Tests
      Discovered:  Sloader.Result.Tests
      Starting:    Sloader.Result.Tests
      Finished:    Sloader.Result.Tests
    === TEST EXECUTION SUMMARY ===
       Sloader.Config.Tests  Total: 22, Errors: 0, Failed: 0, Skipped: 0, Time: 0.342s
       Sloader.Engine.Tests  Total:  9, Errors: 0, Failed: 0, Skipped: 0, Time: 0.752s
       Sloader.Result.Tests  Total:  4, Errors: 0, Failed: 0, Skipped: 0, Time: 0.475s
                                    --          -          -           -        ------
                       GRAND TOTAL: 35          0          0           0        1.569s (3.115s)
    Finished executing task: RunTests
    
    ========================================
    Default
    ========================================
    Executing task: Default
    Finished executing task: Default
    
    Task                          Duration
    --------------------------------------------------
    Clean                         00:00:00.0155255
    Restore-NuGet-Packages        00:00:00.5065704
    BuildTests                    00:00:02.1590662
    RunTests                      00:00:03.2443534
    Default                       00:00:00.0061325
    --------------------------------------------------
    Total:                        00:00:05.9316480