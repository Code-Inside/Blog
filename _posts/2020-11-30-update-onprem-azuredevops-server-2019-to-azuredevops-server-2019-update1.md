---
layout: post
title: "Update AzureDevOps Server 2019 to AzureDevOps Server 2019 Update 1"
description: "How to update a AzureDevOps Server 2019 to AzureDevOps Server 2019 Update 1."
date: 2020-11-30 18:00
author: Robert Muehsig
tags: [TFS, Azure DevOps]
language: en
---

{% include JB/setup %}

*We did this update in May 2020, but I forgot to publish the blogpost... so here we are*

Last year we updated to [Azure DevOps Server 2019](https://blog.codeinside.eu/2019/04/30/update-onprem-tfs-2018-to-azuredevops-server-2019/) and it went more or less smooth. 

In May we decided to update to the "newest" release at that time: [Azure DevOps Server 2019 Update 1.1](https://docs.microsoft.com/en-us/azure/devops/server/release-notes/azuredevops2019u1?view=azure-devops)

# Setup

Our AzureDevOps Server was running on a "new" Windows Server 2019 and everything was still kind of newish - so we just needed to update the AzureDevOps Server app.

# Update process

The actual update was really easy, but we had some issues after the installation. 

## Steps:

![x]({{BASE_PATH}}/assets/md-images/2020-11-30/AzureDevOps.png "Step 1")

![x]({{BASE_PATH}}/assets/md-images/2020-11-30/AzureDevOps1.png "Step 2")

![x]({{BASE_PATH}}/assets/md-images/2020-11-30/AzureDevOps2.png "Step 3")

![x]({{BASE_PATH}}/assets/md-images/2020-11-30/AzureDevOps3.png "Step 4")

![x]({{BASE_PATH}}/assets/md-images/2020-11-30/AzureDevOps4.png "Step 5")

![x]({{BASE_PATH}}/assets/md-images/2020-11-30/AzureDevOps5.png "Final")

## Aftermath 

We had some issues with our Build Agents - they couldn't connect to the AzureDevOps Server:

    TF400813: Resource not available for anonymous access

As a first "workaround" (and a nice enhancement) we switched from __HTTP__ to __HTTPS__ internally, but this didn't solved the problem.

The real reason was, that our "Azure DevOps Service User" didn't had the required write permissions for this folder:

    C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys

The connection issue went away, but now we introduced another problem: Our SSL Certificate was "self signed" (from our Domain Controller), so we need to register the agents like this:

    .\config.cmd --gituseschannel --url https://.../tfs/ --auth Integrated --pool Default-VS2019 --replace --work _work

The important parameter is __-gituseschannel__, which is needed when dealing with "self signed, but Domain 'trusted'"-certificates.

With this setting everything seemed to work as expected. 

Only node.js projects or toolings were "problematic", because node.js itself don't use the Windows Certificate Store.

To resolve this, the __root certificate__ from our Domain controller must be stored on the agent. 

```
  [Environment]::SetEnvironmentVariable("NODE_EXTRA_CA_CERTS", "C:\SSLCert\root-CA.pem", "Machine") 
```

## Summary

The update itself was easy, but it took us some hours to configure our Build Agents. After the initial hiccup it went smooth from there - no issues and we are ready for the next update, which is already [released](https://docs.microsoft.com/en-us/azure/devops/server/release-notes/azuredevops2020?view=azure-devops).  

Hope this helps!
