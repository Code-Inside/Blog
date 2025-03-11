---
layout: post
title: "Update an old SPFX Project"
description: "... TL;DR: Checkout the m365 CLI!"
date: 2025-03-11 23:59
author: Robert Muehsig
tags: [SPFX, SharePoint]
language: en
---

{% include JB/setup %}

*This is more of a "Today-I-Learned" post and not a "full-blown How-To article." If something is completely wrong, please let me know - thanks!* 

Last week I had to upgrade an old SharePoint Framework (SPFX) project, and surprisingly, the process was smoother than expected.

For those unfamiliar, SPFX is a framework for building extensions for SharePoint Online. Here is an example of an SPFX extension: [Microsoft Docs](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/extensions/get-started/build-a-hello-world-extension).

The upgrade approach I took was a combination of:

- Creating a completely new SPFX project to see the latest project structure.
- Using the [M365 CLI](https://pnp.github.io/cli-microsoft365/cmd/spfx/project/project-upgrade) to generate a step-by-step upgrade guide.

Overall, it turned out to be a pretty smooth experience and the CLI was quite new for me, and I wanted to document it here.

Hope this helps!