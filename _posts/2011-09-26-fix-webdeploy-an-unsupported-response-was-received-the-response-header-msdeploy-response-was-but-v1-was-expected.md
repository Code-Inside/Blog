---
layout: post
title: "Fix: WebDeploy “An unsupported response was received. The response header 'MSDeploy.Response' was '' but 'v1' was expected.”"
date: 2011-09-26 22:07
author: robert.muehsig
comments: true
categories: [Fix]
tags: [WebDeploy]
---
<p>Diese tolle Fehlermeldung hatte ich heute beim Deployment via WebDeploy:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1357.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 5px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb539.png" width="179" height="244"></a>“Error 1 Web deployment task failed.(Remote agent (URL https://SERVER:8172/msdeploy.axd?site=Test) could not be contacted. Make sure the remote agent service is installed and started on the target computer.) The requested resource does not exist, or the requested URL is incorrect. Error details: Remote agent (URL https://SERVER:8172/msdeploy.axd?site=Test) could not be contacted. Make sure the remote agent service is installed and started on the target computer. An unsupported response was received. The response header 'MSDeploy.Response' was '' but 'v1' was expected. The remote server returned an error: (404) Not Found.”</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>Ich habe noch ein zweites Projekt, welches mit denselben Einstellung funktioniert hat. Also wo lag der Fehler? <a href="http://learn.iis.net/page.aspx/516/configure-the-web-deployment-handler/">Richtig konfiguriert</a> war es auf der serverseite auch.</p> <p><strong><u>Lösung: Visual Studio neustarten</u></strong>. Yepp – das hat das Problem behoben. Ärgerlich.</p>
