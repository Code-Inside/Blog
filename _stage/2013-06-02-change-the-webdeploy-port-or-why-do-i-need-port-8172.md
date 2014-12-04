---
layout: post
title: "Change the WebDeploy Port or why do I need port 8172?"
date: 2013-06-02 10:14
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

If you use WebDeploy on a server operation system you would usually use Port 8172. But what is this Port for and can I change it?

<em> </em>

<em>Hint: For installing the WebDeploy I recommend <a href="http://code-inside.de/blog-in/2011/04/03/howto-setup-of-webdeploy-msdeploy/">this</a> Blogpost. </em>

<strong> </strong>

<strong>Port 8172 = IIS Management Service Default Port</strong>

The Port 8172 is the default port of the IIS Management Service which is only available for server operation systems (so don’t worry if you can’t find it in IIS at Windows 7/8).

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb978.png" border="0" alt="image" width="376" height="410" />

You can change the settings on GUI (or Powershell) while the service is not running.

That’s basically it.

<strong> </strong>

<strong>Background-Information: WebDeploy &amp; Web Management Service Handler</strong>

I’ve already mentioned that the Web Management Service only runs on Server operations systems – so how does the WebDeploy work on my local IIS?

I found a <a href="http://blog.richardszalay.com/2013/02/02/building-a-deployment-pipeline-with-msdeploy-part-4-server-configuration/">good summary about WebDeploys “Deployment Models”</a> on the Blog of <a href="http://blog.richardszalay.com/">Richard Szalay</a>:

1. <strong>Web</strong><em> </em><strong>Management Service (WMSvc) handler</strong><em>
This is the preferred method for IIS 7+ / Windows Server 2008+ and supports non-administrator deployments. It piggybacks on the WMSvc (ie. remote IIS management) by registering a custom handler (</em><a href="http://server:8172/msdeploy.axd"><em>http://server:8172/msdeploy.axd</em></a><em>). Making use of WMSvc also means that this method is not available to Windows client versions (including 7 and 8), as WMSvc is not available on those platforms. At the command line, this method is specified on the dest provider as “,computerName=http://server:8172/msdeploy.axd?site=iis-site-name”</em>

2. <strong>Web Deploy Agent Service</strong><em>
This is the only choice for IIS6 / Server 2003, is not installed by default, and requires the deployment user to be an administrator. At the comment line, this method is specified as “,computerName=server“</em>

<em></em>

3. <strong>“On Demand” Agent Service (temp agent)
</strong><em>This choice installs the agent service temporarily for a single deployment. Useful when you have administrator credentials but aren’t able to remotely install the handler or agent service. At the command line, this method is specified as“,computerName=server,tempAgent=true”</em>

WebDeploy on the server works always in cooperation with the Web Management Service – if you change the Port of the WMSvc dealer you change the Port for the WebDeploy.

&nbsp;

<strong>Background-Information: Where are those settings saved?</strong>

I found <a href="http://www.iis.net/learn/manage/remote-administration/remote-administration-for-iis-manager">some of those settings (like for example the Port) in the Registry</a>:

Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WebManagement\Server

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb979.png" border="0" alt="image" width="458" height="275" />

Other settings are in the <a href="http://www.iis.net/configreference/system.webserver/management">administration.config</a> (C:\Windows\System32\inetsrv\config)

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb980.png" border="0" alt="image" width="240" height="133" />

<strong>TL; DR:</strong>

Go to Management Service with IIS Manager on a server and change the Port. WebDeploy uses the Management Service for the Deployment – also the Management Service is responsible for the “Remote-administration”.
