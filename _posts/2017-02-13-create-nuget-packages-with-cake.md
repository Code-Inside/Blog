---
layout: post
title: "Create NuGet packages with Cake"
description: "After building & running tests we might want to take a look at creating actual NuGet packages with Cake."
date: 2017-02-13 23:45
author: Robert Muehsig
tags: [Cake, NuGet]
language: en
---
{% include JB/setup %}

This blogpost is a follow up to these __[Cake (C# Make)](http://cakebuild.net/)__ related blogpost:

* [Building with Cake](https://blog.codeinside.eu/2016/07/09/cake-building-with-cake/)
* [Build & run xUnit tests with Cake](https://blog.codeinside.eu/2017/02/07/build-and-run-xunit-tests-with-cake/)

## Scenario

![x]({{BASE_PATH}}/assets/md-images/2017-02-13/proj.png "Demo proj")

Let's say we have this project structure. The "Config", "Result" and "Engine" projects contains a corresponding .nuspec, like this:

    <?xml version="1.0"?>
    <package >
      <metadata>
        <id>Sloader.Config</id>
        <version>0.1.0</version>
        <title>Sloader.Config</title>
        <authors>Code Inside Team</authors>
        <owners>Code Inside Team</owners>
        <licenseUrl>https://github.com/Code-Inside/Sloader/blob/master/LICENSE</licenseUrl>
        <projectUrl>https://github.com/Code-Inside/Sloader</projectUrl>
        <requireLicenseAcceptance>false</requireLicenseAcceptance>
        <description>Sloader Config</description>
        <releaseNotes>
          ## Version 0.1 ##
          Init
        </releaseNotes>
        <copyright>Copyright 2017</copyright>
        <tags>Sloader</tags>
        <dependencies />
      </metadata>
    </package>

Nothing fancy - pretty normal NuGet stuff. 

## Goal

The goal is to create a NuGet package for each target project with Cake. 

## build.cake

The usage in Cake is pretty much the same as with the normal __[nuget.exe pack](https://docs.microsoft.com/en-us/nuget/tools/nuget-exe-cli-reference#pack)__ command 
The sample only shows the actual cake target - see the older blogposts for a more complete example:

    Task("BuildPackages")
        .IsDependentOn("Restore-NuGet-Packages")
    	.IsDependentOn("RunTests")
        .Does(() =>
    {
        var nuGetPackSettings = new NuGetPackSettings
    	{
    		OutputDirectory = rootAbsoluteDir + @"\artifacts\",
    		IncludeReferencedProjects = true,
    		Properties = new Dictionary<string, string>
    		{
    			{ "Configuration", "Release" }
    		}
    	};
    
         NuGetPack("./src/Sloader.Config/Sloader.Config.csproj", nuGetPackSettings);
         NuGetPack("./src/Sloader.Result/Sloader.Result.csproj", nuGetPackSettings);
    	 NuGetPack("./src/Sloader.Engine/Sloader.Engine.csproj", nuGetPackSettings);
    });

Easy, right? The most interesting part here is the [NuGetPack](http://cakebuild.net/api/Cake.Common.Tools.NuGet/NuGetAliases/EF4ED944) command.

## Result

![x]({{BASE_PATH}}/assets/md-images/2017-02-13/result.png "NuGet packages!")

The console output should make the flow pretty clear:

    PS C:\Users\Robert\Documents\GitHub\Sloader> .\build.ps1 -t BuildPackages
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
    Cleaning directory C:/Users/Robert/Documents/GitHub/Sloader/artifacts
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
       Sloader.Config.Tests  Total: 22, Errors: 0, Failed: 0, Skipped: 0, Time: 0.839s
       Sloader.Engine.Tests  Total:  9, Errors: 0, Failed: 0, Skipped: 0, Time: 1.597s
       Sloader.Result.Tests  Total:  4, Errors: 0, Failed: 0, Skipped: 0, Time: 0.979s
                                    --          -          -           -        ------
                       GRAND TOTAL: 35          0          0           0        3.415s (7.631s)
    Finished executing task: RunTests
    
    ========================================
    BuildPackages
    ========================================
    Executing task: BuildPackages
    Attempting to build package from 'Sloader.Config.csproj'.
    MSBuild auto-detection: using msbuild version '14.0' from 'C:\Program Files (x86)\MSBuild\14.0\bin'.
    Packing files from 'C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Config\bin\Release'.
    Using 'Sloader.Config.nuspec' for metadata.
    Found packages.config. Using packages listed as dependencies
    Successfully created package 'C:\Users\Robert\Documents\GitHub\Sloader\artifacts\Sloader.Config.0.1.0.nupkg'.
    Attempting to build package from 'Sloader.Result.csproj'.
    MSBuild auto-detection: using msbuild version '14.0' from 'C:\Program Files (x86)\MSBuild\14.0\bin'.
    Packing files from 'C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Result\bin\Release'.
    Using 'Sloader.Result.nuspec' for metadata.
    Found packages.config. Using packages listed as dependencies
    Successfully created package 'C:\Users\Robert\Documents\GitHub\Sloader\artifacts\Sloader.Result.0.1.0.nupkg'.
    Attempting to build package from 'Sloader.Engine.csproj'.
    MSBuild auto-detection: using msbuild version '14.0' from 'C:\Program Files (x86)\MSBuild\14.0\bin'.
    Packing files from 'C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Engine\bin\Release'.
    Using 'Sloader.Engine.nuspec' for metadata.
    Found packages.config. Using packages listed as dependencies
    Successfully created package 'C:\Users\Robert\Documents\GitHub\Sloader\artifacts\Sloader.Engine.0.1.0.nupkg'.
    Finished executing task: BuildPackages
    
    Task                          Duration
    --------------------------------------------------
    Clean                         00:00:00.1785159
    Restore-NuGet-Packages        00:00:01.7378473
    BuildTests                    00:00:08.0222787
    RunTests                      00:00:08.2714563
    BuildPackages                 00:00:08.1142780
    --------------------------------------------------
    Total:                        00:00:26.3243762