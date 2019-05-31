---
layout: post
title: "Build Windows Server 2016 Docker Images under Windows Server 2019"
description: "Building Docker Images with different Windows targets..."
date: 2019-05-31 23:45
author: Robert Muehsig
tags: [Docker, Windows Server 2019, Windows Server 2016]
language: en
---

{% include JB/setup %}

Since the uprising of Docker on Windows we also invested some time into it and packages our OneOffixx server side stack in a Docker image.

__Windows Server 2016 situation:__

We rely on Windows Docker Images, because we still have some "legacy" parts that requires the full .NET Framework, thats why we are using this base image:

    FROM microsoft/aspnet:4.7.2-windowsservercore-ltsc2016
	
As you can already guess: This is based on a Windows Server 2016 and besides the "legacy" parts of our application, we need to support Windows Server 2016, because Windows Server 2019 is currently not available on our customer systems.

In our build pipeline we could easily invoke Docker and build our images based on the LTSC 2016 base image and everything was "fine".

__Problem: Move to Windows Server 2019__

Some weeks ago my collegue updated our Azure DevOps Build servers from Windows Server 2016 to Windows Server 2019 and our builds began to fail.

__Solution: Hyper-V isolation!__

After some internet research this site popped up: [Windows container version compatibility
](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/version-compatibility)

Microsoft made some great enhancements to Docker in Windows Server 2019, but if you need to "support" older versions, you need to take care of it, which means:

If you have a Windows Server 2019, but want to use Windows Server 2016 base images, you need to activate [Hyper-V isolation](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/hyperv-container).

Example from our own cake build script:

    var exitCode = StartProcess("Docker", new ProcessSettings { Arguments = "build -t " + dockerImageName + " . --isolation=hyperv", WorkingDirectory = packageDir});
		
Hope this helps!