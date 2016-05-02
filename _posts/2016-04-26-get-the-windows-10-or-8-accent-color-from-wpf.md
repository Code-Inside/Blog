---
layout: post
title: "Get the Windows 10 or 8 accent color in WPF"
description: "With Windows 8 and 10 users can choose a 'accent color' and this blogpost will show you how you can use the color in your WPF application."
date: 2016-04-26 23:55
author: Robert Muehsig
tags: [Windows, WPF]
language: en
---
{% include JB/setup %}

![x]({{BASE_PATH}}/assets/md-images/2016-04-26/windows-accent.png "Windows Color Options").

## Windows Accent Color

Since Windows 8 users can choose a system accent color. The color can be seen on the window borders of the default apps and it can be pretty easy be used inside a [UWP App](http://firstfloorsoftware.com/news/win10-dev-using-systemaccentcolor).

## How to get the accent color in WPF?

__Option 1: SystemParameters.WindowGlassBrush - not 100% the same color__

As far as I know there are several ways to get the color code, one easy but __not 100% correct__ way is to use the [SystemParameters.WindowGlassBrush](https://msdn.microsoft.com/en-us/library/system.windows.systemparameters.windowglassbrush.aspx) property that was introduced in .NET 4.5.

Sadly, the color is not 100% correct - I have no idea where this "similar", but not identical color is used and why the API is returning this color.

It seems this is just a wrapper around the __undocumented__ DwmGetColorizationParameters Win32 API.

__Option 2: GetImmersiveColorFromColorSetEx__

I found this solution [here](https://gist.github.com/paulcbetts/3c6aedc9f0cd39a77c37), which is just a wrapper around the __GetImmersiveColorFromColorSetEx__ Win32 API.

__Option 3: Registry, DwmGetColorizationParameters__

The last option would be to read the Registry values - I found some hints on this [site](http://pinvoke.net/default.aspx/dwmapi/DwmGetColorizationParameters.html), but I wouldn't recommend it, because it is more or less undocumented and might break in the future. So we will use option 1 or 2.

__Usage:__

The usage of both options is pretty easy (at least with the option 2 code provided) :

```cs
    // https://gist.github.com/paulcbetts/3c6aedc9f0cd39a77c37
    var accentColor = new SolidColorBrush(AccentColorSet.ActiveSet["SystemAccent"]);
    this.Code.Background = accentColor;
    this.Code.Text = "AccentColorSet Immersive 'SystemAccent' " + accentColor.Color.ToString();

    // Available in .NET 4.5
    this.SystemProperties.Background = SystemParameters.WindowGlassBrush;
    this.SystemProperties.Text = "SystemParameters.WindowGlassBrush " + ((SolidColorBrush)SystemParameters.WindowGlassBrush).Color.ToString();
```

__Result:__

![x]({{BASE_PATH}}/assets/md-images/2016-04-26/wpf-result.png "WPF result").

As you can see, the lower color does match the border color instead of the first option. Crazy, right? ¯\\\_(ツ)\_/¯

The full code is on [__GitHub__](https://github.com/Code-Inside/Samples/tree/master/2016/WpfGetWindows10AccentColor)

Hope this helps.


