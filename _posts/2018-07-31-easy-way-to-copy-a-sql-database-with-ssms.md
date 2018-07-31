---
layout: post
title: "Easy way to copy a SQL database with Microsoft SQL Server Management Studio (SSMS)"
description: "It's quite ironic that cloning or copien a database with SSMS is such a hard thing. This blogposts serves as a very short reminder to myself and interesting readers how to copy a database on the same server."
date: 2018-07-31 23:45
author: Robert Muehsig
tags: [SQL, MSSQL, SSMS]
language: en
---
{% include JB/setup %}

# How to copy a database on the same SQL server

The scenario is pretty simple: We just want a copy of our database, with all the data and the complete scheme and permissions.

## 1. step: Make a back up of your source database

Click on the desired database and choose "Backup" under tasks.

![x]({{BASE_PATH}}/assets/md-images/2018-07-31/1_BackupTask.png "Backup the database")

## 2. step: Use copy only or use a full backup

In the dialog you may choose "copy-only" backup. With this option the regular backup job will not be confused.

![x]({{BASE_PATH}}/assets/md-images/2018-07-31/2_BackupOptions.png "Copy only")

## 3. step: Use "Restore" to create a new database

This is the most important point here: To avoid fighting against database-file namings use the "restore" option. __Don't__ create a database manually - this is part of the restore operation.

![x]({{BASE_PATH}}/assets/md-images/2018-07-31/3_restoredatabase.png "Restore database")

## 4. step: Choose the copy-only backup and choose a new name

In this dialog you can name the "copy" database and choose the copy-only backup from the source database.

![x]({{BASE_PATH}}/assets/md-images/2018-07-31/4_copydb.png "Restore dialog")

Now click ok and you are done!

## Behind the scenes

This restore operation works way better to copy a database then to overwrite an existing database, because the restore operation will adjust the filenames.

![x]({{BASE_PATH}}/assets/md-images/2018-07-31/5_copydb_setting.png "Filename settings")

## Further information

I'm not a DBA, but when I follow these steps I normally have nothing to worry about if I want a 1:1 copy of a database. This can also be scripted, but then you may need to worry about filenames.

This [stackoverflow question](https://stackoverflow.com/questions/3829271/how-can-i-clone-an-sql-server-database-on-the-same-server-in-sql-server-2008-exp) is full of great answers!

Hope this helps!


