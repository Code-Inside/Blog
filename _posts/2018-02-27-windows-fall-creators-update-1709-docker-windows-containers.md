---
layout: post
title: "Windows Fall Creators Update 1709 and Docker Windows Containers"
description: "If you are using Windows Containers for Docker, be aware of the new 1709 Windows base images and how to deploy them."
date: 2018-02-27 23:35
author: Robert Muehsig
tags: [docker, windows]
language: en
---
{% include JB/setup %}

# Who shrunk my Windows Docker image? 

We started to package our ASP.NET/WCF/Full-.NET Framework based web app into Windows Containers, which we then publish to the Docker Hub. 

Someday we discovered that one of our new build machines produced Windows Containers only __half the size__: 
Instead of a 8GB Docker image we only got a 4GB Docker image. Yeah, right?

# The problem with Windows Server 2016

I was able to run the 4GB Docker image on my development machine without any problems and I thought that this is maybe a great new feature (it is... but!). My boss then told my that he was unable to run this on our __Windows Server 2016__.

# The issue: Windows 10 Fall Creators Update

After some googling around we found the problem: Our build machine was a __Windows 10 OS with the most recent "Fall Creators Update" (v1709)__ (which was a bad idea from the beginning, because if you want to run Docker as a Service you will need a Windows Server!). The older build machine, which produced the much larger Docker image, was running with the normal Creators Update from March(?).

Docker resolves the base images for Windows like this:

* If you pull the ASP.NET Docker image from a Windows 10 Client OS __with the Fall Creators Update__ you will get this [4.7.1-windowsservercore-1709 image](https://github.com/Microsoft/aspnet-docker/blob/master/4.7.1-windowsservercore-1709/runtime/Dockerfile)
* If you pull it from a Windows Server 2016 or a older Windows 10 Client OS you will get this [4.7.1-windowsservercore-ltsc2016 image](https://github.com/Microsoft/aspnet-docker/blob/master/4.7.1-windowsservercore-ltsc2016/runtime/Dockerfile)

# Compatibility issue

As it turns out: You can't run the smaller Docker images on Windows Server 2016. Currently it is only possible to do it via the preview ["Windows Server, version 1709"](https://blogs.technet.microsoft.com/windowsserver/2017/10/26/faq-on-windows-server-version-1709-and-semi-annual-channel/) or on the Windows 10 Client OS.

Oh... and the new Windows Server is not a simple update to Windows Server 2016, instead it is a completely new version. Thanks Microsoft.

# Workaround

Because we need to run our images on Windows Server 2016, we just target the LTSC2016 base image, which will produce 8GB Docker images (which sucks, but works for us).

## Further Links:

This post could also be in the RTFM-category, because there are some notes on the Docker page available, but it was quite easy to overread ;)

* [Preview Docker for Windows Server 1709 and Windows 10 Fall Creators Update](https://docs.docker.com/install/windows/ee-preview/) 
* [FAQ on Windows Server, version 1709 and Semi-Annual Channel](https://blogs.technet.microsoft.com/windowsserver/2017/10/26/faq-on-windows-server-version-1709-and-semi-annual-channel/) 
* [Stefan Scherer has some good information on this topic as well](https://stefanscherer.github.io/docker-on-windows-server-1709/) 
