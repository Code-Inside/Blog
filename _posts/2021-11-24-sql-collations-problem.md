---
layout: post
title: "SQL collation problems"
description: "'Cannot resolve the collation conflict between Latin1_General_CI_AS and SQL_Latin1_General_CP1_CI_AS...'"
date: 2021-11-24 23:45
author: Robert Muehsig
tags: [MS SQL Server]
language: en
---

{% include JB/setup %}

This week I deployed a new feature and tried it on different SQL databases and was a bit suprised that on one database this error message came up:

```
Cannot resolve the collation conflict between "Latin1_General_CI_AS" and "SQL_Latin1_General_CP1_CI_AS" in the equal to operation.
```

This was strange, because - at least in theory - all databases have the same schema and I was sure that each database had the same collation setting.

## Collations on columns

Well... my theory was wrong and this SQL statement told me that "some" columns had a different collation. 

```
select sc.name, sc.collation_name from sys.columns sc
inner join sys.tables t on sc.object_id=t.object_id
where t.name='TABLENAME'
```

As it turns out, some columns had the collation `Latin1_General_CI_AS` and some had `SQL_Latin1_General_CP1_CI_AS`. I'm still not sure why, but I needed to do something.

## How to change the collation 

To change the collation you can execute something like this:

```
ALTER TABLE MyTable
ALTER COLUMN [MyColumn] NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS
```

Unfortunately there are restrictions and you can't change the collation if the column is referenced by any one of the following:

* A computed column
* An index
* Distribution statistics, either generated automatically or by the CREATE STATISTICS statement
* A CHECK constraint
* A FOREIGN KEY constraint

__Be aware:__ If you are not in control of the collation or if the collation is "fine" and you want to do this operation anyway, there might be a way to specify the collation in the SQL query.

For more information you might want to check out this Microsoft Docs "[Set or Change the Column Collation](https://docs.microsoft.com/en-us/sql/relational-databases/collations/set-or-change-the-column-collation?view=sql-server-ver15)"

Hope this helps!