---
layout: post
title: "Migrate a .NET library to .NET Core / .NET Standard 2.0"
description: "It's about time to build .NET Standard 2.0 libs!"
date: 2018-08-30 22:45
author: Robert Muehsig
tags: [.NET Standard, .NET Core]
language: en
---
{% include JB/setup %}

I have a small spare time project called __[Sloader](https://github.com/Code-Inside/Sloader/)__ and I recently moved the code base to .NET Standard 2.0. This blogpost covers how I moved this library to .NET Standard. 

# Uhmmm... wait... what is .NET Standard?
 
If you have been living under a rock in the past year: __[.NET Standard](https://docs.microsoft.com/en-us/dotnet/standard/net-standard)__ is a kind of "contract" that allows the library to run under all .NET implementations like the full .NET Framework or .NET Core. 
But hold on: The library might also run under Unity, Xamarin and Mono (and future .NET implementations that support this contract - that's why it is called "Standard"). So - in general: This is a great thing!

# Sloader - before .NET Standard

Back to my spare time project: 

Sloader consists of three projects (Config/Result/Engine) and targeted the full .NET Framework. All projects were typical library projects. All components were tested with xUnit and builded via Cake. The configuration is using YAML and the main work is done via the HttpClient.

To summarize it: The library is a not too trivial example, but in general it has pretty low requirements.

# Sloader - moving to .NET Standard 2.0

The blogpost from Daniel Crabtee __["Upgrading to .NET Core and .NET Standard Made Easy"](https://www.danielcrabtree.com/blog/314/upgrading-to-net-core-and-net-standard-made-easy)__ was a great resource and if you want to migrate you should check his blogpost.

The best advice from the blogpost: __Just create new .NET Standard projects and xcopy your files to the new projects.__ 

To migrate the projects to .NET Standard I really just needed to deleted the old .csproj files and copied everything into new .NET Standard library projects.

After some fine tuning and NuGet package reference updates everything compilied.

This [GitHub PR](https://github.com/Code-Inside/Sloader/pull/35/files) shows the result of the migration.

# Problems & Aftermath

In my library I still used the old way to access configuration via the ConfigurationManager class (referenced via the [official NuGet package](https://www.nuget.org/packages/System.Configuration.ConfigurationManager/)). This API is not supported on every platform (e.g. Azure Functions), so I needed to tweak those code parts to use System.Environment Variables (this is in my example OK, but there are other options as well).

Everthing else "just worked" and it was a great experience. I tried the same thing with .NET Core 1.0 and it failed horrible, but this time the migration was more or less painless. 

# .NET Portability Analyzer

If you are not sure if your code works under .NET Standard or Core just install the [.NET Portability Analyzer](https://marketplace.visualstudio.com/items?itemName=ConnieYau.NETPortabilityAnalyzer). 

This handy tool will give you an overwhy which parts might run without problems under .NET Standard or .NET Core.

# .NET Standard 2.0 and .NET Framework

If you still targeting the full Framework, make sure you use at least .NET Framework Version __4.7.2__. In theory .NET Standard 2.0 was supposed to work under .NET 4.6.2, but it seems that this [ended not too well](https://twitter.com/terrajobst/status/1031999730320986112):

<blockquote class="twitter-tweet" data-lang="de"><p lang="en" dir="ltr">Sorry but we messed up. We tried to make .NET Framework 4.6.1 retroactively implement .NET Standard 2.0. This was a mistake as we don&#39;t have a time machine and there is a tail of bugs.<br><br>If you want to consume .NET Standard 1.5+ from .NET Framework, I recommend to be on 4.7.2. <a href="https://t.co/E7H2Ps9cLk">https://t.co/E7H2Ps9cLk</a></p>&mdash; Immo Landwerth (@terrajobst) <a href="https://twitter.com/terrajobst/status/1031999730320986112?ref_src=twsrc%5Etfw">21. August 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Hope this helps and encourage you to try a migration to a more modern stack!

