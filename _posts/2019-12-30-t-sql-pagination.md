---
layout: post
title: "T-SQL Pagination"
description: "OFFSET and FETCH"
date: 2019-12-30 23:45
author: Robert Muehsig
tags: [T-SQL, SQL]
language: en
---

{% include JB/setup %}

# The problem

This is pretty trivial: Let's say you have blog with 1000 posts in your database, but you only want to show 10 entries "per page". You need to find a way how to slice this dataset into smaller pieces.

# The solution

In theory you could load everything from the database and filter the results "in memory", but this would be quite stupid for many reasons (e.g. you load much more data then you need and the computing resources could be used for other requests etc.). 

If you use plain T-SQL (__and Microsoft SQL Server 2012 or higher__) you can express a query with paging like this:

    SELECT * FROM TableName ORDER BY id OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

Read it like this: Return the first 10 entries from the table. To get the next 10 entries use OFFSET 10 and so on.

If you use the Entity Framework (or Entity Framework Core or any other O/R-Mapper) the chances are high they do exact the same thing internally for you.

Currently all ["supported" SQL Servers](https://support.microsoft.com/en-us/lifecycle/search?alpha=SQL%20Server) support this syntax nowadays. If you try this syntax on SQL Server 2008 or SQL Server 2008 R2 you will receive a SQL error

# Links

Checkout the [documentation](https://docs.microsoft.com/en-us/sql/t-sql/queries/select-order-by-clause-transact-sql?view=sql-server-ver15#using-offset-and-fetch-to-limit-the-rows-returned) for further information.

This topic might seem "simple", but during my developer life I was suprised how "hard" paging was with SQL Server. Some 10 years ago (... I'm getting old!) I was using MySQL and the OFFSET and FETCH syntax was introduced with Microsoft SQL Server 2012. This [Stackoverflow.com Question](https://stackoverflow.com/questions/109232/what-is-the-best-way-to-paginate-results-in-sql-server) shows the different ways how to implement it. The "older" ways are quite weird and complicated.

I also recommend [this blog](https://blog.greglow.com/2019/05/13/t-sql-101-17-paginating-rows-returned-from-sql-server-t-sql-queries/) for everyone who needs to write T-SQL.

Hope this helps!
