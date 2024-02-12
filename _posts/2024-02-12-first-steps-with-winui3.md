---
layout: post
title: "First steps with WinUI 3"
description: "Learn how to get started with WinUI 3 in this blogpost..."
date: 2024-02-17 23:55
author: Robert Muehsig
tags: [WinUI 3, Windows]
language: en
---

{% include JB/setup %}

Developing desktop apps __for__ Windows is quite complex in 2024. There are some "old school" frameworks like WPF or WinForms (or even older stuff) and there is this confusing UWP (but I think it's dead). 
The "modern stack" seems to be `WinUI` - so let's take a look.

![x]({{BASE_PATH}}/assets/md-images/2024-02-12/winui.png "WinUI")

*See [here](https://learn.microsoft.com/en-us/windows/apps/develop/)*

# What is WinUI? 

WinUI is the "modern" version of WPF without the (dumb?) constraints from UWP. You can of course use your typical "Windows" programming languages (like C# or C++).

If you heard of UWP. The "Universal Windows Platform" was a good idea but failed, because - at least from my limited testing - the platform was very strict and you couldn't do the same stuff that you can do with WPF/WinForms. 

WinUI 1 and 2 were targeted at UWP (if I remember correctly) and with WinUI 3 Microsoft decided to lift those UWP constraints and with it we get a modern desktop stack based on the "known" XAML.

In summary:

WinUI 3 apps can be used for apps that run on Windows 11 and Windows 10 and can be distributed via the Microsoft Store and you can do the same crazy stuff that you love about WPF/WinForms.

# Does anybody outside of Microsoft use WinUI?

WinUI is used in Windows 11, e.g. the settings or the new explorer - which is nice, but it would be good, if we found a non-Microsoft app that uses this tech, right?

Thankfully last week Apple decided to release [Apple Music](https://apps.microsoft.com/detail/9PFHDD62MXS1) (and [other apps](https://twitter.com/OrderByAsync/status/1755598050641526902))as a native Windows app and it seems (this is not confirmed by Microsoft or Apple) like it was written with WinUI:

![x]({{BASE_PATH}}/assets/md-images/2024-02-12/applemusic.png "Apple Music")

If Apple uses this tech, it seems "safe enough" for some exploration.

# How to get started?

You will need [Visual Studio 2022](https://visualstudio.microsoft.com/vs/). Be aware, that even if you check all those desktop related workloads in the installer the WinUI 3 templates __are still missing__.

![x]({{BASE_PATH}}/assets/md-images/2024-02-12/vsinstall.png "Visual Studio Workloads")

For the WinUI 3 templates you will need to install the __[Windows App SDK](https://learn.microsoft.com/en-us/windows/apps/windows-app-sdk/)__.

# Visual Studio Templates

After the Windows App SDK is installed we finally have the templates in Visual Studio:

![x]({{BASE_PATH}}/assets/md-images/2024-02-12/vstemplates.png "Visual Studio Templates")

The default `Blank App, Packaged (WinUI 3 in Desktop)` is... well... quite blank:

![x]({{BASE_PATH}}/assets/md-images/2024-02-12/solution.png "Visual Studio Solution")

If you start the application, you will see this:

![x]({{BASE_PATH}}/assets/md-images/2024-02-12/startapp.png "Blank Application")

# Packaged vs. Unpacked

If you check the toolbar, you will notice the `App 6 (Package)` debug button. `Packaged Apps` can access some Windows APIs (e.g. custom context menu extensions) that `Unpackaged Apps` can't. `Unpackaged Apps` on the other hand act like WPF apps - e.g. they have a "normal" `.exe` and can be distributed like any `.exe`-file. 

[This documentation page](https://learn.microsoft.com/en-us/windows/apps/get-started/intro-pack-dep-proc#packaged-or-unpackaged) should cover this topic.

Let's say we want to have a "proper" `myApp.exe` app, then the `Unpackaged App` is the way to go. If you choose the `App 6 (Unpackaged)` debug option you might see this weird error:

```
XamlCheckProcessRequirements();

Exception Unhandled:
System.DllNotFoundException: 'Unable to load DLL 'Microsoft.ui.xaml.dll' or one of its dependencies: The specified module could not be found. (0x8007007E)'
```

To fix this, you will need to add this to the `.csproj`:

```
	<PropertyGroup>
		...
		<WindowsPackageType>None</WindowsPackageType>
        ...
	</PropertyGroup>
```

After that the debug button should start the application and you should be able to start the `.exe`.

# Samples

Ok, the most basic steps are done - now what? 

To get a feeling about what is possible and what not, you should install the [WinUI 3 Gallery](https://apps.microsoft.com/detail/9P3JFPWWDZRC?) app.

![x]({{BASE_PATH}}/assets/md-images/2024-02-12/winuisample.png "WinUI 3 Gallery")

This application should give a some guidiance.

Hope this helps!

*Note: I'm a beginner with WinUI 3 and just want to show other people the first few steps - if I miss something, just write me a comment! Thanks <3*

