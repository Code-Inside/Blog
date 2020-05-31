---
layout: post
title: "SqlBulkCopy for fast bulk inserts"
description: "TL;DR: If you want to import many rows in a MS SQL database use SqlBulkCopy"
date: 2020-05-31 23:30
author: Robert Muehsig
tags: [SqlBulkCopy, SQL, MS SQL, .NET]
language: en
---

{% include JB/setup %}

Within our product [OneOffixx](https://oneoffixx.com/) we can create a "full export" from the product database. Because of limitations with normal MS SQL backups (e.g. compatibility with older SQL databases etc.), we created our own export mechanic.
An export can be up to 1GB and more. This is nothing to serious and far from "big data", but still not easy to handle and we had some issues to import larger "exports". 
Our importer was based on a Entity Framework 6 implementation and it was really slow... last month we tried to resolve this and we are quite happy. Here is how we did it:

__TL;DR Problem:__

Bulk Insert with a Entity Framework based implementation is really slow. There is at least one NuGet package, which seems to help, but unfortunately we run into some obscure issues. This [Stackoverflow question highlights](https://stackoverflow.com/questions/5940225/fastest-way-of-inserting-in-entity-framework) some numbers and ways of doing it.

__SqlBulkCopy to the rescure:__

After my failed attempt to tame our EF implementation I discovered the [SqlBulkCopy](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/bulk-copy-operations-in-sql-server) operation. In .NET (Full Framework and .NET Standard!) the usage is simple via the ["SqlBulkCopy" class](https://docs.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlbulkcopy?view=dotnet-plat-ext-3.1).

Our importer looks more or less like this:

    using (var scope = new TransactionScope(TransactionScopeOption.RequiresNew, TimeSpan.FromMinutes(30), TransactionScopeAsyncFlowOption.Enabled))
    using (SqlBulkCopy bulkCopy = new SqlBulkCopy(databaseConnectionString))
        {
        var dt = new DataTable();
        dt.Columns.Add("DataColumnA");
        dt.Columns.Add("DataColumnB");
        dt.Columns.Add("DataColumnId", typeof(Guid));
    
        foreach (var dataEntry in data)
        {
            dt.Rows.Add(dataEntry.A, dataEntry.B, dataEntry.Id);
        }
    
        sqlBulk.DestinationTableName = "Data";
        sqlBulk.AutoMapColumns(dt);
        sqlBulk.WriteToServer(dt);
    
        scope.Complete();
        }

    public static class Extensions
        {
            public static void AutoMapColumns(this SqlBulkCopy sbc, DataTable dt)
            {
                sbc.ColumnMappings.Clear();
    
                foreach (DataColumn column in dt.Columns)
                {
                    sbc.ColumnMappings.Add(column.ColumnName, column.ColumnName);
                }
            }
        }       

Some notes:

* The TransactionScope is not required, but still nice.
* The SqlBulkCopy instance just needs the databaseConnectionString.
* A Datatable is needed and (I'm not sure why) all non crazy SQL datatypes are magically supported, but GUIDs needs to be typed explicitly. 
* Insert thousands of data in your dataTable, point the SqlBulkCopy to your destination table, map those columns and write the to the server.
* You can use the [same instance for multiple bulk](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/multiple-bulk-copy-operations) operations.
* There is also an Async implementation available. 

Only "downside": SqlBulkCopy is a table by table insert. You need to insert your data in the correct order if you have any db constraints in your schema.

__Result:__ 

We reduced the import from several minutes to seconds :)

Hope this helps!