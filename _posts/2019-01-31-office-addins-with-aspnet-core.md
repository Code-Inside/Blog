---
layout: post
title: "Office Add-ins with ASP.NET Core"
description: "If you want to write Office Add-ins powered by an ASP.NET Core host you might want to check this out."
date: 2019-01-31 23:45
author: Robert Muehsig
tags: [ASP.NET Core, Office, Office-Addin]
language: en
---

{% include JB/setup %}

# The "new" Office-Addins

Most people might associate Offce-Addins with "old school" COM addins, but since a couple of years Microsoft pushes a new add-in application modal powered by HTML, Javascript and CSS.

The cool stuff is, that these add-ins will run unter Windows, macOS, Online in a browser and on the iPad. If you want to read more about the general aspects, just checkout the [Microsoft Docs](https://docs.microsoft.com/en-us/office/dev/add-ins/overview/office-add-ins).

In Microsoft Word you can find those addins under the "Insert" ribbon:

![x]({{BASE_PATH}}/assets/md-images/2019-01-31/officeaddins-in-word.png "Add-ins in Word")

# Visual Studio Template: Urgh... ASP.NET 

Because of the "new" nature of the Add-ins you could actually use your favorite text editor and create a valid Office Add-ins. There are some great tooling out there, including a [Yeoman generator for Office-Add-ins](https://github.com/OfficeDev/generator-office).

If you want to stick with Visual Studio you might want to install the __"Office/SharePoint development-Workload". After the installation you should see a couple of new templates appear in your Visual Studio:

![x]({{BASE_PATH}}/assets/md-images/2019-01-31/vstemplates.png "Templates")

Sadly, those templates still uses ASP.NET and not ASP.NET Core.

![x]({{BASE_PATH}}/assets/md-images/2019-01-31/old.png "ASP.NET is used...")

# ASP.NET Core Sample

If you want to use ASP.NET Core, you might want to take a look at my [__ASP.NET Core__](https://github.com/Code-Inside/Samples/tree/master/2018/officeaddincore)-sample. It is __not__ a VS template - it is meant to be a starting point, but feel free to create one if this would help!

![x]({{BASE_PATH}}/assets/md-images/2019-01-31/new.png "ASP.NET Core is used...")

The structure is very similar. I moved all the generated HTML/CSS/JS stuff in a separate area and the Manifest.xml points to those files.

Result should be something like this:

![x]({{BASE_PATH}}/assets/md-images/2019-01-31/debugging.png "... and it runs!")

__Warning:__ 

In the "ASP.NET"-Offce-Addin-development world there is one feature that is kinda cool, but seems not to be working with ASP.NET Core projects.
The original Manifest.xml generated by the Visual Studio template uses a placeholder called "~remoteAppUrl". 
It seems that Visual Studio was able to replace this placeholder during startup with the correct URL of the ASP.NET application. This is not possible with a ASP.NET Core application. 

The good news is, that this feature is not really needed. You just need to point to the correct URL and everything is fine and the debugging is OK as well.

Hope this helps!
