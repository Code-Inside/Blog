---
layout: post
title: ".editorconfig: Sharing a common coding style in a team"
description: "If you are looking to set and embrace a common coding style in your team you should take a look at the .editorconfig file format."
date: 2018-04-30 23:45
author: Robert Muehsig
tags: [Visual Studio, .editorconfig]
language: en
---
{% include JB/setup %}

# Sharing Coding Styles & Conventions

In a team it is really important to set coding conventions and to use a specific coding style, because it helps to maintain the code - __a lot__. 
Of course has each developer his own "style", but some rules should be set, otherwise it will end in a mess. 

Typical examples for such rules are "Should I use var or not?" or "Are _ still OK for private fields?". Those questions shouldn't be answered in a Wiki - it should be part of the daily developer life and should show up in your IDE!

*Be aware that coding conventions are highly debated. In our team it was important to set a commpon ruleset, even if not everyone is 100% happy with each setting.*

# Embrace & enforce the conventions 

In the past this was the most "difficult" aspect: How do we enforce these rules? 

Rules in a Wiki are not really helpful, because if you are in your favorite IDE you might not notice rule violations.

[Stylecop](https://blogs.msdn.microsoft.com/sourceanalysis/) was once a thing in the Visual Studio World, but I'm not sure if this is still alive. 

Resharper, a pretty useful Visual Studio plugin, comes with it's own code convention sharing file, but you will need Resharper to enforce and embrace the conventions.

# Introducing: .editorconfig

Last year Microsoft decided to support the [.EditorConfig](http://editorconfig.org/) file format in Visual Studio. 

The .editorconfig defines a set of common coding styles (think of tabs or spaces) in a very simple format. Different text editors and IDEs support this file, which makes it a good choice if you are using multiple IDEs or working with different setups. 

Additionally Microsoft added a couple of [C# related options](https://docs.microsoft.com/en-us/visualstudio/ide/editorconfig-code-style-settings-reference) for the editorconfig file to support the C# language features.

Each rule can be marked as "Information", "Warning" or "Error" - which will light up in your IDE.

# Sample

This was a tough choice, but I ended up with the [__.editorconfig of the CoreCLR__](https://github.com/dotnet/coreclr/blob/master/.editorconfig). It is more or less the "normal" .NET style guide. I'm not sure if I love the the "var"-setting and the "static private field naming (like s_foobar)", but I can live with them and it was a good starting point for us (and still is).

The .editorconfig file can be saved at the same level as the .sln file, but you can also use multiple .editorconfig files based on the folder structure. Visual Studio should detect the file and apply the rules.

# Benefits

When everything is ready Visual Studio should populate the results and show the light blub notification:

![x]({{BASE_PATH}}/assets/md-images/2018-04-30/editorconfig.png ".editorconfig in VS")

*Be aware that I have Resharper installed and Resharper has it's own ruleset, which might be in conflict with the .editorconfig setting. You need to adjust those settings in Resharper. I'm still not 100% sure how good the .editorconfig support is, sometimes I need to overwrite the backed in Resharper settings and sometimes it just works. Maybe this page gives a [hint](https://www.jetbrains.com/help/resharper/Using_EditorConfig.html)*.

# Getting started?

Just search for a .editorconfig file (or use something from the Microsoft GitHub repositories) and play with the settings. The setup is easy and it's just a small text file right next to our code. 
Read more about the customization [here](https://docs.microsoft.com/en-us/visualstudio/ide/create-portable-custom-editor-options).

# Related topic

If you are looking for a more powerful option to embrace coding standards, you might want to take a look at [__Roslyn Analysers__](https://msdn.microsoft.com/en-us/library/mt162308.aspx):

> With live, project-based code analyzers in Visual Studio, API authors can ship domain-specific code analysis as part of their NuGet packages. Because these analyzers are powered by the .NET Compiler Platform (code-named “Roslyn”), they can produce warnings in your code as you type even before you’ve finished the line (no more waiting to build your code to discover issues). Analyzers can also surface an automatic code fix through the Visual Studio light bulb prompt to let you clean up your code immediately

