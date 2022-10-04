---
layout: post
title: "Azure DevOps & Azure Service Connection"
description: "How to deploy to the cloud..."
date: 2022-10-04 23:15
author: Robert Muehsig
tags: [Azure, DevOps]
language: en
---

{% include JB/setup %}

Today I needed to setup a new release pipeline on our Azure DevOps Server installation to deploy some stuff automatically to Azure. The UI (at least on the Azure DevOps Server 2020 (!)) is not really clear about how to connect those two worlds, and thats why I'm writing this short blogpost.

First - under project settings - add a new __service connection__. Use the `Azure Resource Manager`-service. Now you should see something like this:

![x]({{BASE_PATH}}/assets/md-images/2022-10-04/azure-connection.png "Azure Resource Manager")

__Be aware:__ You will need to register app inside your Azure AD and need permissions to setup. If you are not able to follow these instructions, you might need to talk to your Azure subscription owner. 

__Subscription id:__

Copy here the id of your subscription. This can be found in the subscription details:

![x]({{BASE_PATH}}/assets/md-images/2022-10-04/subscription.png "Azure Subscription")

Keep this tab open, because we need it later!

__Service prinipal id/key & tenant id:__

Now this wording about "Service principal" is technically correct, but really confusing if your are not familar with Azure AD. A "Service prinipal" is like a "service user"/"app" that you need to register to use it.
The easiest route is to create an app via the __Bash Azure CLI__:

```
az ad sp create-for-rbac --name DevOpsPipeline
```

If this command succeeds you should see something like this:

```
{
  "appId": "[...GUID..]",
  "displayName": "DevOpsPipeline",
  "password": "[...PASSWORD...]",
  "tenant": "[...Tenant GUID...]"
}
```

This creates an "Serivce principal" with a random password inside your Azure AD. The next step is to give this "Service principal" a role on your subscription, because it has currently no permissions to do anything (e.g. deploy a service etc.).

Go to the subscription details page and then to __Access control (IAM)__. There you can add your "DevOpsPipeline"-App as "Contributor" (Be aware that this is a "powerful role"!).

After that use the `"appId": "[...GUID..]"` from the command as __Service Principal Id__. 
Use the `"password": "[...PASSWORD...]"` as __Service principal key__ and the `"tenant": "[...Tenant GUID...]"` for the __tenant id__.

Now you should be able to "Verify" this connection and it should work.

__Links:__
[This blogpost](https://azuredevopslabs.com/labs/devopsserver/azureserviceprincipal/#task-2-creating-an-azure-service-principal) helped me a lot. [Here](https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal) you can find the official documentation.

Hope this helps!