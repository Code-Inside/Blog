---
layout: post
title: "Azure DevOps Server 2022 Update"
description: "Update from Azure DevOps Server 2020..."
date: 2023-02-15 23:15
author: Robert Muehsig
tags: [Azure DevOps Server, OnPrem]
language: en
---

{% include JB/setup %}

# Azure DevOps Server 2022 - OnPrem?

Yes I know - you can get everything from the cloud nowadays, but [we](https://primesoft-group.com/) are still using our OnPrem hardware and were running the "old" [Azure DevOps Server 2020](https://blog.codeinside.eu/2020/11/30/update-onprem-azuredevops-server-2019-to-azuredevops-server-2019-update1/). 
The __Azure DevOps Server 2022_ was released [last december](https://learn.microsoft.com/en-us/azure/devops/server/release-notes/azuredevops2022?view=azure-devops-2022), so an update was due. 

# Requirements

If you are running am Azure DevOps Server 2020 the [requirements](https://learn.microsoft.com/en-us/azure/devops/server/requirements?view=azure-devops-2022&viewFallbackFrom=azure-devops) for the new 2022 release are "more or less" the same __except__ the following important parts:

* Supported server operation systems: __Windows Server 2022 & Windows Server 2019__ vs. the old Azure DevOps Server 2020 could run under a Windows Server 2016
* Supported SQL Server versions: __Azure SQL Database, SQL Managed Instance, SQL Server 2019, SQL Server 2017__ vs. the old Azure DevOps Server supported SQL Server 2016.

# Make sure you have a backup

The last requirement was a suprise for me, because I thought the update should run smoothly, but the installer removed the previous version and I couldn't update, because our SQL Server was still on SQL Server 2016. Fortunately we had a VM backup and could rollback to the previous version. 

# Step for Step

The update process itself was straightforward: Download the [installer](https://learn.microsoft.com/en-us/azure/devops/server/download/azuredevopsserver?view=azure-devops-2022) and run it.

![x]({{BASE_PATH}}/assets/md-images/2023-02-15/step1.png "Step 1")

![x]({{BASE_PATH}}/assets/md-images/2023-02-15/step2.png "Step 2")

![x]({{BASE_PATH}}/assets/md-images/2023-02-15/step3.png "Step 3")

![x]({{BASE_PATH}}/assets/md-images/2023-02-15/step4.png "Step 4")

![x]({{BASE_PATH}}/assets/md-images/2023-02-15/step5.png "Step 5")

![x]({{BASE_PATH}}/assets/md-images/2023-02-15/step6.png "Step 6")

![x]({{BASE_PATH}}/assets/md-images/2023-02-15/step7.png "Step 7")

![x]({{BASE_PATH}}/assets/md-images/2023-02-15/step8.png "Step 8")

![x]({{BASE_PATH}}/assets/md-images/2023-02-15/step9.png "Step 9")

![x]({{BASE_PATH}}/assets/md-images/2023-02-15/step10.png "Step 10")

*The screenshots are from two different sessions. If you look carefully on the clock you might see that the date is different, that is because of the SQL Server 2016 problem.*

As you can see - everything worked as expected, but after we updated the server the search, which is powered by ElasticSearch was not working. The "ElasticSearch"-Windows-Service just crashed on startup and I'm not a Java guy, so... we fixed it by removing the search feature and reinstall it. 
We tried to clean the cache, but it was still not working. After the reinstall of this feature the issue went away.

# Features

Azure Server 2022 is just a minor update (at least from a typical user perspective). The biggest new feature might be "Delivery Plans", which are nice, but for small teams not a huge benefit. Check out the [release notes](https://learn.microsoft.com/en-us/azure/devops/server/release-notes/azuredevops2022?view=azure-devops#azure-devops-server-2022-rc1-release-date-august-9-2022).

A nice - nerdy - enhancement, and not mentioned in the release notes: "[mermaid.js](https://mermaid.js.org/)" is now supported in the Azure DevOps Wiki, yay!

Hope this helps! 
