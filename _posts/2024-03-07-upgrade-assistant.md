---
layout: post
title: ".NET Upgrade Assistant"
description: "If you still have to deal with .NET Framework Projects and want to upgrade..."
date: 2024-03-07 23:59
author: Robert Muehsig
tags: [.NET Framework, .NET Core]
language: en
---

{% include JB/setup %}

For those facing the challenge of migrating their .NET Framework-based application to the modern .NET stack, Microsoft's ["Upgrade Assistant"](https://dotnet.microsoft.com/en-us/platform/upgrade-assistant) is highly recommended:

<iframe width="660" height="371" src="https://www.youtube.com/embed/3mPb4KAbz4Y" title="Upgrade Your .NET Projects Faster with Visual Studio" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

# What is the "Upgrade Assistant"?

The "Upgrade Assistant" is a tool that can integrate into Visual Studio or be accessed [via CLI](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview?WT.mc_id=dotnet-35129-website#upgrade-with-the-cli-tool).
If you install the [__extension__](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.upgradeassistant) for Visual Studio you will have a new option "Upgrade project" available in your Solution Explorer.

# .NET Framework to "new" and more...

Its main use case is upgrading .NET Framework-based WPF, WinForms, class libraries, or web applications to the newest .NET version. Besides this, the tool offers some other migration paths as well, e.g. from UWP to WinUI 3.

You even can use the tool to migrate from an older .NET Core version to a newer version (but - to be honest: those upgrades are quite easy in contrast to the .NET Framework to .NET Core migration).

Depending on the project type, the assistant allows for an "In-Place Upgrade," "Side-by-Side," or "Side-by-Side Incremental" upgrade.

- "In-Place Upgrade" means that the existing code is directly modified.
- "Side-by-Side" means that a new project is created and migration to the latest version is based on a copy.
- "Side-by-Side Incremental," to my knowledge, is only available for ASP.NET web applications. Here, a new .NET Core project is added in parallel, and a sort of "bridge" is built in the original .NET project. This seems to me to be clever on the one hand but also very risky on the other.

You can see those upgrade methods in the video above.

# Is it good?

[We](https://primesoft-group.com/en/) have used (or at least tested) the Assistant for upgrading WPF and class libraries to .NET Core and it helps to identify problems (e.g. if a NuGet package or any "old" framework code is not compatible).
My verdict: If you need to upgrade your code, you should give it a try.
In a more complex code base, it will sometimes mess with the code, but it still helps to give directions.

Hope this helps!