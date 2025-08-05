---
layout: post
title: "MSI and MST files"
description: "A (very) short overview of how MSI and MST files work together..."
date: 2025-08-05 23:59
author: Robert Muehsig
tags: [Windows, Installer]
language: en
---

{% include JB/setup %}

*This is more of a "Today-I-Learned" post and not a "full-blown How-To article." If something is completely wrong, please let me know – thanks!*

# What is an MSI?

Let's start simple: An __MSI__ (Microsoft Installer) is a package used to install software on Windows. The MSI contains everything needed to install the software, such as files, registry changes, and custom actions.

An MSI also includes *properties*—for example, the install location or custom values that need to be applied during installation.

You can install an MSI interactively (by double-clicking it) or by using the `msiexec` command.

A more complex `msiexec` command can look like this:

```
msiexec /qb /i "installer.msi" APPLICATIONFOLDER="C:\Program Files\customSoftware" SOMEPROP="SomeValue" SOMEOTHERPROP="SomeOtherValue"
```

# Ok... and what is an MST?

An __MST__ (Microsoft Transform) is a file that contains a set of modifications for an MSI installation. All those properties (and more) that you would pass via command line can be "baked into" an MST file.

You can apply an MST during installation like this:


```
msiexec /i setup.msi TRANSFORMS=custom.mst /qn
```


# Pros / Cons

**Pros:**

If you want to apply the same settings across multiple installations and keep them stored in one place, an MST is a good solution.

**Cons:**

The MST file, like the MSI itself, is a binary file and can only be edited with tools like [Orca](https://learn.microsoft.com/en-us/windows/win32/msi/orca-exe).

Both file formats are quite old, but I recently learned that **MST** files are still a thing—and quite useful if you're dealing with automated or enterprise software deployments.

Hope this helps!