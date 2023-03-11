---
layout: post
title: "Resource type is not supported in this subscription"
description: "How to fix this issue via the 'Resource providers'-settings."
date: 2023-03-11 23:55
author: Robert Muehsig
tags: [Azure]
language: en
---

{% include JB/setup %}

I was playing around with some Visual Studio Tooling and noticed this error during the creation of a "Azure Container Apps"-app:

`Resource type is not supported in this subscription`

![x]({{BASE_PATH}}/assets/md-images/2023-03-11/error.png "Error")

# Solution

The solution is quite strange at first, but in the super configurable world of Azure it makes sense: You need to activate the [__Resource provider__](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types) for this feature on your subscription. For `Azure Container Apps` you need the `Microsoft.ContainerRegistry`-resource provider __registered__:

![x]({{BASE_PATH}}/assets/md-images/2023-03-11/solution.png "Solution")

It seems, that you can create such resources via the Portal, but if you go via the API (which Visual Studio seems to do) the provider needs to be registered at first. 

Some resource providers are "enabled by default", other providers needs to be turned on manually. Check out this list for a list of [all resource providers and the related Azure service](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-services-resource-providers).

__Be careful:__ I guess you should only enable the resource providers that you really need, otherwise your attack surface will get larger.

To be honest: This was completly new for me - I do Azure since ages and never had to deal with resource providers. Always learning ;)

Hope this helps!  
