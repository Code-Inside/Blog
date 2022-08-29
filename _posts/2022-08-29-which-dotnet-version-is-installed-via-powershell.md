---
layout: post
title: "Which .NET Framework Version is installed on my machine?"
description: "Use this nice PowerShell oneliner."
date: 2022-08-29 23:15
author: Robert Muehsig
tags: [.NET Framework, PowerShell]
language: en
---

{% include JB/setup %}

If you need to know which .NET Framework Version (the "legacy" .NET Framework) is installed on your machine try this handy oneliner:

```ps
Get-ItemProperty "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full"
```

Result:

```
CBS           : 1
Install       : 1
InstallPath   : C:\Windows\Microsoft.NET\Framework64\v4.0.30319\
Release       : 528372
Servicing     : 0
TargetVersion : 4.0.0
Version       : 4.8.04084
PSPath        : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework
                Setup\NDP\v4\Full
PSParentPath  : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4
PSChildName   : Full
PSDrive       : HKLM
PSProvider    : Microsoft.PowerShell.Core\Registry
```

The __version__ should give you more then enough information.

Hope this helps!