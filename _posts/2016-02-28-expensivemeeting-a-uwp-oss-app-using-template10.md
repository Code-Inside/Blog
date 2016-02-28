---
layout: post
title: "ExpensiveMeeting - a Universal Windows Platform OSS app using Template10"
description: "I build a small UWP app to calculate meeting costs - just for fun and its all OSS and live on GitHub. In this post I will just walk over the important technical details."
date: 2016-02-28 16:15
author: Robert Muehsig
tags: [UWP, OSS, Template10]
language: en
---
{% include JB/setup %}

## ExpensiveMeeting 

The app - which is just a fun project and shouldn't be taken too seriously -  is like a stopwatch for meetings. But instead of the pure time it shows you also the burned money for your meeting, because time is money, right?

![x]({{BASE_PATH}}/assets/md-images/2016-02-28/app.png "ExpensiveMeeting app")

Don't worry: The app is free and no ads are shown. 

__[Windows Store Download Link](https://www.microsoft.com/store/apps/9NBLGGH5PVW9)__

## Behind the scenes: Universal Windows Platfrom (UWP)

The app itself is a UWP app, which means it runs on Windows 10, Windows IoT, Windows Mobile 10 (or is it Phone?) and maybe in the future on Xbox One. To see the app running on my phone, without touching the code at all, was pure fun. I really like the UWP approach.

## Behind the scenes: Template10

Starting from scratch can be fun, but to shorten the development time I used the nice __[Template10](aka.ms/template10)__ template, which gives me the typical hamburger app layout. The project can be found on [GitHub](https://github.com/Windows-XAML/Template10) and has a very active community.

## Behind the scenes: All Code on GitHub

I decided to work in the open on __[GitHub](https://github.com/Code-Inside/ExpensiveMeeting)__, so if you are interested on the actual code, just take a look and do whatever you want to do. 

If you have ideas or found bugs I would appreciate your help - just create an __[issue](https://github.com/Code-Inside/ExpensiveMeeting/issues)__ or send a pull request.
