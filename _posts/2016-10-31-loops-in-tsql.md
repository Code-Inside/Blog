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

Here was/is my resulting script using __T-SQL Cursors__:

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

__Thanks Christopher for your help!__