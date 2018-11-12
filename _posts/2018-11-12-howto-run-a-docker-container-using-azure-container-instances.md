---
layout: post
title: "HowTo: Run a Docker container using Azure Container Instances"
description: "If you are new to the Docker World and unsure how to run a simple Docker Container on Azure you should maybe check out the Container Instances Service. I will show you how you can do this in this blogpost."
date: 2018-11-12 23:45
author: Robert Muehsig
tags: [Docker, Azure, Container]
language: en
---
{% include JB/setup %}

![x]({{BASE_PATH}}/assets/md-images/2018-11-12/0.png "Azure Container Instances")

# Azure Container Instances

There are (at least) 3 diffent ways how to run a Docker Container on Azure:

* Using the [Web App for Containers](https://azure.microsoft.com/en-us/services/app-service/containers/) services/app-service/containers/
* Using [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/)
* Using [Azure Container Instances](https://azure.microsoft.com/en-us/services/container-instances/)

In this blogpost we will take a small look how to run a Docker Container on this service. The "Azure Container Instances"-service is a pretty easy service and might be a good first start. I will do this step for step guide via the Azure Portal. You can use the [CLI](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-quickstart) or [Powershell](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-quickstart-powershell). My guide is more or less the same as [this one](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-quickstart-portal), but I will highlight some important points in my blogpost, so feel free to check out the official docs.

# Using Azure Container Instances

## 1. Add new...

At first search for __"Container Instances"__ and this should show up:

![x]({{BASE_PATH}}/assets/md-images/2018-11-12/1.png "Azure Container Instances - service found")

## 2. Set base settings

Now - this is propably the most important step - choose the container name and source of the image. Those settings can't be changed later on!

The image can be from a __Public Docker Hub__ repository or from a prive docker registry. 

__Important:__ If you are using a __Private Docker Hub__ repository use 'index.docker.io' as the login server. It took me a while to figure that out.

![x]({{BASE_PATH}}/assets/md-images/2018-11-12/2.png "Base settings")

## 3. Set container settings

Now you need to choose which OS and how powerful the machine should be. 

__Important:__ If you want an easy access via HTTP to your container, make sure to set a __"DNS label"__. With this label you access it like this: customlabel.azureregion.azurecontainer.io

![x]({{BASE_PATH}}/assets/md-images/2018-11-12/3.png "Container settings")

Make sure to set any needed environment variables here.

Also keep in mind: You can't change this stuff later on. 

## Ready

In the last step you will see a summery of the given settings:

![x]({{BASE_PATH}}/assets/md-images/2018-11-12/4.png "Summery")

## Go

After you finish the setup your Docker Container should start after a short amount of time (depending on your OS and image of course).

![x]({{BASE_PATH}}/assets/md-images/2018-11-12/5.png "Status")

The most important aspect here:

Check the status, which should be "running". You can also see your applied FQDN.

# Summery

This service is pretty easy. The setup itself is not hard, but sometimes the UI seems "buggy", but if you can run your Docker Container locally, you should also be able to run it on this service.

Hope this helps!
