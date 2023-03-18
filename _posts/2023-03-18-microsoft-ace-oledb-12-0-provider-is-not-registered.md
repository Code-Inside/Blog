---
layout: post
title: "How to fix: 'Microsoft.ACE.OLEDB.12.0' provider is not registered on the local machine"
description: "What year is it? A blast from the past."
date: 2023-03-18 23:55
author: Robert Muehsig
tags: [OLEDB]
language: en
---

{% include JB/setup %}

In our product we can interact with different datasource and one of these datasources was a Microsoft Access DB connected via `OLEDB`. This is really, really old, but still works, but on one customer machine we had this issue:

```
'Microsoft.ACE.OLEDB.12.0' provider is not registered on the local machine
```  

# Solution

If you face this issue, you need to install the provider from [here](https://www.microsoft.com/en-us/download/details.aspx?id=13255). 

__Be aware:__ If you have a different error, you might need to install the newer provider - this is labled as "2010 Redistributable", but still works with all those fancy Office 365 apps out there.

__Important:__ You need to install the provider in the correct bit version, e.g. if you run under x64, install the x64.msi.

The solution comes from this [Stackoverflow question](https://stackoverflow.com/questions/6649363/microsoft-ace-oledb-12-0-provider-is-not-registered-on-the-local-machine).

# Helper

The best tip from Stackoverflow was these powershell commands to check, if the provider is there or not:

```
(New-Object system.data.oledb.oledbenumerator).GetElements() | select SOURCES_NAME, SOURCES_DESCRIPTION 

Get-OdbcDriver | select Name,Platform
```

This will return something like this:

```
PS C:\Users\muehsig> (New-Object system.data.oledb.oledbenumerator).GetElements() | select SOURCES_NAME, SOURCES_DESCRIPTION

SOURCES_NAME               SOURCES_DESCRIPTION
------------               -------------------
SQLOLEDB                   Microsoft OLE DB Provider for SQL Server
MSDataShape                MSDataShape
Microsoft.ACE.OLEDB.12.0   Microsoft Office 12.0 Access Database Engine OLE DB Provider
Microsoft.ACE.OLEDB.16.0   Microsoft Office 16.0 Access Database Engine OLE DB Provider
ADsDSOObject               OLE DB Provider for Microsoft Directory Services
Windows Search Data Source Microsoft OLE DB Provider for Search
MSDASQL                    Microsoft OLE DB Provider for ODBC Drivers
MSDASQL Enumerator         Microsoft OLE DB Enumerator for ODBC Drivers
SQLOLEDB Enumerator        Microsoft OLE DB Enumerator for SQL Server
MSDAOSP                    Microsoft OLE DB Simple Provider


PS C:\Users\muehsig> Get-OdbcDriver | select Name,Platform

Name                                                   Platform
----                                                   --------
Driver da Microsoft para arquivos texto (*.txt; *.csv) 32-bit
Driver do Microsoft Access (*.mdb)                     32-bit
Driver do Microsoft dBase (*.dbf)                      32-bit
Driver do Microsoft Excel(*.xls)                       32-bit
Driver do Microsoft Paradox (*.db )                    32-bit
Microsoft Access Driver (*.mdb)                        32-bit
Microsoft Access-Treiber (*.mdb)                       32-bit
Microsoft dBase Driver (*.dbf)                         32-bit
Microsoft dBase-Treiber (*.dbf)                        32-bit
Microsoft Excel Driver (*.xls)                         32-bit
Microsoft Excel-Treiber (*.xls)                        32-bit
Microsoft ODBC for Oracle                              32-bit
Microsoft Paradox Driver (*.db )                       32-bit
Microsoft Paradox-Treiber (*.db )                      32-bit
Microsoft Text Driver (*.txt; *.csv)                   32-bit
Microsoft Text-Treiber (*.txt; *.csv)                  32-bit
SQL Server                                             32-bit
ODBC Driver 17 for SQL Server                          32-bit
SQL Server                                             64-bit
ODBC Driver 17 for SQL Server                          64-bit
Microsoft Access Driver (*.mdb, *.accdb)               64-bit
Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb) 64-bit
Microsoft Access Text Driver (*.txt, *.csv)            64-bit
```

Hope this helps! (And I hope you don't need to deal with these ancient technologies for too long 😅) 
