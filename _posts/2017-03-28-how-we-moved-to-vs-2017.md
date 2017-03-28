---
layout: post
title: "How we moved to Visual Studio 2017"
description: "Luckily this is just a short recap post how we moved successfully to Visual Studio 2017"
date: 2017-03-27 23:45
author: Robert Muehsig
tags: [Visual Studio 2017]
language: en
---
{% include JB/setup %}

![x]({{BASE_PATH}}/assets/md-images/2017-03-28/vs.png "VS 2017 installer")

Visual Studio 2017 has arrived and because of .NET Core and other goodies we wanted to switch fast to the newest release with our product [OneOffixx](http://oneoffixx.com/).

## Company & Product Environment

In our solution we use some VC++ projects (just for Office Development & building a .NET shim), Windows Installer XML & many C# projects for desktop or ASP.NET stuff.

Our builds are scripted with __[CAKE](http://cakebuild.net)__ (see here for some more blogposts about [CAKE}(https://blog.codeinside.eu/2017/02/13/create-nuget-packages-with-cake/) and us the TFS vNext Build to orchestrate everything.

## Step 1: Update the Development Workstations

The first step was to update my local dev enviroment and install Visual Studio 2017.

After the installation I started VS and opened our solution and because we have some WIX projects we needed the most recent __[Wix 3.11 toolset & the VS 2017 extension](http://wixtoolset.org/releases/)__.

## Step 2: VC++ update

We wanted a clean VS 2017 enviroment, so we decided to use the most recent __VC++ 2017 runtime__ for our VC++ projects.

## Step 3: project update

In the past we had some issues that MSBuild used the wrong MSBuild version. Maybe this step is not needed, but we pointed all .csproj files to the newest __MSBuild ToolVersion 15.0__.

## Step 4: CAKE update

The last step was to update the CAKE.exe (which is controlled by us and not automatically downloaded via a build script) to 0.18.

## Step 5: Minor build script changes

We needed to adjust some paths (e.g. to the Windows SDK for signtool.exe) and ensure that we are using the most recent MSBuild.exe.

## Step 6: Create a new Build-Agent

We decided to create a __[new TFS Build-Agent](https://blog.codeinside.eu/2016/08/10/adding-a-new-windowsagent-to-tfs2015-build/)__ and do the usual build agent installation, imported the code-cert and do some magic because of some C++/COM-magic (don't ask... COM sucks.)

## Recap

Besides the C++/COM/magic issue (see above) the migration was pretty easy and now our team works with Visual Studio 2017.
	