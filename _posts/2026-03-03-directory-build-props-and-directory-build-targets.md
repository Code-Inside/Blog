---
layout: post
title: "Taming Big .NET Solutions: Centralizing Build Settings and NuGet Versions"
description: "Learn how to simplify large .NET solutions by centralizing build settings, metadata, and NuGet package versions using Directory.Build.props, Directory.Build.targets, and Directory.Packages.props. "
date: 2026-03-03 23:59
author: Robert Muehsig
tags: [NuGet, .NET, MSBuild]
language: en
---

{% include JB/setup %}

Many .NET projects start as a small prototype, but after a few iterations they grow into a sizable Visual Studio solution with dozens — sometimes hundreds — of projects.
At this point, managing common project settings becomes painful:

A NuGet package needs an update → you touch multiple project files.
A new .NET version is released → update every project manually.
Metadata like company name or product name starts to drift across projects.

If this sounds familiar, this guide is for you.

## The Root of the Problem: The .csproj File

```
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <LangVersion>13.0</LangVersion>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
    <AssemblyVersion>1.0.0.0</AssemblyVersion>
    <FileVersion>1.0.0.0</FileVersion>
    <InformationalVersion>1.0.0.0</InformationalVersion>
    <Company>Cool Company</Company>
    <Product>Cool Product</Product>
    <Copyright>...</Copyright>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.6.2" />
    <PackageReference Include="Microsoft.Extensions.Logging.Abstractions" Version="8.0.3" />
  </ItemGroup>
</Project>
```

Common pain points:

- Hard-coded compiler settings (target framework, language version, nullable settings).
- Metadata drift (company, product, copyright).
- NuGet versions spread across all projects.

Luckily, .NET provides clean solutions using:
**Directory.Build.props**, **Directory.Build.targets**, and **Directory.Packages.props**.

## Directory.Build.props

This file is loaded before the build starts and allows you to define default settings for all projects in the solution.
Values can still be overridden inside individual .csproj files.

Example:

```
<Project>
  <PropertyGroup>
    <LangVersion>latest</LangVersion>
    <TreatWarningsAsErrors>true</TreatWarningsAsErrors>
    <Nullable>enable</Nullable>
    <AssemblyVersion>1.0.0.0</AssemblyVersion>
    <FileVersion>1.0.0.0</FileVersion>
    <InformationalVersion>1.0.0.0</InformationalVersion>
    <Company>Cool Company</Company>
    <Product>Cool Product</Product>
    <Copyright>...</Copyright>
  </PropertyGroup>
  <!-- or if you want to set a global output directory -->

  <PropertyGroup>
    <OutDir>C:\output\$(MSBuildProjectName)</OutDir>
  </PropertyGroup>

</Project>
```

**How MSBuild Locates Directory.Build.props**

MSBuild [searches the directory tree upwards](https://learn.microsoft.com/en-us/visualstudio/msbuild/customize-by-directory) from the project location until it finds a file with that name.
It stops at the first match, unless you explicitly chain them, which can be useful - depending on your directory structure.

## Directory.Build.targets

While .props files provide early defaults, .targets files are loaded later, making them ideal for:

- Extending build steps
- Overriding MSBuild targets
- Inserting Before*/After* hooks
- Running custom build logic

Example:

```
<Target Name="BeforePack">
  <Message Text="Preparing NuGet packaging for $(MSBuildProjectName)" />
</Target>
```

**Real-world Example: Muting Warnings:**

When you build older branches of a big solution, NuGet may raise vulnerability warnings (NU1901–NU1904).
If the solution uses TreatWarningsAsErrors=true, the build will fail — even though the old state is intentional.
Solution using Directory.Build.targets:

```
<Project>
  <PropertyGroup>
    <!-- Mute all vulnerabilities and don't escalate warnings as errors -->
    <!-- Uncomment these lines if you need to build an older version (with open vulnerabilities!):
      <TreatWarningsAsErrors>false</TreatWarningsAsErrors>
      <NoWarn>NU1901, NU1902, NU1903, NU1904</NoWarn>
    -->
  </PropertyGroup>
</Project>
```

## Directory.Packages.props

This file might be the most important - this enabled [Central NuGet Package Management](https://learn.microsoft.com/en-us/nuget/consume-packages/central-package-management).

The idea is, that you add all your needed NuGet packages in a `Directory.Packages.props` file like this:

```
<Project>
  <PropertyGroup>
    <ManagePackageVersionsCentrally>true</ManagePackageVersionsCentrally>
  </PropertyGroup>

  <ItemGroup>
    <PackageVersion Include="Newtonsoft.Json" Version="13.0.1" />
  </ItemGroup>
</Project>
```

Inside your actual `myProject.csproj` you just reference the package, but **without the actual version number**!

```
...

<ItemGroup>
  <PackageReference Include="Newtonsoft.Json" />
</ItemGroup>
```

This way you have one central file to update your NuGet package and don't need to scan all existing `.csproj`-files. This way, you update a package version **once**, and every project in your solution automatically picks it up.

**Note:** You can add multiple `Directory.Packages.props` in your directory tree.

**How to deal with exceptions - e.g. one project needs an older/newer package?**

If you have this scenario, you always can define an `VersionOverride` inside your `.csproj` like this:

```
<PackageReference Include="Microsoft.Extensions.Logging" VersionOverride="9.0.6" />
```

## Tooling

The Visual Studio UI is work with the `Directory.Packages.props` as well. If you want to start, just try these `.NET CLI` helper:

```
dotnet new buildprops
dotnet new buildtargets
dotnet new packagesprops
```

There is also a [tool](https://github.com/Webreaper/CentralisedPackageConverter) to convert an existing solution automatically using:

```
dotnet tool install CentralisedPackageConverter --global
central-pkg-converter /SomeAwesomeProject
```

From my experience: In our complex solution it worked `ok-ish`. 80% was migrated, not sure what the problem was. I guess nowadays you can assign an AI to write this file :)

## Summary

With just three small files, even a complex multi-project .NET solution becomes cleaner and easier to maintain:

- **Directory.Build.props:** Defines shared defaults like language version, company name, or build settings.
- **Directory.Build.targets:** Extends and customizes the build pipeline — ideal for automation and global rules.
- **Directory.Packages.props:** Centralizes NuGet version management and prevents version drift across projects.

The migration effort is small, but the payoff in structure and maintainability is huge.

Hope this helps!
