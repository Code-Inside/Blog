---
layout: post
title: "SQL ConnectionString: Encrypt & Trust Server Certificate="
description: "TIL something about SQL Encryption"
date: 2024-07-22 23:59
author: Robert Muehsig
tags: [.NET, SQL, TIL]
language: en
---

{% include JB/setup %}

*This is more of a "Today-I-Learned" post and not a "full-blown How-To article." If something is completely wrong, please let me know - thanks!* 

In our product, we store all data in an MS SQL database. One of our clients had issues with the SQL connection, and I want to share what I learned about SQL Encryption and how (some) properties of the Connection String affect the behavior.

# Basic SQL Connection String

In general, we have a pretty easy setup:

Our application reads a typical connection string that looks like this `Data Source=your-sql-server.yourcorp.local;Initial Catalog=database_x;User ID=username;Password=password_here;MultipleActiveResultSets=True;Encrypt=False` or (for Windows Authentication) `Integrated Security=true` instead of `User ID=username;Password=password_here`, and uses the (new) Microsoft.Data.SqlClient to connect to the database.

Let's look at all applied properties:

- [Data Source](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnectionstringbuilder.datasource?view=sqlclient-dotnet-standard-5.2) points to the actual network address of the SQL Server instance.
- [Initial Catalog](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnectionstringbuilder.initialcatalog?view=sqlclient-dotnet-standard-5.2) points to the actual database.
- [MultipleActiveResultSets](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnectionstringbuilder.multipleactiveresultsets?view=sqlclient-dotnet-standard-5.2) is a good topic for another blogpost. I always enabled it in the past because of some Entity Framework issues, but it seems [MARS](https://learn.microsoft.com/en-us/dotnet/framework/data/adonet/sql/multiple-active-result-sets-mars) is only needed and useful in certain [scenarios](https://stackoverflow.com/questions/59607616/when-should-i-use-multipleactiveresultsets-true-when-working-with-asp-net-core-3).
- The auth part is handled via [IntegratedSecurity](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnectionstringbuilder.integratedsecurity?view=sqlclient-dotnet-standard-5.2) or [User-Id](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnectionstringbuilder.userid?view=sqlclient-dotnet-standard-5.2)

Since [Version 4.0](https://github.com/dotnet/SqlClient/blob/main/release-notes/4.0/4.0.0.md#breaking-changes) of the Microsoft.Data.SqlClient the [Encrypt](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnectionstringbuilder.encrypt?view=sqlclient-dotnet-standard-5.2) property defaults to __true__ instead of __false__, and now we are entering the field of encryption...

# Encryption

We usally use `Encrypt=False`, because in most cases, there is no proper certificate installed on the SQL Server - at least this is our experience with our clients. If a client has a proper setup, we recommend using it, of course, but most of the time there is none.

With `Encrypt=True`, the data between the client and the server is TLS encrypted (and this is a good thing, and the breaking change therefore had a good intention).

*If you are interested how to set it up, this might be a good starting point for you: [Configure SQL Server Database Engine for encrypting connections](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-sql-server-encryption?view=sql-server-ver15)*

In some cases, your client might not be able to trust the server certificate (e.g. there is just a self-signed cert installed on the SQL server). Then you can disable the certification validation via [TrustServerCertification](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnectionstringbuilder.trustservercertificate?view=sqlclient-dotnet-standard-5.2), but this __shouldn't__ be used (at least in production) or handled with care. If the certificate doesn't match the name of the `Data Source`, then you can use [HostNameInCertificate](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnectionstringbuilder.hostnameincertificate?view=sqlclient-dotnet-standard-5.2).

# What have I learned?

I already knew about `Encrypt=True` or `Encrypt=False`, but the behavior of `TrustServerCertification` (and when to use it) was new for me. This [Stackoverflow-question](https://stackoverflow.com/questions/3674160/using-encrypt-yes-in-a-sql-server-connection-string-provider-ssl-provider) helped me a lot to discover it.

Hope this helps!
