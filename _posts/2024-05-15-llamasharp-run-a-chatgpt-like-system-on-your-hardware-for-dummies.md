---
layout: post
title: "LLamaSharp: Run a ChatGPT like system on your hardware for dummies"
description: "Let's explore the LLamaSharp quick start..."
date: 2024-05-15 23:59
author: Robert Muehsig
tags: [.NET, LLama, AI, ML]
language: en
---

{% include JB/setup %}

*TL;DR summary: Check out the [LLamaSharp Quick Start](https://github.com/SciSharp/LLamaSharp) and you will find everything that you need to know*

ChatGPT (and all those Microsoft Copilots out there that were build on top of this) is currently the synonym for AI based chat systems. As a dev you can just use the Azure OpenAI Services and integrate this in your app - I blogged about this [last year](https://blog.codeinside.eu/2023/03/23/first-steps-with-azure-openai-and-dotnet/).

The only "downside" is, that you rely on a cloud system, that costs money and you need to trust the overall system and as a tech nerd it is always "cool" to host stuff yourself.
Of course, there are a lot of other good reasons why hosting such a system yourself is a good idea, but we just stick with "it is cool" for this blogpost. (There are tons of reasons why this is a stupid idea as well, but we might do it anyway just for fun.)

# Is there something for .NET devs?

My AI knowledge is still quite low and I'm more a ".NET [backend developer](https://datascientest.com/en/all-about-back-end)", so I was looking for an easy solution for my problem and found "[LLamaSharp](https://github.com/SciSharp/LLamaSharp)".

This blogpost and my experiment was inspired by Maarten Balliauws blog post ["Running Large Language Models locally – Your own ChatGPT-like AI in C#"](https://blog.maartenballiauw.be/post/2023/06/15/running-large-language-models-locally-your-own-chatgpt-like-ai-in-csharp.html), which is already a year old, but still a good intro in this topic. 

# LLamaSharp   

From their [GitHub Repo](https://github.com/SciSharp/LLamaSharp):

> LLamaSharp is a cross-platform library to run 🦙LLaMA/LLaVA model (and others) on your local device. Based on llama.cpp, inference with LLamaSharp is efficient on both CPU and GPU. With the higher-level APIs and RAG support, it's convenient to deploy LLM (Large Language Model) in your application with LLamaSharp.

__Be aware:__ This blogpost is written with LLamaSharp version 0.12.0 - Maartens blogpost is based on version 0.3.0 and the model he was using is not working anymore.

This sounds really good - let's checkout the [quick start](https://scisharp.github.io/LLamaSharp/0.12.0/QuickStart/) 

The basic steps are easy: Just add the [LLamaSharp](https://www.nuget.org/packages/LLamaSharp) and [LLamaSharp.Backend.Cpu](https://www.nuget.org/packages/LLamaSharp.Backend.Cpu) NuGet package to your project and then search for a model... but where?

# The model 

From the quick start:

> There are two popular format of model file of LLM now, which are PyTorch format (.pth) and Huggingface format (.bin). LLamaSharp uses GGUF format file, which could be converted from these two formats. To get GGUF file, there are two options:
> 
> Search model name + 'gguf' in Huggingface, you will find lots of model files that have already been converted to GGUF format. Please take care of the publishing time of them because some old ones could only work with old version of LLamaSharp.
> 
> Convert PyTorch or Huggingface format to GGUF format yourself. Please follow the instructions of this part of llama.cpp readme to convert them with the python scripts.
> 
> Generally, we recommend downloading models with quantization rather than fp16, because it significantly reduce the required memory size while only slightly impact on its generation quality.

Okay... I ended up using the [huggingface-search-approach](https://huggingface.co/models?search=gguf) and picked the [Phi-3-mini-4k-instruct-gguf](https://huggingface.co/microsoft/Phi-3-mini-4k-instruct-gguf), because I heard about it somewhere.

# Code

After the initial search and download I could just copy/paste the quick start code in my project and hit run:

```
using LLama.Common;
using LLama;

string modelPath = @"C:\temp\Phi-3-mini-4k-instruct-q4.gguf"; // change it to your own model path.

var parameters = new ModelParams(modelPath)
{
    ContextSize = 1024, // The longest length of chat as memory.
    GpuLayerCount = 2 // How many layers to offload to GPU. Please adjust it according to your GPU memory.
};
using var model = LLamaWeights.LoadFromFile(parameters);
using var context = model.CreateContext(parameters);
var executor = new InteractiveExecutor(context);

// Add chat histories as prompt to tell AI how to act.
var chatHistory = new ChatHistory();
chatHistory.AddMessage(AuthorRole.System, "Transcript of a dialog, where the User interacts with an Assistant named Bob. Bob is helpful, kind, honest, good at writing, and never fails to answer the User's requests immediately and with precision.");
chatHistory.AddMessage(AuthorRole.User, "Hello, Bob.");
chatHistory.AddMessage(AuthorRole.Assistant, "Hello. How may I help you today?");

ChatSession session = new(executor, chatHistory);

InferenceParams inferenceParams = new InferenceParams()
{
    MaxTokens = 256, // No more than 256 tokens should appear in answer. Remove it if antiprompt is enough for control.
    AntiPrompts = new List<string> { "User:" } // Stop generation once antiprompts appear.
};

Console.ForegroundColor = ConsoleColor.Yellow;
Console.Write("The chat session has started.\nUser: ");
Console.ForegroundColor = ConsoleColor.Green;
string userInput = Console.ReadLine() ?? "";

while (userInput != "exit")
{
    await foreach ( // Generate the response streamingly.
        var text
        in session.ChatAsync(
            new ChatHistory.Message(AuthorRole.User, userInput),
            inferenceParams))
    {
        Console.ForegroundColor = ConsoleColor.White;
        Console.Write(text);
    }
    Console.ForegroundColor = ConsoleColor.Green;
    userInput = Console.ReadLine() ?? "";
}
```

The result is a "ChatGPT-like" chat bot (maybe not so smart, but it runs quick ok-ish on my Dell notebook:

![x]({{BASE_PATH}}/assets/md-images/2024-05-15/result.png "Result")

# Summary

After some research which model can be used with LLamaSharp it went really smoothly (even for a .NET dummy like me).

Hope this helps!
