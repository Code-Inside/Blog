---
layout: post
title: "'error MSB8011: Failed to register output.' & UTF8-BOM files"
description: "I have no idea, but be aware of your file encodings!"
date: 2022-08-30 23:15
author: Robert Muehsig
tags: [MSBuild, Visual Studio]
language: en
---

{% include JB/setup %}

Be aware: I'm not a C++ developer and this might be an "obvious" problem, but it took me a while to resolve this issue.

In our product we have very few C++ projects. We use these projects for very special Microsoft Office COM stuff and because of COM we need to register some components during the build. Everything worked as expected, but we renamed a few files and our build broke with:

```
C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Microsoft\VC\v170\Microsoft.CppCommon.targets(2302,5): warning MSB3075: The command "regsvr32 /s "C:/BuildAgentV3_1/_work/67/s\_Artifacts\_ReleaseParts\XXX.Client.Addin.x64-Shims\Common\XXX.Common.Shim.dll"" exited with code 5. Please verify that you have sufficient rights to run this command. [C:\BuildAgentV3_1\_work\67\s\XXX.Common.Shim\XXX.Common.Shim.vcxproj]
C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Microsoft\VC\v170\Microsoft.CppCommon.targets(2314,5): error MSB8011: Failed to register output. Please try enabling Per-user Redirection or register the component from a command prompt with elevated permissions. [C:\BuildAgentV3_1\_work\67\s\XXX.Common.Shim\XXX.Common.Shim.vcxproj]

(xxx = redacted)
```

The crazy part was: Using an older version of our project just worked as expected, but all changes were "fine" from my point of view.

After many, many attempts I remembered that our diff tool doesn't show us everything - so I checked the __file encodings__: `UTF8-BOM` 

Somehow if you have a UTF8-BOM encoded file that your C++ project uses to register COM stuff it will fail. I changed the encoding and to `UTF8` and everyting worked as expected.

What a day... lessons learned: Be aware of your file encodings.

Hope this helps!