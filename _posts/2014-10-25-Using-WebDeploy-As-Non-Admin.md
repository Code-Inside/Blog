---
layout: post
title: "Using WebDeploy as Non-Admin"
description: "The setup for WebDeploy can be rough and if you want to use WebDeploy as a Non-Admin / pure IIS User it can be even harder. I'll show you how to get things running."
date: 2014-10-25 19:00
author: robert.muehsig
tags: [WebDeploy, IIS, MSDeploy]
---
{% include JB/setup %}

The goal of this post is to enable WebDeploy for Non-Admin & IIS Users. 

## IIS Requirements
Of course: [WebDeploy](http://www.iis.net/downloads/microsoft/web-deploy) itself - install this via the Web Platform Installer. Keep in mind that the "Non-Admin" WebDeploy Stuff will only work on [Windows Server SKUs](http://serverfault.com/questions/88050/iis-7-5-on-windows-7-x64-ultimate-is-missing-the-management-service-icon).

Make sure you install everything from the Web Deploy Installer! 

![x]({{BASE_PATH}}/assets/md-images/2014-10-25/webdeploy_install.png "WebDeploy Installation")

A common problem is that the "Management Service Delegation" is missing. If this is the case, please check if it is installed.

## IIS Manager

If everything is installed you should see "IIS Manager Permissions", "IIS Manager Users", "Management Service" and the "Management Service Delegation".

![x]({{BASE_PATH}}/assets/md-images/2014-10-25/iis.png "IIS with WebDeploy installed")

## IIS Manager: Management Service - "Enable remote connections"

After the installation make sure the Management Service is running and the the default Port 8172 is not blocked on the Firewall and that "Enable remote connection" is checked.

![x]({{BASE_PATH}}/assets/md-images/2014-10-25/iis_managementservice.png "IIS Management Service")
 
## IIS Manager: Management Service Delegation

Inside the Management Service Delegation you can create rules for the Deployment. You need this "Delegation" feature because this service is in charge of the actual deployment process. Your "Non-Admin" account has no rights, but with the correct rules the service will make those changes.

![x]({{BASE_PATH}}/assets/md-images/2014-10-25/iis_servicedelegation.png "IIS Management Service Delegation")
 
These rules were already included in my Azure VM, but the most important one is the "contentPath, iisApp"-provider-rule:

![x]({{BASE_PATH}}/assets/md-images/2014-10-25/iis_contentPath_iisApp.png "Basic Rule for WebDeploy")
 
With this in place you can deploy into an existing application.

## IIS Manager: Setup Users and manage the permissions inside the site

Now the basic setup is done and you will need to create users in the "IIS Manager Users". 

![x]({{BASE_PATH}}/assets/md-images/2014-10-25/iis_user.png "IIS Users")
 
Now go to you site and add the user to the "IIS Manager Permission" list.

![x]({{BASE_PATH}}/assets/md-images/2014-10-25/iis_user.png "IIS Permissions for Users")

## Testing with Visual Studio

The best way to test it is via Visual Studio. Make sure you just write the Server name in the "Server" textbox - __without HTTP://...__. Otherwise you will may see this Error Message "Error Code: ERROR_USER_NOT_ADMIN". Non-Admin Deployment is only supported via HTTPS, even if the certificate is not valid, the deployment will work, but if you try to connect via HTTP you will get this error. This was a hard learning experience for me.

![x]({{BASE_PATH}}/assets/md-images/2014-10-25/vs.png "Visual Studio")

Hope this helps!

## During my WebDeploy-Debugging-Session I collected some links

Maybe it can help you too.

* [Can not see "Management Service Delegation" option in IIS 7](http://serverfault.com/questions/128468/can-not-see-management-service-delegation-option-in-iis-7)
* [Common Web Deploy problems and how to troubleshoot them](http://webdeploywiki.com/Common%20Web%20Deploy%20problems%20and%20how%20to%20troubleshoot%20them.ashx)
* [Configure the Web Deployment Handler](http://www.iis.net/learn/publish/using-web-deploy/configure-the-web-deployment-handler)
* [MSDeploy.exe can connect as Administrator, but not any other Windows account](http://stackoverflow.com/questions/12984960/msdeploy-exe-can-connect-as-administrator-but-not-any-other-windows-account)