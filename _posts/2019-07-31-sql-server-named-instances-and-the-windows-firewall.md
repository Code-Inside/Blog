---
layout: post
title: "SQL Server, Named Instances & the Windows Firewall"
description: "Or how to fix 'A network-related or instance-specific error occurred while establishing a connection to SQL Server.'"
date: 2019-07-31 23:45
author: Robert Muehsig
tags: [SQL Server, Firewall]
language: en
---

{% include JB/setup %}

# The problem

*"Cannot connect to sql\instance. A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: SQL Network Interfaces, error: 26 - Error Locating Server/Instance Specified) (Microsoft SQL Server, Error: -1)"*

Let's say we have a system with a running SQL Server (Express or Standard Edition - doesn't matter) and want to connect to this database from another machine. The chances are high that you will see the above error message.

__Be aware:__ You can customize more or less anything, so this blogposts does only cover a very "common" installation.

I struggled last week with this problem and I learned that this is a pretty "old" issue. To enlighten my dear readers I made the following checklist:

# Checklist:

 * Does the SQL Server allow remote connections?
 * Does the SQL Server allow your authentication schema of choice (Windows or SQL Authentication)?
 * Check the "SQL Server Configuration Manager" if the needed TCP/IP protocol is enabled for your SQL Instance.
 * Check if the "SQL Server Browser"-Service is running
 * Check your Windows Firewall (see details below!)
 
## Windows Firewall settings:

Per default SQL Server uses TCP Port 1433 which is the minimum requirement without any special needs - use this command:

    netsh advfirewall firewall add rule name = SQLPort dir = in protocol = tcp action = allow localport = 1433 remoteip = localsubnet profile = DOMAIN,PRIVATE,PUBLIC

If you use __named instances__ we need (at least) two additional ports:

    netsh advfirewall firewall add rule name = SQLPortUDP dir = in protocol = udp action = allow localport = 1434 remoteip = localsubnet profile = DOMAIN,PRIVATE,PUBLIC
	
This UDP Port 1434 is used to query the real TCP port for the named instance. 

Now the most important part: The SQL Server will use a (kind of) random dynamic port for the named instance. To avoid this behavior (which is really a killer for Firewall settings) you can set a fixed port in the __SQL Server Configuration Manager__. 

    SQL Server Configuration Manager -> Instance -> TCP/IP Protocol (make sure this is "enabled") -> *Details via double click* -> Under IPAll set a fixed port under "TCP Port", e.g. 1435
	
After this configuration, allow this port to communicate to the world with this command:

    netsh advfirewall firewall add rule name = SQLPortInstance dir = in protocol = tcp action = allow localport = 1435 remoteip = localsubnet profile = DOMAIN,PRIVATE,PUBLIC
	
(Thanks [Stackoverflow](https://dba.stackexchange.com/a/107766)!)

Check the [official Microsoft Docs](https://docs.microsoft.com/en-us/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access) for further information on this topic, but these commands helped me to connect to my SQL Server.
	
The "dynamic" port was my main problem - after some hours of Googling I found the answer on Stackoverflow and I could establish a connection to my SQL Server with the SQL Server Management Studio.
	
Hope this helps!
