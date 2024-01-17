---
layout: post
title: "How Windows locates an executable via PATH or App Paths"
description: "Ever wondered how Windows locates an executable when you typed in your your shell or use 'Process.Start(...)'?"
date: 2024-01-17 23:55
author: Robert Muehsig
tags: [Registry, Windows]
language: en
---

{% include JB/setup %}

If you've ever worked with the Windows operating system, especially in a programming context, you might have used the `Process.Start(yourapp)` (e.g. `Process.Start(Outlook)`) method in languages like C#.
This method is used to start a process - essentially to run an executable file. But have you ever stopped to think about how Windows knows where to find the executables you're trying to run? Let's dive into the inner workings of Windows and uncover this mystery.

# Understanding the PATH Environment Variable

One of the first things that come into play is the `PATH` environment variable. This variable is crucial for the operating system to locate the executables.

**What is the PATH Variable?**

The `PATH` environment variable is a system-wide or user-specific setting that lists directories where executable files are stored. When you run a command in the command prompt or use `Process.Start(...)`, Windows looks through these directories to find the executable file.

The `PATH` environment variable can be viewed via the system settings:

![x]({{BASE_PATH}}/assets/md-images/2024-01-17/environmentsettings.png "System Settings")

... there is also a nice editor now build into Windows for the `PATH` environment variable:

![x]({{BASE_PATH}}/assets/md-images/2024-01-17/pathedit.png "Path Edit")

**How Does PATH Work?**

If the executable is not in the current directory, Windows searches through each directory specified in the `PATH` variable. The order of directories in `PATH` is important - Windows searches them in the order they are listed. If it finds the executable in one of these directories, it runs it.

However, the `PATH` variable isn't the only mechanism at play here.

# The Role of App Paths in the Windows Registry

Another less-known but equally important component is the "**[App Paths](https://learn.microsoft.com/en-us/windows/win32/shell/app-registration)**" registry key. This key is located in `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths`.

**Understanding App Paths**

The `App Paths` key is used to specify paths to specific applications. Each application can have its entry under the `App Paths` key, which means that Windows can find and run these applications even if their directories are not listed in the `PATH` variable.

![x]({{BASE_PATH}}/assets/md-images/2024-01-17/apppaths.png "App path")

**How Do App Paths Work?**

When you use `Process.Start(...)` and specify an application name like "OUTLOOK", Windows first checks the App Paths registry key before it checks the `PATH` variable. If it finds an entry for the application here, it uses this path to start the application. This is particularly useful for applications that are not in common directories or have multiple executables in different locations.

# Conclusion

Both `PATH` and `App Paths` play significant roles. While `PATH` is great for general-purpose directory searching (especially for system utilities and command-line tools), `App Paths` is more specific and tailored for individual applications.

There are probably even more options out there besides `PATH` and `App Paths` - Windows is full of hidden gems like this 😉.

Fun fact: I only discovered `App Paths` while debugging a problem. We use `Process.Start(OUTLOOK)` to start Microsofts Outlook Client and I was wondering why this even works.

Hope this helps!
