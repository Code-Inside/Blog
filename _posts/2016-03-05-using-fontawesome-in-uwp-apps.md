---
layout: post
title: "Using FontAwesome in UWP apps"
description: "I already wrote a blogpost about how to use FontAwesome in an WPF project and how to use custom fonts in UWP apps. In this short post I will introduce you to the FontAwesome.UWP NuGet package."
date: 2016-03-05 23:55
author: Robert Muehsig
tags: [OSS, FontAwesome, UWP]
language: en
---
{% include JB/setup %}

## FontAwesome in WPF and Fonts in UWP

I blogged about [how to use FontAwesome in WPF](http://blog.codeinside.eu/2015/01/07/using-fontawesome-with-wpf/) last year and wrote a short blogpost about the nice [FontIcon](http://blog.codeinside.eu/2016/01/31/working-with-fonticons-in-uwp/) class in UWP. 
With the help of the FontIcon class I could include the FontAwesome glyphs, but working with the unicodes is not very dev friendly.

## Bringing FontAwesome.WPF to the UWP universe - OSS rocks!

The goal was pretty clear: I would like to have excellent FontAwesome.WPF NuGet package working on UWP. 
So I created an issue on the [FontAwesome.WPF GitHub repo](https://github.com/charri/Font-Awesome-WPF/issues/230) and some contributions later the [FontAwesome.UWP NuGet package](http://www.nuget.org/packages/FontAwesome.UWP/) was born.

__Impartant: Thanks to everyone who was involved!__

![x]({{BASE_PATH}}/assets/md-images/2016-03-05/nuget.png "FontAwesome.UWP NuGet package")

## Using FontAwesome in UWP... 

As you might imaging - the usage now is pretty easy after including the FontAwesome.UWP NuGet package.

    <Page
        x:Class="UwpDemo.MainPage"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:local="using:UwpDemo"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:fa="using:FontAwesome.UWP"
        mc:Ignorable="d">
    
        <Grid Background="{ThemeResource ApplicationPageBackgroundThemeBrush}">
            <fa:FontAwesome Icon="Flag" FontSize="90" Foreground="Chartreuse" HorizontalAlignment="Center" />
        </Grid>
    </Page>

Result:

![x]({{BASE_PATH}}/assets/md-images/2016-03-05/demo.png "FontAwesome on UWP")

I would say: Pretty nice and it was a good collaboration - big thanks to [Thomas Charriere](https://github.com/charri), who is the maintainer behind the project.

Hope this helps!
