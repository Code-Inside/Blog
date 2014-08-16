---
layout: post
title: "Web Deploy per WebPI installiert und IIS Management Service nicht vorhanden?"
date: 2012-10-15 21:47
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Web Deloy]
---
{% include JB/setup %}
<p>Um den IIS “Web Deploy”-ready zu machen hatte ich bereits ein <a href="http://code-inside.de/blog/2011/03/28/howto-setup-von-webdeploy-msdeploy/">Setup-Blogpost</a> geschieben. Im Grunde besteht das System aus zwei Teilen:</p> <p>- den Agent für das Deployment<br>- den Management Service, welcher sich auch um den Remote-Zugriff kümmert</p> <p>Heute wollte ich einen IIS “Web Deploy”-ready machen, allerdings fehlte der “Manage Service” Button in der UI. </p> <p>Problem lag daran, dass der Web Platform Installer (4.0) nur ein Teil des Web Deploys installiert und man den Fehler auch nicht sofort sieht.</p> <p><strong>Lösung:</strong> Den Management Service nachinstallieren z.B. über den <a href="http://www.iis.net/downloads/microsoft/web-deploy">direkten Download ganz unten</a>. </p> <p><strong>Empfehlung:</strong> Das Web Deploy Setup <a href="http://www.iis.net/downloads/microsoft/web-deploy">direkt auf der Seite unten</a> runterladen – falls es bereits über WebPI installiert wurde sieht man, dass der IIS Deployment Handler samt Management Teil nicht installiert wurde. </p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1615.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb774.png" width="563" height="308"></a></p> <p>&nbsp; PS: Wie das unter Windows 8 / IIS 8 aussieht versuch ich in einem späteren Blogpost zu klären ;)</p>
