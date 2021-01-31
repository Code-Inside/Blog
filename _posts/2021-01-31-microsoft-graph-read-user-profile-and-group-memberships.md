---
layout: post
title: "Microsoft Graph: Read user profile and group memberships"
description: "'Directory.Read.All' and 'User.Read.All'"
date: 2021-01-31 23:30
author: Robert Muehsig
tags: [Microsoft Graph]
language: en
---

{% include JB/setup %}

In our application we have a background service, that "syncs" user data and group membership information to our database from the [Microsoft Graph](https://docs.microsoft.com/en-us/graph).

__The permission model:__

Programming against the Microsoft Graph is quite easy. There are many [SDKS](https://docs.microsoft.com/en-us/graph/sdks/sdks-overview) available, but understanding the [permission model](https://docs.microsoft.com/en-us/graph/permissions-reference) is hard.

__'Directory.Read.All' and 'User.Read.All':__

Initially we only synced the "basic" user data to our database, but then some customers wanted to reuse some other data already stored in the graph. Our app required the 'Directory.Read.All' permission, because we thought that this would be the "highest" permission - this is __wrong__!

If you need "directory" information, e.g. memberships, the `Directory.Read.All` or `Group.Read.All` is a good starting point. But if you want to load specific user data, you might need to have the `User.Read.All` permission as well.

Hope this helps!