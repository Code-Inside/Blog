---
layout: post
title: "WinUI 3 Community Toolkit and the Template Studio"
description: "After the first steps with WinUI3 take a look at the Community Toolkit and the Template Studio"
date: 2024-02-24 23:59
author: Robert Muehsig
tags: [WinUI 3, Windows]
language: en
---

{% include JB/setup %}

In my last post ["First steps with WinUI 3"](https://blog.codeinside.eu/2024/02/12/first-steps-with-winui3/) I already mentioned the ["WinUI 3 Gallery"-App](https://apps.microsoft.com/detail/9p3jfpwwdzrc), but I missed mentioning two great resources.

If you take a deeper look at the "Home" page, you will spot the [Community Toolkit Gallery (another app)](https://apps.microsoft.com/detail/9nblggh4tlcq) and the ["Template Studio for WinUI"](https://marketplace.visualstudio.com/items?itemName=TemplateStudio.TemplateStudioForWinUICs).

![x]({{BASE_PATH}}/assets/md-images/2024-02-24/winui3gallery.png "WinUI 3 Gallery")

# What is the Community Toolkit? 

The Community Toolkit is a community-driven collection of components and other helpers.

![x]({{BASE_PATH}}/assets/md-images/2024-02-24/community-toolkit.png "WinUI 3 Gallery")

The "home" of the Community Toolkit can be found on [GitHub](https://github.com/CommunityToolkit/Windows)

As of today, the Community Toolkit seems "alive" with recent commits in February 2024. 

Interesting fact: The controls from the toolkit seems to work with the [Uno Platform](https://platform.uno/) as well.

# What is the Template Studio?

Template Studio is an addin for Visual Studio and can be installed [from the Marketplace](https://marketplace.visualstudio.com/items?itemName=TemplateStudio.TemplateStudioForWinUICs).

This adds the 'Template Studio for WinUI' template to Visual Studio:

![x]({{BASE_PATH}}/assets/md-images/2024-02-24/template-studio.png "Template Studio")

After the usual "pick a name and location" you will be greeted with this Wizard:

The first step is to select a "Project type":

![x]({{BASE_PATH}}/assets/md-images/2024-02-24/template-studio-1.png "Template Studio - Project Type")

In the next step you choose a "Design pattern" - which has only one item... well.

![x]({{BASE_PATH}}/assets/md-images/2024-02-24/template-studio-2.png "Template Studio - Design pattern")

In "Pages" you can create your "views/pages" based on a given layout:

Some pages can only be added once (e.g. the "Settings"), but most pages can be added multiple times.

![x]({{BASE_PATH}}/assets/md-images/2024-02-24/template-studio-3.png "Template Studio - Pages")

In "Features" you can add some WinUI 3 related features:

![x]({{BASE_PATH}}/assets/md-images/2024-02-24/template-studio-4.png "Template Studio - Features")

In the last setting you can decide if you want to add an MSTest project as well:

![x]({{BASE_PATH}}/assets/md-images/2024-02-24/template-studio-5.png "Template Studio - Testing")

The result is the following Visual Studio solution, which includes two projects and a number of `TODO` items:

![x]({{BASE_PATH}}/assets/md-images/2024-02-24/template-studio-vsproject.png "Template Studio - Solution")

If you run the code a pretty simple app with your configured pages will be found:

![x]({{BASE_PATH}}/assets/md-images/2024-02-24/template-studio-result.png "Template Studio - Result")

__Warning:__ Such code generators might be a good starting point, but (as always with such generators) the code might be "too stupid" or "too complicated" - depending on your needs. 

# Any other useful resource?

I'm a newbie with WinUI 3. The Community Toolkit looks promising and even the Template Studio looks good - at least from a few minutes playtime. If anyone has other useful resource: Please let me know (e.g. in the comments or via email). 

Hope this helps!

