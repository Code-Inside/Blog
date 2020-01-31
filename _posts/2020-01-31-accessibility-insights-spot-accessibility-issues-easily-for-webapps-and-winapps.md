---
layout: post
title: "Accessibility Insights: Spot accessibilities issues easily for Web Apps and Windows Apps"
description: "TL;DR: Download Accessibility Insights and check our app for issues."
date: 2020-01-31 23:59
author: Robert Muehsig
tags: [Accessibility]
language: en
---

{% include JB/setup %}

# Accessibility

Accessibility is a huge and important topic nowadays. Keep in mind that in some sectors (e.g. government, public service etc.) accessibility is a requirement by law (in Europe the [European Standards EN 301 549](https://docs.microsoft.com/en-us/microsoft-365/compliance/offering-en-301-549-eu)).

If you want to learn more about accessibility in general this might be handy: [MDN Web Docs: What is accessibility?](https://developer.mozilla.org/en-US/docs/Learn/Accessibility/What_is_accessibility)

# Tooling support

In my day to day job for [OneOffixx](https://oneoffixx.com/) I was looking for a good tool to spot accessibility issues in our Windows and Web App. I knew that there must be some good tools for web development, but was not sure about Windows app support.

Accessibility itself has many aspects, but these were some non obvious key aspects in our application that we needed to address:

* Good contrasts: This one is easy to understand, but sometimes some colors or hints in the software didn't match the required contrast ratios. High contrast modes are even harder. 
* Keyboard navigation: This one is also easy to understand, but can be really hard. Some elements are nice to look at, but hard to focus with pure keyboard commands.
* Screen reader: After your application can be navigated with the keyboard you can checkout screen reader support. 

# Accessibility Insights 

Then I found this app from Microsoft: [Accessibility Insights](https://accessibilityinsights.io/)

![x]({{BASE_PATH}}/assets/md-images/2020-01-31/logo.png "Logo")

The tool scans active applications for any accessibility issues. Side node: The UX is a bit strange, but OK - you get used to it.

__Live inspect:__

The starting point is to select a window or a visible element on the screen and Accessibility Insights will highlight it:

![x]({{BASE_PATH}}/assets/md-images/2020-01-31/live-inspect.png "Live inspect")

Then you can click on "Test", which gives you detailed test result:

![x]({{BASE_PATH}}/assets/md-images/2020-01-31/checks.png "Checks")

(I'm not 100% if each error is really problematic, because a lot of Microsofts very own applications have many issues here.)

__Tab Stops:__

As already written: Keyboard navigation is a key aspect. This tool has a nice way to visualize "Tab" navigation and might help you to better understand the navigation with a keyboard:

![x]({{BASE_PATH}}/assets/md-images/2020-01-31/tabstops.png "Tab Stops")

__Contrasts:__

The third nice helper in Accessibility Insights is the contrast checker. It highlights contrast issues and has an easy to use color picker integrated.

![x]({{BASE_PATH}}/assets/md-images/2020-01-31/contrasts.png "Contrasts")

Behind the scenes this tool uses the [Windows Automation API / Windows UI Automation API](https://docs.microsoft.com/en-us/windows/win32/winauto/windows-automation-api-portal). 

# Accessibility Insights for Chrome

Accessibility Insights can be used in Chrome (or Edge) as well to check web apps. The extension is similar to the Windows counter part, but has a much better "assessment" story:

![x]({{BASE_PATH}}/assets/md-images/2020-01-31/web-fastpass.png "Chrome: Fastpass on GitHub")

![x]({{BASE_PATH}}/assets/md-images/2020-01-31/web-assessment.png "Chrome: Accessment")

![x]({{BASE_PATH}}/assets/md-images/2020-01-31/web-tab.png "Chrome: Tab Stops")

# Summary

This tool was really a time saver. The UX might not be the best on Windows, but it gives you some good hints. After we discovered this app for our Windows Application we used the Chrome version for our Web Application as well. 

If you use or used other tools in the past: Please let me know. I'm pretty sure there are some good apps out there to help build better applications.

Hope this helps!
