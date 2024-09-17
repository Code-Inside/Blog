---
layout: post
title: "Open AI API, LM Studio and Ollama"
description: "What I learned about the Open AI API, LM Studio and Ollama during a .NET User Group Meeting in Dresden..."
date: 2024-09-17 23:59
author: Robert Muehsig
tags: [Open AI, LM Studio, AI, TIL, User Group]
language: en
---

{% include JB/setup %}

*This is more of a "Today-I-Learned" post and not a "full-blown How-To article." If something is completely wrong, please let me know - thanks!* 

I had the opportunity to attend the [.NET User Group Dresden](https://www.dd-dotnet.de/) at the beginning of September for the exciting topic "[Using Open Source LLMs](https://www.dd-dotnet.de/treffen/2024/09/04/hands-on-open-source-llms-nutzen.html)" and learned a couple of things.

# How to choose an LLM?

There are tons of LLMs (= Large Language Models) that can be used, but which one should we choose? There is no general answer to that - of course - but there is a [Chatbot Arena Leaderboard](https://lmarena.ai/?leaderboard), which measures the "cleverness" between those models. Be aware of the license of each model. 

There is also a [HuggingChat](https://huggingface.co/chat/), where you can pick some models and experiment with them.

For your first steps on your local hardware: [Phi3](https://huggingface.co/microsoft/Phi-3-mini-4k-instruct) does a good job and is not a huge model. 

# LM Studio

Ok, you have a model and an idea, but how to play with it on your local machine? 

The best tool for such a job is: __[LM Studio](https://lmstudio.ai/)__. 

The most interesting part was (and this was "new" to me), that you run those local models in an __local, Open AI compatible (!!!) server__.

![x]({{BASE_PATH}}/assets/md-images/2024-09-17/lmstudio.png "png")

# Open AI Compatible server?!

If you want to experiment with a lightweight model on your system and interact with it, then it is super handy, if you can use the __standard Open AI client__ and just run against your local "Open AI"-like server.

Just start the server, use the localhost endpoint and you can use a code like this:

```
using OpenAI.Chat;
using System.ClientModel;

ChatClient client = new(model: "model", "key",
        new OpenAI.OpenAIClientOptions()
        { Endpoint = new Uri("http://localhost:1234/v1") });

ChatCompletion chatCompletion = client.CompleteChat(
    [
        new UserChatMessage("Say 'this is a test.'"),
    ]);

Console.WriteLine(chatCompletion.Content[0].Text);
```

The `model` and the `key` don't seem to matter that much (or at least I worked on my machine). The `localhost:1234` service is hosted by LM Studio on my machine. The actual model can be configured in LM Studio and there is a huge choice available.

Even streaming is supported:

```
AsyncCollectionResult<StreamingChatCompletionUpdate> updates
    = client.CompleteChatStreamingAsync("Write a short story about a pirate.");

Console.WriteLine($"[ASSISTANT]:");
await foreach (StreamingChatCompletionUpdate update in updates)
{
    foreach (ChatMessageContentPart updatePart in update.ContentUpdate)
    {
        Console.Write(updatePart.Text);
    }
}
```

# Ollama

The obvious next question is: How can I run my own LLM on my own server? LM Studio works fine, but it's just a development tool. 

One answer could be: __[Ollama](https://ollama.com/)__, which can run large language models and has a [compatibility to the Open AI API](https://ollama.com/blog/openai-compatibility).

# Is there an Ollama for .NET devs?

Ollama looks cool, but I was hoping to find an "Open AI compatible .NET facade". I already played with [LLamaSharp](https://blog.codeinside.eu/2024/05/15/llamasharp-run-a-chatgpt-like-system-on-your-hardware-for-dummies/), but `LLamaSharp` [doesn't offer currently a WebApi, but there are some ideas around](https://github.com/SciSharp/LLamaSharp/issues/269). 
My friend [Gregor Biswanger](https://github.com/GregorBiswanger) released [OllamaApiFacade](https://github.com/GregorBiswanger/OllamaApiFacade), which looks promising, but at least it doesn't offer a real Open AI compatible .NET facade, but maybe this will be added in the future.

# Acknowledgment

Thanks to the .NET User Group for hosting the meetup, and a special thanks to my good friend [__Oliver Guhr__](https://github.com/oliverguhr), who was also the speaker!  

Hope this helps!