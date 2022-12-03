---
layout: post
title: "SQLLocalDb update"
description: "If you want to update your SqlLocalDb..."
date: 2022-12-03 22:15
author: Robert Muehsig
tags: [SqlLocalDb]
language: en
---

{% include JB/setup %}

# Short Intro

SqlLocalDb is a "developer" SQL server, without the "full" SQL Server (Express) installation. If you just develop on your machine and don't want to run a "full blown" SQL Server, this is the tooling that you might need.

From the [Microsoft Docs](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-express-localdb?view=sql-server-ver16):

> Microsoft SQL Server Express LocalDB is a feature of SQL Server Express targeted to developers. It is available on SQL Server Express with Advanced Services.
> 
> LocalDB installation copies a minimal set of files necessary to start the SQL Server Database Engine. Once LocalDB is installed, you can initiate a connection using a special connection string. When connecting, the necessary SQL Server infrastructure is automatically created and started, enabling the application to use the database without complex configuration tasks. Developer Tools can provide developers with a SQL Server Database Engine that lets them write and test Transact-SQL code without having to manage a full server instance of SQL Server.

# Problem

(I'm not really sure, how I ended up on this problem, but I after I solved the problem I did it on my "To Blog"-bucket list)

From time to time there is a new SQLLocalDb version, but to upgrade an __existing__ installation is a bit "weird".

# Solution

If you have installed an older SQLLocalDb version you can manage it via `sqllocaldb`. If you want to update you must delete the "current" MSSQLLocalDB in the first place.

To to this use:

```
sqllocaldb stop MSSQLLocalDB
sqllocaldb delete MSSQLLocalDB
``` 

Then download the newest version [from Microsoft](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-express-localdb?view=sql-server-ver16#installation-media). 
If you choose "Download Media" you should see something like this:

![x]({{BASE_PATH}}/assets/md-images/2022-12-03/sqllocaldbinstall.png "SQL LocalDb installer")

Download it, run it and restart your PC, after that you should be able to connect to the SQLLocalDb.

We solved this issue with help of [this blogpost](https://knowledge-base.havit.eu/2020/12/17/sql-localdb-upgrade-to-2019-15-0-2000/). 

Hope this helps! (and I can remove it now from my bucket list \o/ )