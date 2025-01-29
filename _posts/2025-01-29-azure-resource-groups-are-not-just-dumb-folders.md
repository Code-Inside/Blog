---
layout: post
title: "Azure Resource Groups are not just dumb folders"
description: "You might hit some limitation based on existing resources in a resource group - let's see one example with App Service Plans."
date: 2025-01-29 23:30
author: Robert Muehsig
tags: [Azure]
language: en
---

{% include JB/setup %}

## General

An Azure Resource Group is more or less one of the first things you need to create under your Azure subscription because most services need to be placed in an Azure Resource Group.

A resource group has a name and a region, and it feels just like a "folder," but it's (sadly) more complicated, and I want to showcase this with App Service Plans.

## What is an App Service Plan?

If you run a Website/Web Service/Web API on Azure, one option would be [__Web Apps-Service__](https://azure.microsoft.com/en-us/products/app-service/web).

If you are a traditional IIS developer, the "Web Apps-Service" is somewhat like a "Web Site" in IIS.

When you create a brand-new "Web Apps-Service," you will need to create an "App Service Plan" as well.

The "App Service Plan" is the system that hosts your "Web App-Service." The "App Service Plan" is also what actually costs you money, and you can host multiple "Web App-Services" under one "App Service Plan."

All services need to be created in a resource group.

## Recap

An "App Service Plan" can host multiple "Web App-Services." The price is related to the instance count and the actual plan.

Here is a screenshot from one of our app plans:

![x]({{BASE_PATH}}/assets/md-images/2025-01-29/app-service.png "App Service Plan")

So far, so good, right?

A few months later, we created another resource group in a different region with a new app plan and discovered that there were more plans to choose from:

![x]({{BASE_PATH}}/assets/md-images/2025-01-29/more-plans.png "More Plans")

Especially those memory-optimized plans ("P1mV3" etc.) are interesting for our product.

## The problem

So we have two different "App Service Plans" in different resource groups, and one App Service Plan did not show the option for the memory-optimized plans.

This raises a simple question: Why and is there an easy way to fix it?

## Things that won't work

First, I created a __new__ "App Service Plan" within the same resource group as the "old" "App Service Plan," but this operation failed:

![x]({{BASE_PATH}}/assets/md-images/2025-01-29/error.png "Error")

Then I tried to just move the existing "App Service Plan" to a new resource group, but even then, I __could not change__ the SKU to the memory-optimized plan.

## The "reason" & solution

After some frustration - since we had existing services and wanted to maintain our structure - I found this [documentation site](https://learn.microsoft.com/en-us/azure/app-service/app-service-configure-premium-tier).

> Scale up from an unsupported resource group and region combination
> 
> If your app runs in an App Service deployment where Premium V3 isn't available, or if your app runs in a region that currently does not support Premium V3, you need to re-deploy your app to take advantage of Premium V3. Alternatively newer Premium V3 SKUs may not be available, in which case you also need to re-deploy your app to take advantage of newer SKUs within Premium V3. ...

It seems the behavior is "as designed," but I would say that the design is a hassle.

The documentation points out two options for this, but in the end, we will need to create a new app plan and recreate all "Web App-Services" in a new resource group.  

## Lessons learned?

At first glance, I thought that "resource groups" acted like folders, but underneath—depending on the region, subscription, and existing services within that resource group—some options might not be available.

Bummer, but hey... at least we learned something.
