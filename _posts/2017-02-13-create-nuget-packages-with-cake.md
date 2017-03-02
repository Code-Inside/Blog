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
        <version>$version$</version>
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

Nothing fancy - pretty normal NuGet stuff, but be aware of the "$version$" variable. This variable is called a ["replacement-token"](https://docs.microsoft.com/de-de/nuget/schema/nuspec#replacement-tokens). When the NuGet package is created and it detects such a replacement-token, it will search for the AssemblyVersion (or other replacement-token sources). 

__Versioning in NuGet:__

I'm not a NuGet expert, but you should also versioning your assembly info, otherwise some systems may have trouble to update your dll. The version inside the package can be different from the actual assembly version, but you should manage booth or use this replacement-token-mechanic.

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
    
	    MSBuild("./src/Sloader.Config/Sloader.Config.csproj", new MSBuildSettings().SetConfiguration("Release"));
        NuGetPack("./src/Sloader.Config/Sloader.Config.csproj", nuGetPackSettings);
	    MSBuild("./src/Sloader.Result/Sloader.Result.csproj", new MSBuildSettings().SetConfiguration("Release"));
        NuGetPack("./src/Sloader.Result/Sloader.Result.csproj", nuGetPackSettings);
	    MSBuild("./src/Sloader.Engine/Sloader.Engine.csproj", new MSBuildSettings().SetConfiguration("Release"));
	    NuGetPack("./src/Sloader.Engine/Sloader.Engine.csproj", nuGetPackSettings);
    });

