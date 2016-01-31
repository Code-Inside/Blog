---
layout: post
title: "Working with FontIcons in UWP"
description: "Since FontAwesome FontIcons are everywhere. In this post I will show the very basic usage of the FontIcon class in UWP."
date: 2016-01-31 20:30
author: Robert Muehsig
tags: [UWP, FontAwesome, Fonts, FontIcon]
language: en
---
{% include JB/setup %}

## FontIcons in UWP

Microsoft ships one builtin UWP (Universal Windows Platform) [__SymbolIcon__](https://msdn.microsoft.com/EN-US/library/windows/apps/windows.ui.xaml.controls.symbol.aspx) class.
The good thing about such FontIcons is, that you can scale and change the appearances very nice and don't need a bunch of image assets for your icons. 
The down side is, that those icons are just a font... so no multicolor option.

The builtin SymbolIcon usage is pretty easy:

    <SymbolIcon Symbol="Accept" />

## Using FontIcon to serve other font e.g. FontAwesome

Microsoft ships another simple class, the [__FontIcon__](https://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.xaml.controls.fonticon.glyph) class.
The usage is pretty simple if you know the correct syntax:

    <FontIcon FontFamily="./fontawesome.otf#FontAwesome" Glyph="&#xf0b2;"></FontIcon>

The Glyph-Property is the HexCode for the target char. 

Pretty important, but I'm not a Font-Expert, so maybe this is "normal"
- The #FontAwesome must be set.
- In XAML the Glyph must be in this form

    "&#xf0b2;"

- From Code, the value must be unicode, e.g. 

    Test.Glyph = "\uf0b2";

And of course, the font must be included in the project as Resource.

## Result

The result is hopefully that you see the correct icon... right?

BTW, we try to bring [FontAwesome to UWP](https://github.com/charri/Font-Awesome-WPF/issues/23) with a simple NuGet package.

And thanks to [Alexander Witkowski](https://twitter.com/Alex_Witkowski/status/692134058051178502) for the suggestion of the FontIcon class - I didn't know that this is part of the SDK.
