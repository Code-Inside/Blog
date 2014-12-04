---
layout: post
title: "HowTo: Mehrere Dateien über die Powershell entpacken–Unzip mit Powershell"
date: 2011-07-31 23:52
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Powershell, Unzip]
language: de
---
{% include JB/setup %}
<p>Ich hatte einen Ordner in dem waren sehr viele Zip-Archive gespeichert. Diese wollte ich nun alle in ein Verzeichnis entpacken. Das geht (nach etwas suchen) mit der Powershell doch recht einfach und sollte selbsterklärend sein. Das Script stammt zu 100% von <a href="http://www.snowland.se/2010/06/01/unzip-multiple-files-via-powershell/">http://www.snowland.se/</a> (da ich nicht so ein guter Powershell Hacker bin <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile8.png"> )</p> <p>Achtung: Der Unzip Ordner muss bereits erstellt sein, ansonsten kommt ein Fehler.</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7e4b243c-c526-4b1e-8651-e718d15541c7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">PARAM (
    [string] $ZipFilesPath = "X:\Somepath\Full\Of\Zipfiles",
    [string] $UnzipPath = "X:\Somepath\to\extract\to"
)
 
$Shell = New-Object -com Shell.Application
$Location = $Shell.NameSpace($UnzipPath)
 
$ZipFiles = Get-Childitem $ZipFilesPath -Recurse -Include *.ZIP
 
$progress = 1
foreach ($ZipFile in $ZipFiles) {
    Write-Progress -Activity "Unzipping to $($UnzipPath)" -PercentComplete (($progress / ($ZipFiles.Count + 1)) * 100) -CurrentOperation $ZipFile.FullName -Status "File $($Progress) of $($ZipFiles.Count)"
    $ZipFolder = $Shell.NameSpace($ZipFile.fullname)
 
    $Location.Copyhere($ZipFolder.items(), 1040) # 1040 - No msgboxes to the user - http://msdn.microsoft.com/en-us/library/bb787866%28VS.85%29.aspx
    $progress++
}</pre></div>
<p>&nbsp;</p>
<p>Wer das Script im Adminmodus startet, bekommt sogar ein Fenster mit Fortschrittsanzeige.</p>