Easy, right? The most interesting part here is the [NuGetPack](http://cakebuild.net/api/Cake.Common.Tools.NuGet/NuGetAliases/EF4ED944) command. Before we invoke this command we need to make sure that we build the last recent version - to enforce that we just rebuild each project in release mode.

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
       Sloader.Config.Tests  Total: 23, Errors: 0, Failed: 0, Skipped: 0, Time: 0.554s
       Sloader.Engine.Tests  Total: 17, Errors: 0, Failed: 0, Skipped: 0, Time: 1.070s
       Sloader.Result.Tests  Total:  4, Errors: 0, Failed: 0, Skipped: 0, Time: 1.061s
                                    --          -          -           -        ------
                       GRAND TOTAL: 44          0          0           0        2.684s (5.697s)
    Finished executing task: RunTests
    
    ========================================
    BuildPackages
    ========================================
    Executing task: BuildPackages
    Microsoft (R) Build Engine version 14.0.25420.1
    Copyright (C) Microsoft Corporation. All rights reserved.
    
    Build started 2017-02-19 22:00:09.
    The target "_ConvertPdbFiles" listed in a BeforeTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (34,37)" does not exist in the project, and will be ignored.
    The target "_CollectPdbFiles" listed in an AfterTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (34,70)" does not exist in the project, and will be ignored.
    The target "_CollectMdbFiles" listed in a BeforeTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (41,38)" does not exist in the project, and will be ignored.
    The target "_CopyMdbFiles" listed in an AfterTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Common
    .targets\ImportAfter\Xamarin.Common.targets (41,71)" does not exist in the project, and will be ignored.
    Project "C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Config\Sloader.Config.csproj" on node 1 (Build target(s))
    .
    GenerateTargetFrameworkMonikerAttribute:
    Skipping target "GenerateTargetFrameworkMonikerAttribute" because all output files are up-to-date with respect to the i
    nput files.
    CoreCompile:
    Skipping target "CoreCompile" because all output files are up-to-date with respect to the input files.
    CopyFilesToOutputDirectory:
      Sloader.Config -> C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Config\bin\Release\Sloader.Config.dll
    Done Building Project "C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Config\Sloader.Config.csproj" (Build target
    (s)).
    
    
    Build succeeded.
        0 Warning(s)
        0 Error(s)
    
    Time Elapsed 00:00:00.22
    Attempting to build package from 'Sloader.Config.csproj'.
    MSBuild auto-detection: using msbuild version '14.0' from 'C:\Program Files (x86)\MSBuild\14.0\bin'.
    Packing files from 'C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Config\bin\Release'.
    Using 'Sloader.Config.nuspec' for metadata.
    Found packages.config. Using packages listed as dependencies
    Successfully created package 'C:\Users\Robert\Documents\GitHub\Sloader\artifacts\Sloader.Config.0.2.1.nupkg'.
    Microsoft (R) Build Engine version 14.0.25420.1
    Copyright (C) Microsoft Corporation. All rights reserved.
    
    Build started 2017-02-19 22:00:10.
    The target "_ConvertPdbFiles" listed in a BeforeTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (34,37)" does not exist in the project, and will be ignored.
    The target "_CollectPdbFiles" listed in an AfterTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (34,70)" does not exist in the project, and will be ignored.
    The target "_CollectMdbFiles" listed in a BeforeTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (41,38)" does not exist in the project, and will be ignored.
    The target "_CopyMdbFiles" listed in an AfterTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Common
    .targets\ImportAfter\Xamarin.Common.targets (41,71)" does not exist in the project, and will be ignored.
    Project "C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Result\Sloader.Result.csproj" on node 1 (Build target(s))
    .
    GenerateTargetFrameworkMonikerAttribute:
    Skipping target "GenerateTargetFrameworkMonikerAttribute" because all output files are up-to-date with respect to the i
    nput files.
    CoreCompile:
    Skipping target "CoreCompile" because all output files are up-to-date with respect to the input files.
    CopyFilesToOutputDirectory:
      Sloader.Result -> C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Result\bin\Release\Sloader.Result.dll
    Done Building Project "C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Result\Sloader.Result.csproj" (Build target
    (s)).
    
    
    Build succeeded.
        0 Warning(s)
        0 Error(s)
    
    Time Elapsed 00:00:00.24
    Attempting to build package from 'Sloader.Result.csproj'.
    MSBuild auto-detection: using msbuild version '14.0' from 'C:\Program Files (x86)\MSBuild\14.0\bin'.
    Packing files from 'C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Result\bin\Release'.
    Using 'Sloader.Result.nuspec' for metadata.
    Found packages.config. Using packages listed as dependencies
    Successfully created package 'C:\Users\Robert\Documents\GitHub\Sloader\artifacts\Sloader.Result.0.2.1.nupkg'.
    Microsoft (R) Build Engine version 14.0.25420.1
    Copyright (C) Microsoft Corporation. All rights reserved.
    
    Build started 2017-02-19 22:00:12.
    The target "_ConvertPdbFiles" listed in a BeforeTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (34,37)" does not exist in the project, and will be ignored.
    The target "_CollectPdbFiles" listed in an AfterTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (34,70)" does not exist in the project, and will be ignored.
    The target "_CollectMdbFiles" listed in a BeforeTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (41,38)" does not exist in the project, and will be ignored.
    The target "_CopyMdbFiles" listed in an AfterTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Common
    .targets\ImportAfter\Xamarin.Common.targets (41,71)" does not exist in the project, and will be ignored.
    The target "_ConvertPdbFiles" listed in a BeforeTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (34,37)" does not exist in the project, and will be ignored.
    The target "_CollectPdbFiles" listed in an AfterTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (34,70)" does not exist in the project, and will be ignored.
    The target "_CollectMdbFiles" listed in a BeforeTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (41,38)" does not exist in the project, and will be ignored.
    The target "_CopyMdbFiles" listed in an AfterTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Common
    .targets\ImportAfter\Xamarin.Common.targets (41,71)" does not exist in the project, and will be ignored.
    Project "C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Engine\Sloader.Engine.csproj" on node 1 (Build target(s))
    .
    Project "C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Engine\Sloader.Engine.csproj" (1) is building "C:\Users\R
    obert\Documents\GitHub\Sloader\src\Sloader.Config\Sloader.Config.csproj" (2) on node 1 (default targets).
    GenerateTargetFrameworkMonikerAttribute:
    Skipping target "GenerateTargetFrameworkMonikerAttribute" because all output files are up-to-date with respect to the i
    nput files.
    CoreCompile:
    Skipping target "CoreCompile" because all output files are up-to-date with respect to the input files.
    CopyFilesToOutputDirectory:
      Sloader.Config -> C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Config\bin\Release\Sloader.Config.dll
    Done Building Project "C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Config\Sloader.Config.csproj" (default targ
    ets).
    
    The target "_ConvertPdbFiles" listed in a BeforeTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (34,37)" does not exist in the project, and will be ignored.
    The target "_CollectPdbFiles" listed in an AfterTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (34,70)" does not exist in the project, and will be ignored.
    The target "_CollectMdbFiles" listed in a BeforeTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Com
    mon.targets\ImportAfter\Xamarin.Common.targets (41,38)" does not exist in the project, and will be ignored.
    The target "_CopyMdbFiles" listed in an AfterTargets attribute at "C:\Program Files (x86)\MSBuild\14.0\Microsoft.Common
    .targets\ImportAfter\Xamarin.Common.targets (41,71)" does not exist in the project, and will be ignored.
    Project "C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Engine\Sloader.Engine.csproj" (1) is building "C:\Users\R
    obert\Documents\GitHub\Sloader\src\Sloader.Result\Sloader.Result.csproj" (3) on node 1 (default targets).
    GenerateTargetFrameworkMonikerAttribute:
    Skipping target "GenerateTargetFrameworkMonikerAttribute" because all output files are up-to-date with respect to the i
    nput files.
    CoreCompile:
    Skipping target "CoreCompile" because all output files are up-to-date with respect to the input files.
    CopyFilesToOutputDirectory:
      Sloader.Result -> C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Result\bin\Release\Sloader.Result.dll
    Done Building Project "C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Result\Sloader.Result.csproj" (default targ
    ets).
    
    BclBuildEnsureBindingRedirects:
    Skipping target "BclBuildEnsureBindingRedirects" because all output files are up-to-date with respect to the input file
    s.
    GenerateTargetFrameworkMonikerAttribute:
    Skipping target "GenerateTargetFrameworkMonikerAttribute" because all output files are up-to-date with respect to the i
    nput files.
    CoreCompile:
    Skipping target "CoreCompile" because all output files are up-to-date with respect to the input files.
    _CopyAppConfigFile:
    Skipping target "_CopyAppConfigFile" because all output files are up-to-date with respect to the input files.
    CopyFilesToOutputDirectory:
      Sloader.Engine -> C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Engine\bin\Release\Sloader.Engine.dll
    Done Building Project "C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Engine\Sloader.Engine.csproj" (Build target
    (s)).
    
    
    Build succeeded.
        0 Warning(s)
        0 Error(s)
    
    Time Elapsed 00:00:00.54
    Attempting to build package from 'Sloader.Engine.csproj'.
    MSBuild auto-detection: using msbuild version '14.0' from 'C:\Program Files (x86)\MSBuild\14.0\bin'.
    Packing files from 'C:\Users\Robert\Documents\GitHub\Sloader\src\Sloader.Engine\bin\Release'.
    Using 'Sloader.Engine.nuspec' for metadata.
    Found packages.config. Using packages listed as dependencies
    Successfully created package 'C:\Users\Robert\Documents\GitHub\Sloader\artifacts\Sloader.Engine.0.2.1.nupkg'.
    Finished executing task: BuildPackages
    
    Task                          Duration
    --------------------------------------------------
    Clean                         00:00:00.1083837
    Restore-NuGet-Packages        00:00:00.7808530
    BuildTests                    00:00:02.6296445
    RunTests                      00:00:05.9397822
    BuildPackages                 00:00:05.2679058
    --------------------------------------------------
    Total:                        00:00:14.7265692
