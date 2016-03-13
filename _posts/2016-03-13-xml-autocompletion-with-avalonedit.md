---
layout: post
title: "XML Autocompletion with AvalonEdit"
description: "AvalonEdit is the text editor used in SharpDevelop and available as a handy WPF control. My goal was to build a 'IntelliSense'-like autocomplete feature for editing XML files with AvalonEdit."
date: 2016-03-13 22:00
author: Robert Muehsig
tags: [XML, .NET, AvalonEdit, IntelliSense]
language: en
---
{% include JB/setup %}

## AvalonEdit

AvalonEdit is a text editor WPF control, used and created by the [SharpDevelop team](http://www.icsharpcode.net/OpenSource/SD/Default.aspx). It comes with some nice features, like code folding support, text highlighting and infrastructure for advanced features like autocompletion.

Read more about AvalonEdit on the [offical site](http://avalonedit.net/). 

To install AvalonEdit, just create a WPF project and install the [AvalonEdit NuGet package](https://www.nuget.org/packages/AvalonEdit/).

## Our Scenario

We use AvalonEdit to edit XML configurations, but it can be used with any language. This blogpost will only take a look at our XML-scenario.

## XML Autocomplete or "IntelliSense"

AvalonEdit only ships with Syntax-Highlighting for XML - but nothing more. To get something like Tag-Autocompletion or even something like "IntelliSense" I had to combine different code pieces and write something new. So... the daily business of any programmer.

### XML Tag-Completion - with Code from SharpDevelop and Xsemmel

Modern text editors will autocomplete given XML tags, e.g. if I type the closing element for "<foo" it will create something like "<foo></foo>" and set the cursor inside the element.
To get to this feature we need to know which XML tag we are currently try to write - this issue can be solved with some magic RegEx0.

The good part: This is already a solved problem. I discovered a very clever XmlParser on the __[SharpDevelop GitHub Repo](https://github.com/icsharpcode/SharpDevelop/tree/master/src/AddIns/DisplayBindings/XmlEditor)__ and another one from the __[Xsemmel Project](https://xsemmel.codeplex.com/)__.

I use code from both projects and integrated it in my sample project. And I hope I didn't broke the license by doing it - if yes I did it unintentional. Each code part is marked with the source and the copyright notes are included as well. 
Anyway: __Huge credits are going to both projects.__

### What I get from those libraries?

Both libraries are clever enough to parse XML - or even "invalid" XML, and return the current position inside the XML tree. The code from Xsemmel also helped my with the "pure" tag completion. 

My merged XmlParser will return me the needed information for autocompletion or even "IntelliSense"-like features.

### XML "IntelliSense" - Whats the source of the "IntelliSense"?

To present some clever autocomplete actions, we need a source for this information. The good thing about XML is, that there is a huge range of related standards around it. The idea is simple:

Using an __existing XML Schema__ should do the trick. I already blogged about it __[here](http://blog.codeinside.eu/2016/03/06/parsing-xml-schemas-in-dotnet/)__.

### Putting those pieces together:

I created a WPF project, included the AvalonEdit NuGet package and the code portions I already mentioned. The performance in the animation is a bit slow, because I wanted to show you what the XmlParser is doing in the background - this can be seen at the bottom of the application.

![x]({{BASE_PATH}}/assets/md-images/2016-03-13/xmleditor.gif "AvalonEdit with XML Autocompletion").

You don't need to "query" the document everytime you change the cursor - so in real life the performance hit is not very noticable.

As I already mentioned in the XSD-blogpost: XML Namespaces will not work with this implementation. As far as I know the SharpDevelop code should understand namespaces, but at least my XSD parser is not smart enough.

### The logic

The most interesting logic happens in the [TextEntered-EventHandler](https://github.com/Code-Inside/Samples/blob/master/2016/XmlIntelliSense/XmlIntelliSense.App/MainWindow.xaml.cs#L40).

The ">" and "/" key is interesting for the simple tag autocompletion. The "XsdParser"-Result is used when you hit the "<" key or " " as long as you are inside a tag for attribute autocompletion.

### "Good enough"

My implementation is far away from perfection, but should be good enough for most simple cases. As I already mentioned, the heavy lifting is done by code from SharpDevelop or Xsemmel. My sample is self-contained and only relys on the AvalonEdit NuGet package and the standard WPF.

__[Full Sample Code on GitHub](https://github.com/Code-Inside/Samples/tree/master/2016/XmlIntelliSense)__
	
Hope this helps!
