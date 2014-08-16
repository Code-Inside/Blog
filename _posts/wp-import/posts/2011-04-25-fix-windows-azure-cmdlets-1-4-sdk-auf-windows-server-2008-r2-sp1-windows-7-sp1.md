---
layout: post
title: "Fix: Windows Azure Cmdlets & 1.4 SDK auf Windows Server 2008 R2 SP1 / Windows 7 SP1"
date: 2011-04-25 14:13
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Windows Azure; Cmdlets; Powershell; Fix]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1252.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb432.png" width="244" height="158" /></a> </p>  <p>Wie bereits hier beschrieben, benötigen die Windows Azure Cmdlets ein paar Anpassungen (was auch immer der Autor des Setup sich dabei gedacht hat). Nun ging es darum die Cmdlets auf einem Windows Server 2008 R2 mit SP1 zu installieren samt neuen Windows Azure SDK.</p> <!--more-->  <p><strong>Windows Azure Cmdlets runterladen</strong></p>  <p>Die letzte (mir bekannte Version) findet man <a href="http://archive.msdn.microsoft.com/azurecmdlets">hier</a>.</p>  <p><strong>Dependency Checker für Win7 SP1 &amp; Win2008 R2 SP1 anpassen:</strong></p>  <p>Diese tolle Fehlermeldung kommt, sobald man das Setup startet:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1253.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb433.png" width="397" height="256" /></a> </p>  <p>Zur Behebung die "...\WASMCmdlets\setup\Dependencies.dep” Datei öffnen:</p>  <p>In der Zeile &lt;os type=”...”&gt; bei buildNumber noch die <strong>7601</strong> hinzufügen (das ist das SP1)</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1254.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb434.png" width="490" height="166" /></a> </p>  <p><strong>Windows Azure SDK Dependency anpassen</strong></p>  <p>Wenn man nicht das Windows Azure SDK 1.3 installiert hat kommt diese Fehlermeldung:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1255.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb435.png" width="384" height="246" /></a> </p>  <p><strong>Lösung</strong>:    <br /> "WASMCmdlets\setup\scripts\dependencies\check\CheckAzureSDK.ps1”</p>  <p></p>  <p></p>  <p>Diese Zeilen suchen und durch die richtige Versionsnummer (in dem Beispiel ist es bereits auf die Version 1.4 angepasst) ersetzen:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3bb41b63-3bba-46e7-8563-5eeda99e0efb" class="wlWriterEditableSmartContent"><pre name="code" class="c#">
$res1 = SearchUninstall -SearchFor 'Windows Azure SDK*' -SearchVersion '1.4.20227.1419' -UninstallKey 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\';
$res2 = SearchUninstall -SearchFor 'Windows Azure SDK*' -SearchVersion '1.4.20227.1419' -UninstallKey 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\';

</pre></div>

<p>Zu finden ist die Versionsnummer unter anderem auch in der Systemsteuerung:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1256.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb436.png" width="421" height="138" /></a> </p>

<p></p>

<p><strong>Zur Problemlösung (vermutlich auch bei zukünftigen Problemen) lohnt ein Blick in den </strong><a href="http://archive.msdn.microsoft.com/azurecmdlets/Thread/List.aspx"><strong>Diskussions-Tab der Azure Cmdlets</strong></a><strong>.</strong></p>
