---
layout: post
title: "Select random rows"
description: "How to select random rows with SQL?"
date: 2021-12-06 23:45
author: Robert Muehsig
tags: [MS SQL Server]
language: en
---

{% include JB/setup %}

Let's say we have a SQL table and want to retrieve 10 rows randomly - how would you do that? Although I have been working with SQL for x years, I have never encountered that problem. The solution however is quite "simple" (at least if you don't be picky how we define "randomness" and if you try this on millions of rows):

## ORDER BY NEWID()

The most boring way is to use the `ORDER BY NEWID()` clause:

```
SELECT TOP 10 FROM Products ORDER BY NEWID()
```

This works, but if you do that on "large" datasets you might hit performance problems (e.g. more on that [here](https://docs.microsoft.com/en-us/previous-versions/software-testing/cc441928(v=msdn.10)?redirectedfrom=MSDN))

## TABLESAMPE

The SQL Server implements the `Tablesample clause` which was new to me. It seems to perform much bettern then the `ORDER BY NEWID()` clause, but behaves a bit weird. With this clause you can specify the "sample" from a table. The size of the sample can be specified as `PERCENT` or `ROWS` (which are then converted to percent internally).

Syntax:

```
SELECT TOP 10 FROM Products TABLESAMPLE (25 Percent)
SELECT TOP 10 FROM Products TABLESAMPLE (100 ROWS)
```

The weird part is that the given number might not match the number of rows of your result. You might got more or less results and if our tablesample is too small you might even got nothing in return. There are some clever ways to work around this (e.g. using the `TOP 100` statement with a much larger tablesample clause to get a guaranteed result set), but it feels "strange".
If you hit limitations with the first solution you might want to read more on [this blog](https://www.mssqltips.com/sqlservertip/1308/retrieving-random-data-from-sql-server-with-tablesample/) or in the [Microsoft Docs](https://docs.microsoft.com/en-us/sql/t-sql/queries/from-transact-sql?view=sql-server-ver15#tablesample-clause).

## Stackoverflow

Of course there is a great [Stackoverflow thread](https://stackoverflow.com/questions/848872/select-n-random-rows-from-sql-server-table) with even wilder solutions. 

Hope this helps!