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

We access certain Active Directory properties with our application, and on one customer domain, we couldn't retrieve any data via our Active Directory component.

# Solution

After some debugging and doubts about our functionality, the customer admin and I found the reason:
Our code was running under a Windows account that was very limited and couldn't read those properties.

If you have similar problems, you might want to look into the AD User & Group management.

First step: You need to active the advanced features:

![x]({{BASE_PATH}}/assets/md-images/2023-09-20/advanced_features.png "Advanced Features")

Now navigate to your "user OU" or the target users and check the security tab. The goal is to grant your service account the permission to read the needed property. To do that, go to the advanced view, and add a new permission or change an existing one:

![x]({{BASE_PATH}}/assets/md-images/2023-09-20/settings.png "Settings")

Here you should be able to see a huge dialog with __all available properties__ and grant the read permission for the target property for your service account.

![x]({{BASE_PATH}}/assets/md-images/2023-09-20/details.png "Details")

# Solution via CMD

The UI is indeed quite painful to use. If you know what you are doing you can use [dsacls.exe](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc771151(v=ws.11)). 

To grant the read permission for `tokenGroups` for a certain service account you can use the tool like this:

```
dsacls "OU=Users,DC=company,DC=local" /I:S /G "service_account":rp;tokenGroups;user
```
Hope this helps!
