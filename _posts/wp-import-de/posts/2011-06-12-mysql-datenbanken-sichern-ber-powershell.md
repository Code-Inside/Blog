---
layout: post
title: "MySQL Datenbanken sichern über Powershell"
date: 2011-06-12 00:57
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Backup, MySQL, Powershell]
language: de
---
{% include JB/setup %}
<p>Ich glaube es gibt keinen Zweifel, dass ein Backup immer eine gute Idee ist. Wer eine MySQL Datenbank nutzt, der kann dieses Backup natürlich mit Bordmitteln sichern oder auch über die Powershell erstellen lassen. </p><!--more--><p><strong><u>MySQL Datenbanken manuell sichern (mysqldump)</u></strong></p> <p>Um ein Dump (ein Backup) der gesamten Datenbank (oder nur Teile davon) ohne Powershell o.Ä. anzulegen, wird bei der Installation das Programm “mysqldump” mit ausgeliefert (Installationspfad auf Windows: C:\Program Files\MySQL\MySQL Server 5.5\bin\mysqldump.exe)</p> <p>Die wichtigstens Informationen über dieses Tool liefert wahrscheinlich die MySQL Doku: <a href="http://dev.mysql.com/doc/refman/5.1/de/mysqldump.html">mysqldump</a></p> <p>Dieses Programm wird später noch wichtig, wenn wir das Backup wieder einspielen wollen.</p> <p><strong><u>MySQL Datenbanken mit Powershell sichern</u></strong></p> <p>Das Vorgehen (und das Script) entspricht auf den <a href="http://www.whiteleafnetworks.com/knowledgebase/article/68/default.aspx">tollen Knowledge-Base Artikel auf dieser Seite</a> – ich werde also nur kurz mein Vorgehen wiedergeben.</p> <p><strong>Voraussetzungen</strong></p> <p>- Powershell (ab Win 2008 mit dabei)<br>- Den MySQL .NET Connector (gibt es z.B. hier <a title="http://www.mysql.de/products/connector/" href="http://www.mysql.de/products/connector/">http://www.mysql.de/products/connector/</a> )<br>(- mysqldump, das sollte allerdings ohnehin da sein).</p> <p><strong>Das Script</strong></p> <p>Das Powershell Script ist zu 99% <a href="http://www.whiteleafnetworks.com/knowledgebase/article/69/default.aspx">dieses hier</a>, allerdings hatte ich einen <a href="http://forum.percona.com/index.php/t/1830/">Bug</a> (warum er bei mir auftrat und in seinem Script nicht keine Ahnung) und hatte entsprechend das Script angepasst. </p> <p>Die ersten drei Einstellungen geben die Verbindungsdaten wieder. Der “Backupstorefolder” ist ein Ordner (welcher vorher angelegt werden muss!), in dem die MySQL Dumps gespeichert werden.</p> <p>Es muss zudem (jedenfalls war es bei mir so) der Pfad zur mysqldump.exe Applikation angegeben werden.</p> <p>Das Script geniert SQLs nach dem Schema “WOCHENTAG_Datenbank” und zusätzlich immer noch ein “latest_Datenbank” – die “latest_Datenbank” Files kann man also auch woanders sichern wenn man das möchte.</p> <p>Das komplette Script:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:483869e5-e446-44c1-bf27-ac042a3ab1fb" class="wlWriterEditableSmartContent"><pre name="code" class="c#"># MySQL Database Backup Script
# -----------------------------
#
# This script will query a specified MySQL database and then create .sql backup files
# of all located databases.
#
# Use of this script is done entirely at your own risk.  No guarantee either direct
# or indirect is implied regarding the security, stability, reliability, impact or
# performance of this script.
#
# To configure this script, alter the values below.  Please do make any direct alterations
# to the script coding as this may result in undesired performance.
#

# Core settings - you will need to set these
$mysql_server = "localhost"
$mysql_user = "USER"
$mysql_password = "PASSWORD"
$backupstorefolder= "C:\_backup\"

# Extended Settings - you may not need to set these
$pathtomysqldump = "C:\Program Files\MySQL\MySQL Server 5.5\bin\mysqldump.exe"
$latestbackupfolder = "C:\_backup\"



#--------------------------------------------------------

# Determine Today's Date Day (monday, tuesday etc)
$gd = get-date
$dayofweek = [string] $gd.DayOfWeek


# Connect to MySQL database 'information_schema'
[system.reflection.assembly]::LoadWithPartialName("MySql.Data")
$cn = New-Object -TypeName MySql.Data.MySqlClient.MySqlConnection
$cn.ConnectionString = "SERVER=$mysql_server;DATABASE=information_schema;UID=$mysql_user;PWD=$mysql_password"
$cn.Open()

# Query MySQL 
$cm = New-Object -TypeName MySql.Data.MySqlClient.MySqlCommand
$sql = "SELECT DISTINCT CONVERT(SCHEMA_NAME USING UTF8) AS dbName, CONVERT(NOW() USING UTF8) AS dtStamp FROM SCHEMATA ORDER BY dbName ASC"
$cm.Connection = $cn
$cm.CommandText = $sql
$dr = $cm.ExecuteReader() 

# Loop through MySQL Records
while ($dr.Read())
{
    # Start By Writing MSG to screen
    $dbname = [string]$dr.GetString(0)
    write-host "Backing up database: " $dr.GetString(0)
    
    # Set backup filename and check if exists, if so delete existing
    $backupfilename = $dayofweek + "_" + $dr.GetString(0) + ".sql"
    $backuppathandfile = $backupstorefolder + "" + $backupfilename
    If (test-path($backuppathandfile)) 
    {
        write-host "Backup file '" $backuppathandfile "' already exists.  Existing file will be deleted"
        Remove-Item $backuppathandfile
    }

    # Invoke backup Command. /c forces the system to wait to do the backup
    cmd /c " `"$pathtomysqldump`" --single-transaction -h $mysql_server -u $mysql_user -p$mysql_password $dbname &gt; $backuppathandfile "
    If (test-path($backuppathandfile)) 
    {
        write-host "Backup created.  Presence of backup file verified"
    }
    
    # Handle LatestBackup functionality
    If (test-path($backuppathandfile)) 
    {
        $latestbackupfilenameandpath = $latestbackupfolder + "latest_" + $dbname + ".sql"
        &amp;cmd /c "copy /y `"$backuppathandfile`" `"$latestbackupfilenameandpath`" "
        write-host "Backup file copied to latestbackup folder" 
    }

    # Write Space
    write-host " "
}
$cn.Close()

# END OF SCRIPT</pre></div>
<p>&nbsp;</p>
<h2></h2>
<p><strong><u>MySQL Datenbanken Dump wieder einspielen</u></strong></p>
<p>Hierbei muss man über die CMD gehen und der mysql.exe (ebenfalls im bin Verzeichnis der MySQL Installation) nach diesem Schema den SQL Dump übergeben. Die Datenbank muss vorher existieren (CREATE Database …)</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:eee7cdbd-54da-46d3-87bb-cc14567816bd" class="wlWriterEditableSmartContent"><pre name="code" class="c#">mysql -u dbusername -p databasename &lt; C:\path\to\backupname.sql</pre></div>
<p>&nbsp;</p>
<p>Das fertige Powershell kann man, wie z.B. in dem <a href="http://www.whiteleafnetworks.com/knowledgebase/article/68/default.aspx">ursprünglichen Artikel</a> über einen Scheduled Task starten lassen etc.</p>
<p>Als Tipp: Probiert vorher aus, ob eure Backup Strategie wirklich funktioniert <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-de/wlEmoticon-winkingsmile.png"></p>
