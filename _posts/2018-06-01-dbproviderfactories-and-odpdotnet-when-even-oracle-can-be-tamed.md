---
layout: post
title: "DbProviderFactories & ODP.NET: When even Oracle can be tamed"
description: "Accessing Oracle from .NET can be a pain, but it is easier than you might think with the right provider."
date: 2018-06-01 18:00
author: Robert Muehsig
tags: [ADO.NET, MySql, Oracle, SQL, MSSQL]
language: en
---
{% include JB/setup %}

# Oracle and .NET: Tales from the dark ages

Each time when I tried to load data from an Oracle database it was a pretty terrible experience. 

I remember that I struggle to find the right Oracle driver and even when everything was installed the strange TNS ora config file popped up and nothing worked. 

# It can be simple...

2 weeks ago I had the pleasure to load some data from a Oracle database and discovered something beautiful: Actually, I can be pretty simple today.

# The way to success:

__1. Just ignore the [System.Data.OracleClient-Namespace](https://msdn.microsoft.com/en-us/library/system.data.oracleclient(v=vs.110).aspx)__

The implementation is pretty old and if you go this route you will end up with the terrible "Oracle driver/tns.ora"-chaos mentioned above.

__2. Use the [Oracle.ManagedDataAccess](https://www.nuget.org/packages/Oracle.ManagedDataAccess/):__ 

Just install the official NuGet package and you are done. The single .dll contains all the bits to connect to an Oracle database. __No__ driver installation additional software is needed. Yay!

The NuGet package will add some config entries in your web.config or app.config. I will cover this in the section below.

__3. Use sane ConnectionStrings:__ 

Instead of the wild Oracle TNS config stuff, just use (a more or less) sane ConnectionString. 

You can either just use the same configuration you would normally do in the TNS file, like [this](https://www.connectionstrings.com/oracle-data-provider-for-net-odp-net/using-odpnet-without-tnsnamesora/
):

    Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=MyHost)(PORT=MyPort)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=MyOracleSID)));User Id=myUsername;Password=myPassword;

Or use the even simpler ["easy connect name schema"](http://www.oracle.com/technetwork/database/enterprise-edition/oraclenetservices-neteasyconnect-133058.pdf) like this:

    Data Source=username/password@myserver//instancename;

# DbProviderFactories & ODP.NET

As I mentioned earlier after the installation your web or app.config might look different.

The most interesting addition is the registration in the DbProviderFactories-section:

```xml
...
<system.data>
    <DbProviderFactories>
      <remove invariant="Oracle.ManagedDataAccess.Client"/>
      <add name="ODP.NET, Managed Driver" invariant="Oracle.ManagedDataAccess.Client" description="Oracle Data Provider for .NET, Managed Driver"
          type="Oracle.ManagedDataAccess.Client.OracleClientFactory, Oracle.ManagedDataAccess, Version=4.122.1.0, Culture=neutral, PublicKeyToken=89b483f429c47342"/>
    </DbProviderFactories>
  </system.data>
...
```

I covered this topic a while ago in an [older blogpost](https://blog.codeinside.eu/2016/12/31/dbproviderfactory-write-database-agnostic-adonet-code/), but to keep it simple: __It also works for Oracle!__

```csharp
		private static void OracleTest()
        {
            string constr = "Data Source=localhost;User Id=...;Password=...;";

            DbProviderFactory factory = DbProviderFactories.GetFactory("Oracle.ManagedDataAccess.Client");

            using (DbConnection conn = factory.CreateConnection())
            {
                try
                {
                    conn.ConnectionString = constr;
                    conn.Open();

                    using (DbCommand dbcmd = conn.CreateCommand())
                    {
                        dbcmd.CommandType = CommandType.Text;
                        dbcmd.CommandText = "select name, address from contacts WHERE UPPER(name) Like UPPER('%' || :name || '%') ";

                        var dbParam = dbcmd.CreateParameter();
                        // prefix with : possible, but @ will be result in an error
                        dbParam.ParameterName = "name";
                        dbParam.Value = "foobar";

                        dbcmd.Parameters.Add(dbParam);

                        using (DbDataReader dbrdr = dbcmd.ExecuteReader())
                        {
                            while (dbrdr.Read())
                            {
                                Console.WriteLine(dbrdr[0]);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    Console.WriteLine(ex.StackTrace);
                }
            }
        }
```

# MSSQL, MySql and Oracle - via DbProviderFactories

The above code is a snippet from my larger sample demo covering __MSSQL__, __MySQL__ and __Oracle__. If you are interested just check this demo on [__GitHub__](https://github.com/Code-Inside/Samples/tree/master/2018/OracleMySqlMsSqlViaGenericSql).

Each SQL-Syntax teats parameter a bit different, so make sure you use the correct syntax for your target database.

# Bottom line

Accessing a Oracle database from .NET doesn't need to be a pain nowadays.

Be aware that the ODP.NET provider might surface higher level APIs to work with Oracle databases. The dbProviderfactory-approach helped us for our simple "just load some data"-scenario.

Hope this helps.
