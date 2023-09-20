---
layout: post
title: "Limit Active Directory property access"
description: "If you ever had the problem, that you can't access specific AD properties..."
date: 2023-09-20 23:55
author: Robert Muehsig
tags: [Active Directory]
language: en
---

{% include JB/setup %}

__Be aware:__ I'm not a full time administrator and this post might sound stupid to you.

# The Problem

We access certain Active Directory properties with our application and on one customer domain we couldn't get any data out via our Active Directory component.

# Solution

After some debugging and doubts about our functionality we (the admin of the customer and me) found the reason:
Our code was running under a Windows Account that was very limted and couldn't read those properties.

If you have similar problems you might want to take a look in the AD User & Group management.

1. You need to active the advanced features:

![x]({{BASE_PATH}}/assets/md-images/2023-09-20/advanced_features.png "Advanced Features")

2. Now check the security tab, go to advanced view and add a new permission or change a existing one:

![x]({{BASE_PATH}}/assets/md-images/2023-09-20/settings.png "Settings")

3. Here you should be able to see a huge dialog with __all available properties__. Check if your user is able to read your target property

![x]({{BASE_PATH}}/assets/md-images/2023-09-20/details.png "Details")

Hope this helps!