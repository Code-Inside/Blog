---
layout: post
title: "Fix: “WAT080: Failed to locate the Windows Azure SDK…” auf dem Buildserver"
date: 2012-09-27 23:12
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Build Server, Error, Fix, MSBuild, Windows Azure]
language: de
---
{% include JB/setup %}
<p>Beim Bauen eines Azure Projektes über MSBuild bekam ich folgende Fehlermeldung:</p> <p>“<strong>WAT080: Failed to locate the Windows Azure SDK. Please make sure the Windows Azure SDK v 1.7 is installed.</strong>”</p> <p>Das SDK war installiert – allerdings über den Web Platform Installer und <a href="http://www.deepakkapoor.net/wat080-failed-to-locate-the-windows-azure-sdk-please-make-sure-the-windows-azure-sdk-v1-5-is-installed/">hier gibt es jemanden</a> der ein ähnliches Problem hatte und auch so “gelöst” hat.</p> <p><strong>Lösung:</strong> </p> <p>Alles was mit dem Windows Azure SDK zutun hat (Tools / .NET Libs etc.) entfernen und über die normale <a href="http://www.microsoft.com/en-us/download/details.aspx?id=29988">Microsoft Download Seite</a> (in diesem Fall ist es das 1.7 SDK) gehen und mindestens die Azure Tools (im Bild sind die Tools für VS2010 markiert!) und die .NET Libs runterladen – evtl. müssen auch die AuthoringTools runtergeladen werden. Der Emulator war bei mir aber nicht nötig. Zum Bauen müssten diese Komponenten reichen.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1594.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb755.png" width="534" height="447"></a> </p> <p>Danach kam auch “Build Succeeded” – kein Neustart notwendig.</p> <p>Warum es über den Web Platform Installer nicht geht: Keine Ahnung.</p>
