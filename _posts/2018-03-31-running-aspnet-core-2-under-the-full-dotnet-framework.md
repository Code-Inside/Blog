---
layout: post
title: "Did you know that you can run ASP.NET Core 2 under the full framework?"
description: "Running Cross-Platform is great, but if you need the full framework its quite easy to run a ASP.NET Core 2 application under the full framework."
date: 2018-03-31 23:35
author: Robert Muehsig
tags: [ASP.NET Core, Full Framework]
language: en
---
{% include JB/setup %}

*This post might be obvious for some, but I really struggled a couple of month ago and I'm not sure if a Visual Studio Update fixed the problem for me or if I was just blind...*

# The default way: Running .NET Core

*AFAIK the framework dropdown in the normal Visual Studio project template selector (the first window) is not important  and doesn't matter anyway for .NET Core related projects.*

When you create a new ASP.NET Core application you will see something like this: 

![x]({{BASE_PATH}}/assets/md-images/2018-03-31/default.png "Default Framework selection")

The important part for the framework selection can be found in the upper left corner: .NET Core is currently selected.

When you continue your .csproj file should show something like this:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>netcoreapp2.0</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore.All" Version="2.0.5" />
  </ItemGroup>

  <ItemGroup>
    <DotNetCliToolReference Include="Microsoft.VisualStudio.Web.CodeGeneration.Tools" Version="2.0.2" />
  </ItemGroup>

</Project>
```

# Running the full framework:

I had some trouble to find the option, but it's really obvious. You just have to adjust the selected framework in the second window:

![x]({{BASE_PATH}}/assets/md-images/2018-03-31/full.png ".NET Framework selected")

After that your .csproj has the needed configuration.

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net461</TargetFramework>
  </PropertyGroup>
  
  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore" Version="2.0.1" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc" Version="2.0.2" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc.Razor.ViewCompilation" Version="2.0.2" PrivateAssets="All" />
    <PackageReference Include="Microsoft.AspNetCore.StaticFiles" Version="2.0.1" />
    <PackageReference Include="Microsoft.VisualStudio.Web.BrowserLink" Version="2.0.1" />
  </ItemGroup>
  
  <ItemGroup>
    <DotNetCliToolReference Include="Microsoft.VisualStudio.Web.CodeGeneration.Tools" Version="2.0.2" />
  </ItemGroup>
</Project>
```

The biggest change: When you run under the full .NET Framework you can't use the "All"-Meta-Package, because with version 2.0 the package is still .NET Core only, and need to point to each package manually. 

Easy, right?

Be aware: Maybe with ASP.NET Core 2.1 the Meta-Package story with the full framework [might get easier](https://github.com/aspnet/Announcements/issues/287).

*I'm still not sure why I struggled to find this option... Hope this helps!*




