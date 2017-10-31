---
layout: post
title: "Introducing Electron.NET - building Electron Desktop Apps with ASP.NET Core"
description: "Say hello to our little experiment!"
date: 2017-10-31 23:15
author: Robert Muehsig
tags: [electron, oss]
language: en
---
{% include JB/setup %}


![x]({{BASE_PATH}}/assets/md-images/2017-10-31/electron.net-logo.png "Electron.NET")

The last couple of weeks I worked with my buddy [Gregor Biswanger](http://www.cross-platform-blog.com/) on a new project called __"[Electron.NET](https://github.com/ElectronNET/Electron.NET)"__. 

As you might already guess: It is some sort of bridge between the well known [Electron](https://electron.atom.io/) and .NET.

*If you don't know what Electron is: It helps to build desktop apps written in HTML/CSS/Javascript*

# The idea 

Gregor asked me a while ago if it is possible to build desktop apps with ASP.NET Core (or .NET Core in general) and - indeed - there are some ideas how to make it, but unfortunatly there is no "official" UI stack available for .NET Core. 
After a little chat we agreed that the best bet would be to use Electron as is and somehow "embed" ASP.NET Core in it.

I went to bed, but Gregor was keen on to build a prototyp and he did it: He was able to launch the ASP.NET Core application inside the electron app and invoke some Electron APIs from the .NET World. 

First steps done, yeah! In the following weeks Gregor was able to "bridge" most Electron APIs and I could help him with the tooling via our dotnet-extension.

# Overview

The basic functionality is not too complex: 

* We ship a "standard" (more or less blank) Electron app
* Inside the Electron part two free ports are searched:
  * The first free port is used inside the Electron app itself
  * The second free port is used for the ASP.NET Core process
* The app launches the .NET Core process with ASP.NET Core port (e.g. localhost:8002) and injects the first port as parameter
* Now we have a Socket.IO based linked between the launched ASP.NET Core app and the Electron app itself - this is our communication bridge!

At this point you can write your Standard ASP.NET Core Code and can communicate via our Electron.API wrapper to the Electron app. 

Gregor did a __[fabulous blogpost with a great example](http://www.cross-platform-blog.com/electron.net/electron.net-musicplayer-app-with-asp.net-core)__.

# Intersted? This way!

If you are interested, maybe take a look at the __[ElectronNET-Org on GitHub](https://github.com/ElectronNET)__. The complete code is OSS and there are two demo repositories.

# No way - this is a stupid idea!

The last days were quite intersting. We got some nice comments about the project and (of course) there were some critics.

As far as I know the current "this is bad, because... "-list is like this:

* We still need node.js and Electron.NET is just a wrapper around Electron: Yes, it is. 
* Perf will suck: Well... to be honest - the current startup time does really suck, because we not only launch the Electron stuff, but we also need to start the .NET Core based WebHost - maybe we will find a solution
* Starting a web server inside the app is bad on multiple levels because of security and perf: I agree, there are some [ideas how to fix it](https://github.com/ElectronNET/Electron.NET/issues/22), but this might take some time.

There are lots of issues open and the project is pretty young, maybe we will find a solution for the above problems, maybe not. 

# Final thoughts

The interesting point for me is, that we seem to hit a nerf with this project: There is demand to write X-Plat desktop applications.

We are looking for feedback - please share your opinion on the [ElectronNET-GitHub-Repo](https://github.com/ElectronNET/Electron.NET) or try it out :) 

*Desktop is dead, long live the desktop!*


 