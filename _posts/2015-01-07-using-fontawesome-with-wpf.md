---
layout: post
title: "Using FontAwesome with WPF"
description: "How to get the beloved Icon-Font inside your WPF App."
date: 2015-01-07 00:50
author: robert.muehsig
tags: [FontAwesome, WPF]
language: en
---
{% include JB/setup %}

From the FontAwesome Project Description:

"Font Awesome gives you scalable vector icons that can instantly be customized — size, color, drop shadow, and anything that can be done with the power of CSS." 

![x]({{BASE_PATH}}/assets/md-images/2015-01-07/fontawesome.png "FontAwesome")

Sounds great, right? But can we use FontAwesome in WPF? __Absolutely__! 

## The manual way:
FontAwesome is just a font, which can be shipped within your app. The basics are described __[here](http://stackoverflow.com/questions/23108181/changing-font-icon-in-wpf-using-font-awesome)__.

## The NuGet way:
Two months ago [Tommy Charri](https://github.com/charri) created the __[FontAwesome.WPF NuGet Package](http://www.nuget.org/packages/FontAwesome.WPF/)__. The source code can be found on [GitHub](https://github.com/charri/Font-Awesome-WPF).

The NuGet Library looks really good in my opinion, so the rest of this blogpost we will take a deeper look at it.

## A look at FontAwesome.WPF

As showed in the [ReadMe](https://github.com/charri/Font-Awesome-WPF) of the project the use of FontAwesome with this library is really easy:

    <Window x:Class="Example.FontAwesome.WPF.Single"
            xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
            xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
            xmlns:fa="clr-namespace:FontAwesome.WPF;assembly=FontAwesome.WPF"
            Title="Single" Height="300" Width="300">
        <Grid  Margin="20">
            <fa:ImageAwesome Icon="Flag" VerticalAlignment="Center" HorizontalAlignment="Center" />
        </Grid>
    </Window>

The library contains a __ImageAwesome__, which is based on the Image Control, and a __FontAwesome__ element, which is based on the normal TextBlock control.

The GitHub repository contains also a full example project - with all FontAwesome Icons:

![x]({{BASE_PATH}}/assets/md-images/2015-01-07/wpfexample.png "WPF Example")

As you might expect, you can combine the FontAwesome elements with any Animation or Transformation from WPF:

![x]({{BASE_PATH}}/assets/md-images/2015-01-07/animation.gif "Animations and Transformations")

Currently the animation is not part of the offical example , but I created a [Pull Request](https://github.com/charri/Font-Awesome-WPF/pull/1).  __Update: My Animation-Example is now part of the "official" example.__ I tried my best with my poor XAML skills, but this is more or less my animation example:

    <Window x:Class="Example.FontAwesome.WPF.SingleRotating"
            xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
            xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
            xmlns:fa="clr-namespace:FontAwesome.WPF;assembly=FontAwesome.WPF"
            Title="SingleRotating" Height="300" Width="300">
        <Grid  Margin="20">
            <fa:ImageAwesome RenderTransformOrigin="0.5, 0.5" Icon="RotateRight" VerticalAlignment="Center" HorizontalAlignment="Center">
                <fa:ImageAwesome.RenderTransform>
                    <RotateTransform/>
                </fa:ImageAwesome.RenderTransform>
                <fa:ImageAwesome.Triggers>
                    <EventTrigger RoutedEvent="Loaded">
                        <BeginStoryboard>
                            <Storyboard>
                                <ColorAnimation Storyboard.TargetProperty="Foreground.Color"
                                                From="Black"
                                                To="Yellow"              
                                                Duration="0:0:10.0"
                                                AutoReverse="True"/>
                                <DoubleAnimation Storyboard.TargetProperty="(fa:ImageAwesome.RenderTransform).(RotateTransform.Angle)"
                                                 To="360"
                                                 Duration="0:0:5"
                                                 RepeatBehavior="Forever"/>
                            </Storyboard>
                        </BeginStoryboard>
                    </EventTrigger>
                </fa:ImageAwesome.Triggers>
            </fa:ImageAwesome>
        </Grid>
    </Window>

Thanks Tommy for this awesome [NuGet package](http://www.nuget.org/packages/FontAwesome.WPF/)!
   
Hope this helps and happy new Year!
