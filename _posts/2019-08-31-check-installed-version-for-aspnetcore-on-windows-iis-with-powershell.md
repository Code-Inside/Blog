---
layout: post
title: "Check installed version for ASP.NET Core on Windows IIS with Powershell"
description: "... can my ASP.NET Core application run on this Windows Server?"
date: 2019-08-31 23:45
author: Robert Muehsig
tags: [Windows Server, .NET Core, IIS]
language: en
---

{% include JB/setup %}

# The problem

Let's say you have a ASP.NET Core application __without__ the bundled ASP.NET Core runtime (e.g. to keep the download as small as possible) and you want to run your ASP.NET Core application on a Windows Server hosted by IIS.

# General approach

The general approach is the following: Install the [.NET Core hosting bundle](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/index?view=aspnetcore-2.2#install-the-net-core-windows-server-hosting-bundle) and you are done. 

Each .NET Core Runtime (and there are quite a bunch of [them](https://dotnet.microsoft.com/download/dotnet-core/2.2)) is backward compatible (at least the 2.X runtimes), so if you have installed 2.2.6, your app (created while using the .NET runtime 2.2.1), still runs. 

# Why check the minimum version?

Well... in theory the app itself (at least for .NET Core 2.X applications) may run under runtime versions, but each version might fix something and to keep things safe it is a good idea to enforce security updates.

# Check for minimum requirement

I stumpled upon this [Stackoverflow question/answer](https://stackoverflow.com/questions/38567796/how-to-determine-if-asp-net-core-has-been-installed-on-a-windows-server) and enhanced the script, because that version only tells you "ASP.NET Core seems to be installed".

    $DotNetCoreMinimumRuntimeVersion = [System.Version]::Parse("2.2.5.0")
    
    $DotNETCoreUpdatesPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Updates\.NET Core"
    $DotNetCoreItems = Get-Item -ErrorAction Stop -Path $DotNETCoreUpdatesPath
    $MinimumDotNetCoreRuntimeInstalled = $False
    
    $DotNetCoreItems.GetSubKeyNames() | Where { $_ -Match "Microsoft .NET Core.*Windows Server Hosting" } | ForEach-Object {
    
                    $registryKeyPath = Get-Item -Path "$DotNETCoreUpdatesPath\$_"
    
                    $dotNetCoreRuntimeVersion = $registryKeyPath.GetValue("PackageVersion")
    
                    $dotNetCoreRuntimeVersionCompare = [System.Version]::Parse($dotNetCoreRuntimeVersion)
    
                    if($dotNetCoreRuntimeVersionCompare -ge $DotNetCoreMinimumRuntimeVersion) {
                                    Write-Host "The host has installed the following .NET Core Runtime: $_ (MinimumVersion requirement: $DotNetCoreMinimumRuntimeVersion)"
                                    $MinimumDotNetCoreRuntimeInstalled = $True
                    }
    }
    
    if ($MinimumDotNetCoreRuntimeInstalled -eq $False) {
                    Write-host ".NET Core Runtime (MiniumVersion $DotNetCoreMinimumRuntimeVersion) is required." -foreground Red
                    exit
    }

The "most" interesting part is the first line, where we set the minimum required version. 

If you have installed a version of the .NET Core runtime on Windows, this information will end up in the registry like this:

![x]({{BASE_PATH}}/assets/md-images/2019-08-31/registry.png "Registry view")
	
Now we just need to compare the installed version with the existing version and know if we are good to go.

Hope this helps!
