---
layout: post
title: "How to run a legacy WCF .svc Service on Azure AppService"
description: "WCF... that is a thing I haven't heard in a long time."
date: 2020-08-31 23:45
author: Robert Muehsig
tags: [WCF, Azure, AppService]
language: en
---

{% include JB/setup %}

Last month we wanted to run good old WCF powered service on Azures ["App Service"](https://azure.microsoft.com/en-us/services/app-service/web/). 

# WCF... what's that?

If you are not familiar with WCF: Good! For the interested ones: [WCF](https://en.wikipedia.org/wiki/Windows_Communication_Foundation) is or was a framework to build mostly SOAP based services in the .NET Framework 3.0 timeframe. Some parts where "good", but most developers would call it a complex monster. 

Even in the glory days of WCF I tried to avoid it at all cost, but unfortunately I need to maintain a WCF based service. 

For the curious: The project template and the tech is still there. Search for "WCF".

![VS WCF Template]({{BASE_PATH}}/assets/md-images/2020-08-31/template.png "VS WCF Template")

The template will produce something like that:

The actual "service endpoint" is the `Service1.svc` file.

![WCF structure]({{BASE_PATH}}/assets/md-images/2020-08-31/structure.png "WCF structure")

# Running on Azure: The problem

Let's assume we have a application with a .svc endpoint. In theory we can deploy this application to a standard Windows Server/IIS without major problems.

Now we try to deploy this very same application to Azure AppService and this is the result after we invoke the service from the browser:

    "The resource you are looking for has been removed, had its name changed, or is temporarily unavailable." (HTTP Response was 404)

Strange... very strange. In theory a blank HTTP 400 should appear, but not a HTTP 404. The service itself was not "triggered", because we had some logging in place, but the request didn't get to the actual service.

After hours of debugging, testing and googling around I created a new "blank" WCF service from the Visual Studio template got the same error.

The good news: It's was not just my code something is blocking the request. 

After some hours I found a helpful switch in the Azure Portal and activated the "Failed Request tracing" feature (yeah... I could found it sooner) and I discovered this:

![Failed Request tracing image]({{BASE_PATH}}/assets/md-images/2020-08-31/fail.png "Failed Request tracing")

# Running on Azure: The solution

My initial thoughts were correct: The request was blocked. It was treated as "static content" and the actual WCF module was not mapped to the .svc extension.

To "re-map" the `.svc` extension to the correct handler I needed to add this to the `web.config`:

```xml
...
<system.webServer>
    ...
	<handlers>
		<remove name="svc-integrated" />
		<add name="svc-integrated" path="*.svc" verb="*" type="System.ServiceModel.Activation.HttpHandler" resourceType="File" preCondition="integratedMode" />
	</handlers>
</system.webServer>
...

```

With this configuration everything worked as expected on Azure AppService.

__Be aware:__

I'm really not 100% sure why this is needed in the first place. I'm also not 100% sure if the name `svc-integrated` is correct or important.

This blogpost is a result of these [tweets](https://twitter.com/robert0muehsig/status/1297915212541186056?s=20).

That was a tough ride... Hope this helps!