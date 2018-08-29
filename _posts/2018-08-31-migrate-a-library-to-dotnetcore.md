---
layout: post
title: "Migrate a .NET library to .NET Core / .NET Standard 2.0"
description: "It's about time to build .NET Standard 2.0 libs!"
date: 2018-08-31 23:45
author: Robert Muehsig
tags: [.NET Standard, .NET Core]
language: en
---
{% include JB/setup %}

I have a small spare time project called __[Sloader](https://github.com/Code-Inside/Sloader/)__ and I recently moved the code base to .NET Standard 2.0. This blogpost covers the most interesting details. 

# Uhm... wait... what is .NET Standard?
 
If you have been living under a rock in the past year: __[.NET Standard](https://docs.microsoft.com/en-us/dotnet/standard/net-standard)__ is a kind of "contract" that the library can run under all .NET implementations, e.g. .NET Framework and .NET Core. 
But hold on: The library might also run under Unity, Xamarin and Mono (and future .NET implementations that support this contract - that's why it is called "Standard").

# Sloader - before .NET Standard

Back to my spare time project: 

Sloader consists of three projects (Config/Result/Engine) and targeted the full .NET Framework. All projects were typical library projects. All components were tested with xUnit and builded via Cake. The configuration is using YAML and the main work is done via the HttpClient.

The library is a not too trivial example, but in general it had pretty low requirements.

# Sloader - moving to .NET Standard 2.0

The blogpost from Daniel Crabtee __[Upgrading to .NET Core and .NET Standard Made Easy](https://www.danielcrabtree.com/blog/314/upgrading-to-net-core-and-net-standard-made-easy)__ was a great resource and if you want to migrate you should check his blogpost.

The best advice from the blogpost: __Just create new .NET Standard projects and xcopy your files to the new projects.__ 

To migrate the projects to .NET Standard I really just needed to deleted the old .csproj files and copied everything into new .NET Standard library projects.

After some finetuning and NuGet package reference updates everything compilied.

This [GitHub PR](https://github.com/Code-Inside/Sloader/pull/35/files) shows the result of the migration.

# Problems & Aftermath

In my library I still used the old ConfigurationManager class (referenced via the official NuGet package). This API is not supported on every platform (e.g. Azure Functions), so I needed to tweak those code parts. 

Everthing else "just" worked and it was a great experience. I tried the same thing with .NET Core 1.0 and it failed horrible, but this time the migration was more or less painless. 

# .NET Portability Analyzer

If you are not sure if your code works under .NET Standard or Core just install the [.NET Portability Analyzer](https://marketplace.visualstudio.com/items?itemName=ConnieYau.NETPortabilityAnalyzer). 

This handy tool will give you an overwhy which parts might run without problems under .NET Standard or .NET Core.

