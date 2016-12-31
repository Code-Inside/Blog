---
layout: post
title: "DbProviderFactories: Write database agnostic ADO.NET code"
description: "If you need to write 'low-level' database code and don't know the target database, the DbProviderFactory might help you."
date: 2016-12-31 14:00
author: Robert Muehsig
tags: [DbProviderFactory, ADO.NET, SQL]
language: en
---
{% include JB/setup %}

Recently I needed to write a module that needs to connect to a wide range of SQL-DBs, e.g. MySQL, MS SQL, Oracle etc.

## Problem: Most providers will use their concret classes

If you look at the C# example on the [MySQL dev page](https://dev.mysql.com/doc/connector-net/en/connector-net-programming-connecting-open.html) you will see the MsSql-Namespace and classes:

    MySql.Data.MySqlClient.MySqlConnection conn;
    string myConnectionString;
    
    myConnectionString = "server=127.0.0.1;uid=root;" +
        "pwd=12345;database=test;";
    
    try
    {
        conn = new MySql.Data.MySqlClient.MySqlConnection();
        conn.ConnectionString = myConnectionString;
        conn.Open();
    }
    catch (MySql.Data.MySqlClient.MySqlException ex)
    {
        MessageBox.Show(ex.Message);
    }

The same classes will probably not work for a MS SQL database.
	
## "Solution": Use the DbProviderFactories

For example if you install the [MySql-NuGet package](https://www.nuget.org/packages/MySql.Data) you will also get this little enhancement to you app.config:

    <system.data>
      <DbProviderFactories>
        <remove invariant="MySql.Data.MySqlClient" />
        <add name="MySQL Data Provider" invariant="MySql.Data.MySqlClient" description=".Net Framework Data Provider for MySQL" type="MySql.Data.MySqlClient.MySqlClientFactory, MySql.Data, Version=6.9.9.0, Culture=neutral, PublicKeyToken=c5687fc88969c44d" />
      </DbProviderFactories>
    </system.data>

Now we can get a reference to the MySql client via the DbProviderFactories:

    using System;
    using System.Data;
    using System.Data.Common;
    
    namespace DbProviderFactoryStuff
    {
        class Program
        {
            static void Main(string[] args)
            {
                try
                {
                    Console.WriteLine("All registered DbProviderFactories:");
                    var allFactoryClasses = DbProviderFactories.GetFactoryClasses();
    
                    foreach (DataRow row in allFactoryClasses.Rows)
                    {
                        Console.WriteLine(row[0] + ": " + row[2]);
                    }
    
                    Console.WriteLine();
                    Console.WriteLine("Try to access a MySql DB:");
    
                    DbProviderFactory dbf = DbProviderFactories.GetFactory("MySql.Data.MySqlClient");
                    using (DbConnection dbcn = dbf.CreateConnection())
                    {
                        dbcn.ConnectionString = "Server=localhost;Database=testdb;Uid=root;Pwd=Pass1word;";
                        dbcn.Open();
                        using (DbCommand dbcmd = dbcn.CreateCommand())
                        {
                            dbcmd.CommandType = CommandType.Text;
                            dbcmd.CommandText = "SHOW TABLES;";
    
                            // parameter...
                            //var foo = dbcmd.CreateParameter();
                            //foo.ParameterName = "...";
                            //foo.Value = "...";
    
                            using (DbDataReader dbrdr = dbcmd.ExecuteReader())
                            {
                                while (dbrdr.Read())
                                {
                                    Console.WriteLine(dbrdr[0]);
                                }
                            }
                        }
                    }
                }
                catch (Exception exc)
                {
                    Console.WriteLine(exc.Message);
                }
    
                Console.ReadLine();
    
            }
        }
    }

The most important line is this one:

    DbProviderFactory dbf = DbProviderFactories.GetFactory("MySql.Data.MySqlClient");
	
Now with the [__DbProviderFactory__](https://msdn.microsoft.com/en-us/library/system.data.common.dbproviderfactory(v=vs.110).aspx) from the MySql client we can access the MySql database without using any MySql-specific classes.

There are a couple of "in-built" db providers registered, like the MS SQL provider or ODBC stuff.

The above code will output something like this:

    All registered DbProviderFactories:
    Odbc Data Provider: System.Data.Odbc
    OleDb Data Provider: System.Data.OleDb
    OracleClient Data Provider: System.Data.OracleClient
    SqlClient Data Provider: System.Data.SqlClient
    Microsoft SQL Server Compact Data Provider 4.0: System.Data.SqlServerCe.4.0
    MySQL Data Provider: MySql.Data.MySqlClient
	
## Other solutions

Of course there are other solutions - some OR-Mapper like the EntityFramework have a provider model which might also work, but this one here is a pretty basic approach.

## SQL Commands

The tricky bit here is that you need to make sure that your SQL commands work on your database - this is __not a silver bullet__, it __just lets you connect and execute SQL commands to any 'registered' database__. 

The full demo code is also available on [__GitHub__](https://github.com/Code-Inside/Samples/tree/master/2016/DbProviderFactoryStuff).

Hope this helps.