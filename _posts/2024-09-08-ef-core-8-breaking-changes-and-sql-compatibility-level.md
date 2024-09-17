---
layout: post
title: "Entity Framework Core 8.0 Breaking Changes & SQL Compatibility Level"
description: "If you are moving to .NET 8, be aware of this breaking change..."
date: 2024-09-08 23:59
author: Robert Muehsig
tags: [Entity Framework Core, .NET Core 8]
language: en
---

{% include JB/setup %}

We recently switched from .NET 6 to .NET 8 and encountered the following Entity Framework Core error:

```
Microsoft.Data.SqlClient.SqlException: 'Incorrect syntax near the keyword 'WITH'....
```

The EF code uses the `Contains` method as shown below:

```
var names = new[] { "Blog1", "Blog2" };

var blogs = await context.Blogs
    .Where(b => names.Contains(b.Name))
    .ToArrayAsync();
```

Before .NET 8 this would result in the following Sql statement:

```
SELECT [b].[Id], [b].[Name]
FROM [Blogs] AS [b]
WHERE [b].[Name] IN (N'Blog1', N'Blog2')
```

... and with .NET 8 it uses the `OPENJSON` function, which is __not supported on older versions like SQL Server 2014 or if the compatibility level is below 130 (!)__

- See [this blogpost](https://devblogs.microsoft.com/dotnet/announcing-ef8-preview-4/) for more information about the `OPENJSON` change.

# The fix is "simple"

Ensure you're not using an unsupported SQL version __and__ that the `Compatibility Level` is at least on __level 130__.

If you can't change the system, then you could also enforce the "old" behavior with a setting like this (not recommended, because it is slower!)

```
...
.UseSqlServer(@"<CONNECTION STRING>", o => o.UseCompatibilityLevel(120));
```

# How to make sure your database is on Compatibility Level 130?

Run this statement to check the compatibility level:

```
SELECT name, compatibility_level FROM sys.databases;
``` 

We updated our test/dev SQL Server and then moved all databases to the latest version with this SQL statement:

```
DECLARE @DBName NVARCHAR(255)
DECLARE @SQL NVARCHAR(MAX)

-- Cursor to loop through all databases
DECLARE db_cursor CURSOR FOR
SELECT name
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb') -- Exclude system databases

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @DBName

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Construct the ALTER DATABASE command
    SET @SQL = 'ALTER DATABASE [' + @DBName + '] SET COMPATIBILITY_LEVEL = 150;'
    EXEC sp_executesql @SQL

    FETCH NEXT FROM db_cursor INTO @DBName
END

CLOSE db_cursor
DEALLOCATE db_cursor
```

# Check EF Core Breaking Changes

There are other breaking changes, but only the first one affected us: [Breaking Changes](https://learn.microsoft.com/en-us/ef/core/what-is-new/ef-core-8.0/breaking-changes#sqlserver-contains-compatibility)

Hope this helps!