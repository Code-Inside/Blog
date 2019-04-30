---
layout: post
title: "Update OnPrem TFS 2018 to AzureDevOps Server 2019"
description: "How to update a OnPrem TFS 2018 installation to the newest Azure DevOps Server 2019."
date: 2019-04-30 23:45
author: Robert Muehsig
tags: [TFS, Azure DevOps]
language: en
---

{% include JB/setup %}

We recently updated our OnPrem TFS 2018 installation to the newest release: __[Azure DevOps Server](https://azure.microsoft.com/en-us/services/devops/server/)__

The product has the same core features as TFS 2018, but with a new UI and other improvements. For a full list you should read the [Release Notes](https://docs.microsoft.com/en-us/azure/devops/server/release-notes/azuredevops2019?view=azure-devops).

*Be aware: This is the __OnPrem__ solution, even with the slightly missleading name "Azure DevOps Server". If you are looking for the __Cloud__ solution you should read the [Migration-Guide](https://azure.microsoft.com/en-us/services/devops/migrate/).

# "Updating" a TFS 2018 installation

Our setup is quite simple: One server for the "Application Tier" and another SQL database server for the "Data Tier". 
The "Data Tier" was already running with SQL Server 2016 (or above), so we only needed to touch the "Application Tier".

# Application Tier Update

In our TFS 2018 world the "Application Tier" was running on a Windows Server 2016, but we decided to create a new (clean) server with Windows Server 2019 and doing a "clean" Azure DevOps Server install, but pointing to the existing "Data Tier".

In theory it is quite possible to update the actual TFS 2018 installation, but because "new is always better", we also switched the underlying OS.

# Update process

The actual update was really easy. We did a "test run" with a copy of the database and everything worked as expected, so we reinstalled the Azure DevOps Server and run the update on the production data.

## Steps:

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/0.png "Start")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/1.png "Wizard")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/2.png "Existing or new")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/3.png "SQL instance")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/4.png "Production update")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/5.png "Service Account")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/6.png "Settings")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/7.png "Search Service")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/8.png "Reporting")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/9.png "Confirm")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/10.png "Check")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/11.png "Configuration")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/12.png "Configuration done")

![x]({{BASE_PATH}}/assets/md-images/2019-04-30/13.png "Success")

## Summary

If you are running a TFS installation, don't be afraid to do an update. The update itself was done in 10-15 minutes on our 30GB-ish database.

Just download the setup from the [Azure DevOps Server](https://azure.microsoft.com/en-us/services/devops/server/) site ("Free trial...") and you should be ready to go! 

Hope this helps!