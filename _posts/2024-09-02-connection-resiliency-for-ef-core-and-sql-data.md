---
layout: post
title: "Connection Resiliency for Entity Framework Core and SqlClient"
description: "Retry... retry... argh."
date: 2024-09-02 23:59
author: Robert Muehsig
tags: [Entity Framework Core, Cloud, SQL Azure, TIL]
language: en
---

{% include JB/setup %}

*This is more of a "Today-I-Learned" post and not a "full-blown How-To article." If something is completely wrong, please let me know - thanks!* 

If you work with SQL Azure you might find this familiar:

> Unexpected exception occurred: An exception has been raised that is likely due to a transient failure. Consider enabling transient error resiliency by adding 'EnableRetryOnFailure' to the 'UseSqlServer' call.

# EF Core Resiliency

The above error already shows a very simple attempt to "stabilize" your application. If you are using Entity Framework Core, this could look like this:

```
protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
{
    optionsBuilder
        .UseSqlServer(
            @"Server=(localdb)\mssqllocaldb;Database=EFMiscellanous.ConnectionResiliency;Trusted_Connection=True;ConnectRetryCount=0",
            options => options.EnableRetryOnFailure());
}
```

The [EnableRetryOnFailure-Method](https://learn.microsoft.com/en-us/dotnet/api/microsoft.entityframeworkcore.infrastructure.sqlserverdbcontextoptionsbuilder.enableretryonfailure?view=efcore-8.0) has a couple of options, like a retry count or the retry delay. 

If you don't use the `UseSqlServer`-method to configure your context, there are other ways to enable this behavior: [See Microsoft Docs](https://learn.microsoft.com/en-us/ef/core/miscellaneous/connection-resiliency)

# Microsoft.Data.SqlClient - Retry Provider

If you use the "plain" `Microsoft.Data.SqlClient` NuGet Package to connect to your database have a look at [Retry Logic Providers](https://learn.microsoft.com/en-us/sql/connect/ado-net/configurable-retry-logic?view=sql-server-ver16)

A basic implementation would look like this:

```
// Define the retry logic parameters
var options = new SqlRetryLogicOption()
{
    // Tries 5 times before throwing an exception
    NumberOfTries = 5,
    // Preferred gap time to delay before retry
    DeltaTime = TimeSpan.FromSeconds(1),
    // Maximum gap time for each delay time before retry
    MaxTimeInterval = TimeSpan.FromSeconds(20)
};

// Create a retry logic provider
SqlRetryLogicBaseProvider provider = SqlConfigurableRetryFactory.CreateExponentialRetryProvider(options);

// Assumes that connection is a valid SqlConnection object 
// Set the retry logic provider on the connection instance
connection.RetryLogicProvider = provider;
// Establishing the connection will retry if a transient failure occurs.
connection.Open();
```

You can set a `RetryLogicProvider` on a [Connection](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnection.retrylogicprovider?view=sqlclient-dotnet-standard-5.2) and on a [SqlCommand](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlcommand.retrylogicprovider?view=sqlclient-dotnet-standard-5.2).

# Some more links and tips

These two options seem to be the "low-level-entry-points".
Of course could you wrap each action with a library like [Polly](https://github.com/App-vNext/Polly).

During my research I found a good overview: [__Implementing Resilient Applications__](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/implement-resilient-applications/).

Hope this helps!
