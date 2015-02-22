---
layout: post
title: "ESENT Database Viewer: ESENT Workbench"
description: "If you are working with the (very very old) ESENT Database and you are looking for a simple tool to get a look at the raw data ESENTWorkbench might be interesting for you."
date: 2015-02-22 11:00
author: robert.muehsig
tags: [ESENT, NoSQL, ESENTDB, Viewer]
language: en
---
{% include JB/setup %}

I already blogged about [the ancient old ESENT Database](http://blog.codeinside.eu/2013/12/12/esent-the-ancient-nosql-db-made-by-windows/), which is still supported and will also be available in Windows 10, so you are safe to use it. Also the [ManagedESENT](https://managedesent.codeplex.com/) project is alive and somewhat in [active development](https://managedesent.codeplex.com/SourceControl/list/changesets).

With the ManagedESENT project you can store your data inside a ESENT database very easy*, but what if you want to __look inside the ESENT database__?

_* ... well... the interface is still awkward for a C# dev, but it is possible to build a nice abstraction around it. [Here](https://managedesent.codeplex.com/wikipage?title=ManagedEsentSample&referringTitle=ManagedEsentDocumentation) can you see a sample from the project._

# ESENT Database Viewer: ESENT Workbench 

I found a very promising OSS project called [__ESENT Workbench__](https://bitbucket.org/gfkeogh/esentworkbench). You can build the source yourself or just use the [__release__](https://bitbucket.org/gfkeogh/esentworkbench/downloads).

![x]({{BASE_PATH}}/assets/md-images/2015-02-22/esentworkbench.png "ESENT Workbench Table Explorer")

![x]({{BASE_PATH}}/assets/md-images/2015-02-22/esentworkbenchdata.png "ESENT Workbench Data Explorer")

Hope this helps and if you know any other useful tools around the ESENT database just write it in the comments.