---
layout: post
title: "First steps with Azure OpenAI and .NET"
description: "How to build your own mini ChatGPT..."
date: 2023-03-23 23:55
author: Robert Muehsig
tags: [AI, OpenAI, Azure]
language: en
---

{% include JB/setup %}

The AI world is rising very fast these days: [ChatGPT](https://chat.openai.com/) is such an awesome (and scary good?) service and Microsoft [joined the ship with some partner announcements and investments](https://blogs.microsoft.com/blog/2023/01/23/microsoftandopenaiextendpartnership/). The result is of these actions is, that OpenAI is now a "first class citizen" on Azure.

So - for the average Microsoft/.NET developer this opens up a wonderful toolbox and the first steps are really easy.

__Be aware:__ You need to ["apply" to access the OpenAI service](https://customervoice.microsoft.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbR7en2Ais5pxKtso_Pz4b1_xUOFA5Qk1UWDRBMjg0WFhPMkIzTzhKQ1dWNyQlQCN0PWcu), but it took less then 24 hours for us to gain access to the service. I guess this is just a temporary thing.

__Disclaimer:__ I'm not an AI/ML engineer and I only have a very "glimpse" knowledge about the technology behind GPT3, ChatGPT and ML in general. If in doubt, I always ask my buddy [Oliver Guhr](https://www.oliverguhr.eu/), because he is much smarter in this stuff. Follow him on [Twitter](https://twitter.com/oliverguhr)!  

# 1. Step: Go to Azure OpenAI Service

Search for "OpenAI" and you will see the "Azure OpenAI Service" entry:

![x]({{BASE_PATH}}/assets/md-images/2023-03-23/openai-service.png "Step 1")

# 2. Step: Create a Azure OpenAI Service instance

Create a new Azure OpenAI Service instance:

![x]({{BASE_PATH}}/assets/md-images/2023-03-23/create.png "Step 2")

On the next page you will need to enter the subscription, resource group, region and a name (typical Azure stuff):

![x]({{BASE_PATH}}/assets/md-images/2023-03-23/create-details.png "Step 2 - details")

__Be aware:__ If your subscription is not enabled for OpenAI, you need to [apply here](https://customervoice.microsoft.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbR7en2Ais5pxKtso_Pz4b1_xUOFA5Qk1UWDRBMjg0WFhPMkIzTzhKQ1dWNyQlQCN0PWcu) first.

# 3. Step: Overview and create a model

After the service is created you should see something like this:

![x]({{BASE_PATH}}/assets/md-images/2023-03-23/overview.png "Step 3 - overview")

Now go to "Model deployments" and create a model - I choosed "text-davinci-003", because I *think* this is GPT3.5 (which was the initial ChatGPT release, GPT4 is currently in preview for Azure and you need to [apply again](https://azure.microsoft.com/en-us/blog/introducing-gpt4-in-azure-openai-service/).

![x]({{BASE_PATH}}/assets/md-images/2023-03-23/model.png "Step 3 - model")

My guess is, that you could train/deploy other, specialized models here, because this model is quite complex and you might want to tailor the model for your scenario to get faster/cheaper results... but I honestly don't know how to do it (currently), so we just leave the default.

# 4. Step: Get the endpoint and the key

In this step we just need to copy the key and the endpoint, which can be found under "Keys and Endpoint", simple - right?

![x]({{BASE_PATH}}/assets/md-images/2023-03-23/keys-and-endpoint.png "Step 4")

# 5. Step: Hello World to our Azure OpenAI instance

Create a .NET application and add the [Azure.AI.OpenAI](https://www.nuget.org/packages/Azure.AI.OpenAI/) NuGet package (currently in preview!).

```
dotnet add package Azure.AI.OpenAI --version 1.0.0-beta.5
```

Use this code:

```
using Azure.AI.OpenAI;
using Azure;

Console.WriteLine("Hello, World!");

OpenAIClient client = new OpenAIClient(
        new Uri("YOUR-ENDPOINT"),
        new AzureKeyCredential("YOUR-KEY"));

string deploymentName = "text-davinci-003";
string prompt = "Tell us something about .NET development.";
Console.Write($"Input: {prompt}");

Response<Completions> completionsResponse = client.GetCompletions(deploymentName, prompt);
string completion = completionsResponse.Value.Choices[0].Text;

Console.WriteLine(completion);

Console.ReadLine();

```

__Result:__

```
Hello, World!
Input: Tell us something about .NET development.

.NET development is a mature, feature-rich platform that enables developers to create sophisticated web applications, services, and applications for desktop, mobile, and embedded systems. Its features include full-stack programming, object-oriented data structures, security, scalability, speed, and an open source framework for distributed applications. A great advantage of .NET development is its capability to develop applications for both Windows and Linux (using .NET Core). .NET development is also compatible with other languages such as
```

As you can see... the result is cut off, not sure why, but this is just a simple demonstration. 

# Summary

With these basic steps you can access the OpenAI development world. Azure makes it easy to integrate in your existing Azure/Microsoft "stack". Be aware, that you could also use the same SDK and use the endpoint from OpenAI. Because of billing reasons it is easier for us to use the Azure hosted instances. 

Hope this helps!

# Video on my YouTube Channel

If you understand German and want to see it in action, check out my video on my [Channel](https://www.youtube.com/@CodeInsideCasts):

<iframe width="560" height="315" src="https://www.youtube.com/embed/VVNHT4gVxDo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

