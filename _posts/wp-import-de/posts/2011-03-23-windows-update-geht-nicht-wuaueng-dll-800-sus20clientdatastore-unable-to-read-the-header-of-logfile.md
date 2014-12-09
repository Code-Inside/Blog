---
layout: post
title: "Windows Update geht nicht? “wuaueng.dll (800) SUS20ClientDataStore: Unable to read the header of logfile”"
date: 2011-03-23 22:15
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Fix, Windows Server]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1215.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb395.png" width="208" height="130" /></a> </p>  <p>Gerade habe ich einen frischen Windows Server 2008 R2 bekommen und wollte erst einmal Windows Updates einspielen... allerdings ging das Windows Update Fenster in der Verwaltung nicht auf... im Log viele Fehler - und nu?</p>  <p><strong>Fehlermeldung</strong></p>  <p>Es ist immer ein schlechtes Zeichen wenn im Log Fehler auftauchen... Folgende Fehlermeldung:</p>  <p>"wuaueng.dll (800) SUS20ClientDataStore: Unable to read the header of logfile C:\Windows\SoftwareDistribution\DataStore\Logs\edb.log. Error -546.” </p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1216.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb396.png" width="464" height="88" /></a> </p>  <p><strong>Problemlösung</strong></p>  <p>Die Lösung habe ich <a href="http://answers.microsoft.com/en-us/windows/forum/windows_other-windows_update/fresh-windows-7-installation-windows-update-error/16a05548-6f6c-4d86-b5cb-f8abae5afe58">hier</a> gefunden. Grund war: Das temporäre Windows Update Verzeichnis "%windir%/SoftwareDistribution” war wohl korrupt und ich musste den Ordner löschen um dann Windows Update neu anzustoßen. Windows Update erstellt das Verzeichnis neu und gut :)</p>  <p><strong>Schritte:</strong></p>  <ol>   <li>In der CMD "net stop WuAuServ” eingeben - damit wird der Windows Update Dienst beendet</li>    <li>Zum %windir&quot;% gehen (typisch C:/Windows/) </li>    <li>Den Ordner "SoftwareDistribution” irgendwie umbenennen (kann hinterher auch gelöscht werden)</li>    <li>in der CMD "net start WuAuServ” eingeben</li>    <li>Windows Update starten und freuen :)</li> </ol>
