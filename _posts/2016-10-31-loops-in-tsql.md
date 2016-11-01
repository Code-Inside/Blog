---
layout: post
title: "Writing loops in T-SQL"
description: "This blogposts shows how to use CURSORS in T-SQL to iterate over results in T-SQL."
date: 2016-10-31 22:15
author: Robert Muehsig
tags: [T-SQL,SQL]
language: en
---
{% include JB/setup %}

The topic is quite old, but I found it really helpful, so be warned.

## Scenario: Iterate over a result set and insert it in a new table in T-SQL

I had to write a SQL migration script to move date from an old table into a new table with a new primary key.

*Update! I discovered that my problem would have been solved with a much simpler SQL script (INSERT INTO x ...(SELECT ... FROM Y)). So my example here is pretty dumb - sorry if this confuses you, but I will keep the blogpost to show the mechanics. Thanks Mark!*

Here was/is my resulting script using __[T-SQL Cursors](https://msdn.microsoft.com/en-us/library/ms180169.aspx)__:

    DECLARE @TemplateId as uniqueidentifier;
    DECLARE @UserId as uniqueidentifier;
    
    DECLARE @OldTemplateFavCursor as CURSOR;
    
    SET @OldTemplateFavCursor = CURSOR FOR
    SELECT UserTemplate.[Template_Id], UserTemplate.[User_Id] FROM UserTemplate;
     
    OPEN @OldTemplateFavCursor;
    FETCH NEXT FROM @OldTemplateFavCursor INTO @TemplateId, @UserId;
     
    WHILE @@FETCH_STATUS = 0
    BEGIN
     INSERT INTO dbo.[UserFavoriteTemplate]
               ([Id]
               ,[TemplateId]
               ,[UserId])
         VALUES
               (NEWID()
               ,@TemplateId
               ,@UserId)
    
    FETCH NEXT FROM @OldTemplateFavCursor INTO @TemplateId, @UserId;
    END
     
    CLOSE @OldTemplateFavCursor;
    DEALLOCATE @OldTemplateFavCursor;
	
## Explanation

In the first couple of lines we just declare some variables. 

In this particular script we want to move the "TemplateId" & "UserId" from the table "UserTemplate" into the target table "UserFavoriteTemplate", but I also want to store an additional GUID as Id.

This line will select our current data into the cursor:

    SET @OldTemplateFavCursor = CURSOR FOR SELECT UserTemplate.[Template_Id], UserTemplate.[User_Id] FROM UserTemplate;

With the "OPEN", "FETCH NEXT" and "CLOSE" we move the cursor and inside the "WHILE" we can do our migration.

The syntax seems (from a C# perspective) strange, but works well for this scenario.

## Performance consideration

I wouldn't recommend this approach for large scale migrations or actual production code because I heard that the performance is not as great as some clever joins or other T-SQL magic.

## Make sure you really need this

You can do some clever joins with SQL - make sure you really need this approach. My example here is not a clever one, so use this feature wisely. (again - thanks to Mark for the comment!)

__Thanks Christopher for your help!__
