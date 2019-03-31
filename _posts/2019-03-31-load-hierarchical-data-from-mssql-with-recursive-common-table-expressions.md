---
layout: post
title: "Load hierarchical data from MSSQL with recursive common table expressions"
description: "Designing a hierachie inside MS SQL can be painfull, but at least there is a way to load this data in a fast way."
date: 2019-03-31 23:45
author: Robert Muehsig
tags: [MS SQL, T-SQL]
language: en
---

{% include JB/setup %}

# Scenario

We have a pretty simple scenario: We have a table with a simple Id + ParentId schema and some demo data in it. I have seen this design quite a lot in the past and in the relational database world this is the obvious choice.

![x]({{BASE_PATH}}/assets/md-images/2019-03-31/demo.png "Demo table")

# Problem

Each data entry is really simple to load or manipulate. Just load the target element and change the ParentId for a move action etc.. A more complex problem is how to load a whole "data tree".
Let's say I want to load all children or parents of a given Id. You could load everything, but if your dataset is large enough, this operation will work poorly and might kill your database.

Another naive way would be to query this with code from a client application, but if your "tree" is big enough, it will consume lots of resources, because for each "level" you open a new connection etc.

# Recursive Common Table Expressions!

Our goal is to load the data in one go as effective as possible - __without using Stored Procedures(!)__. In the Microsoft SQL Server world we have this handy feature called "[__common table expresions (CTE)__](https://docs.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql)". 
A common table expression can be seen as a function inside a SQL statement. This function can be invoked by itself and now we can call this a "recursive common table expression". 

The syntax itself is a bit odd, but works well and you can enhance it with JOINs from other tables.

## Scenario A: From child to parent

Let's say you want to go the tree upwards from a given Id:

    WITH RCTE AS
        (
        SELECT anchor.Id as ItemId, anchor.ParentId as ItemParentId, 1 AS Lvl, anchor.[Name]
        FROM Demo anchor WHERE anchor.[Id] = 7
        
        UNION ALL
        
        SELECT nextDepth.Id  as ItemId, nextDepth.ParentId as ItemParentId, Lvl+1 AS Lvl, nextDepth.[Name]
        FROM Demo nextDepth
        INNER JOIN RCTE recursive ON nextDepth.Id = recursive.ItemParentId
        )
                                        
    SELECT ItemId, ItemParentId, Lvl, [Name]
    FROM RCTE as hierarchie

The *anchor.[Id] = 7* is our starting point and should be given as a SQL parameter. The *with* statement starts our function description, which we called "RCTE".
In the first select we just load everything from the target element. 
Note, that we add a "Lvl" property, which starts at 1. 
The *UNION ALL* is needed (at least we were not 100% if there are other options).
In the next line we are doing a join based on the *Id = ParentId* schema and we increase the "Lvl" property for each level. 
The last line inside the common table expression uses the "recursive" feature. 

Now we are done and can use the CTE like a normal table in our final statement.

Result:

![x]({{BASE_PATH}}/assets/md-images/2019-03-31/up.png "Child to Parent")

We now only load the "path" from the child entry up to the root entry.

If you ask why we introduce the "lvl" column:
With this column it is really easy see each "step" and it might come handy in your client application. 

## Scenario B: From parent to all descendants

With a small change we can do the other way around. Loading all descendants from a given id.

The logic itself is more or less identical, we changed only the *INNER JOIN RCTE ON ...*

    WITH RCTE AS
        (
        SELECT anchor.Id as ItemId, anchor.ParentId as ItemParentId, 1 AS Lvl, anchor.[Name]
        FROM Demo anchor WHERE anchor.[Id] = 2
        
        UNION ALL
        
        SELECT nextDepth.Id  as ItemId, nextDepth.ParentId as ItemParentId, Lvl+1 AS Lvl, nextDepth.[Name]
        FROM Demo nextDepth
        INNER JOIN RCTE recursive ON nextDepth.ParentId = recursive.ItemId
        )
                                        
    SELECT ItemId, ItemParentId, Lvl, [Name]
    FROM RCTE as hierarchie

Result:

![x]({{BASE_PATH}}/assets/md-images/2019-03-31/down.png "Parent to chid")

In this example we only load all children from a given id. If you point this to the "root", you will get everything except the "alternative root" entry.

# Conclusion

Working with trees in a relational database might not "feel" as good as in a document database, but it doesn't mean, that such scenarios needs to perform bad. We use this code at work for some bigger datasets and it works really well for us.

*Thanks to my collegue Alex - he discovered this wild T-SQL magic.*

Hope this helps!