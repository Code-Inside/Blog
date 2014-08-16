---
layout: post
title: "HowTo: Visual Studio 2005 für .NET 3.0 (WPF, WCF, WF) rüsten"
date: 2007-10-30 20:54
author: robert.muehsig
comments: true
categories: [HowTo, Tools]
tags: [.NET 3.0, HowTo, Tools, Visual Studio 2005, WCF, WF, WPF]
---
{% include JB/setup %}
Zwar ist das .NET Framework in der Version 3.0 schon eine Weile raus, allerdings ist Toolunterstützung noch nicht ganz ideal.
Es gibt zwar die <a href="http://www.microsoft.com/germany/expression/default.aspx">Expression Serie</a>, allerdings kostet der Spaß auch was. Eine andere Möglichkeit ist die <a href="http://msdn2.microsoft.com/en-us/vstudio/aa700831.aspx">Beta von Visual Studio 2008</a>.

Wer allerdings weiter mit Visual Studio 2005 nutzen möchte, benötigt folgende 2 Addons:

<u>Für WindowsPresentationFoundation &amp; WindowsCommunicationFounation</u>
<ul>
	<li><a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=f54f5537-cc86-4bf5-ae44-f5a1e805680d&amp;displaylang=en">Visual Studio 2005 extensions for .NET Framework 3.0 (WCF &amp; WPF), November 2006 CTP</a>Â </li>
</ul>
Nach der Installation gibt es neue Projektvorlagen für das .NET Framework 3.0:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image136.png"><img border="0" width="565" src="{{BASE_PATH}}/assets/wp-images/image-thumb115.png" alt="image" height="210" style="border: 0px" /></a>

Was besonder hervorzuheben ist, ist der Splitscreen zwischen der XAML und der Designansicht.Â 

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image137.png"><img border="0" width="559" src="{{BASE_PATH}}/assets/wp-images/image-thumb116.png" alt="image" height="469" style="border: 0px" /></a>

Zwar gibt es in der Toolbox Controls zur Auswahl - aber ich kann sie irgendwie nicht per Drag`n`Drop reinziehen - schade (oder ich mach was falsch).

Jedenfalls kann man immerhin mal in dem XAML austoben:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image138.png"><img border="0" width="309" src="{{BASE_PATH}}/assets/wp-images/image-thumb117.png" alt="image" height="249" style="border: 0px" /></a>

Die restlichen Teile sind so ziemlich normale Projektvorlagen (zu WCF) bzw. bieten diesen XAML Splitscreen.

<u>Für WindowsWorkflowFoundation</u>
<ul>
	<li><a href="http://www.microsoft.com/downloads/details.aspx?familyid=5D61409E-1FA3-48CF-8023-E8F38E709BA6&amp;displaylang=en">Visual Studio 2005 extensions for .NET Framework 3.0 (Windows Workflow Foundation)</a></li>
</ul>
Auch hier gibts neue Projektvorlagen:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image139.png"><img border="0" width="595" src="{{BASE_PATH}}/assets/wp-images/image-thumb118.png" alt="image" height="190" style="border: 0px" /></a>

... und auch wie bei den anderen Extensions, gibt es auch hier eine Besonderheit:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image140.png"><img border="0" width="148" src="{{BASE_PATH}}/assets/wp-images/image-thumb119.png" alt="image" height="240" style="border: 0px" /></a>

Der Workflow Designer erlaubt es aus einer fülle von Controls sich seinen Workflow zu erstellen:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image141.png"><img border="0" width="194" src="{{BASE_PATH}}/assets/wp-images/image-thumb120.png" alt="image" height="240" style="border: 0px" /></a>Â 
<em>(... und noch mehr Controls, welche nicht zu sehen sind)</em>

<strong>Fazit:</strong>

Für WPF Entwickler würde ich entweder VS 2008 und insbesondere wenn es tolle GUIs werden sollen zu Expression Blend raten - zwar kann man alles per Hand machen, allerdings ist es nicht wirklich elegant und macht sehr viel Arbeit.
Tiefergehend in die WF Entwickler habe ich noch nicht reingesehen, sodass ich dies noch nicht beurteilen kann - für WCF Anwendungen sind die Vorlagen eigentlich auch nicht zwingend notwendig, aber eine nette Spielerei.

<strong>Links:</strong>

<a href="http://www.microsoft.com/germany/expression/default.aspx">Expression Serie</a>
<a href="http://msdn2.microsoft.com/en-us/vstudio/aa700831.aspx">Visual Studio 2008</a>
<a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=f54f5537-cc86-4bf5-ae44-f5a1e805680d&amp;displaylang=en">Visual Studio 2005 extensions for .NET Framework 3.0 (WCF &amp; WPF), November 2006 CTP</a>
<a href="http://www.microsoft.com/downloads/details.aspx?familyid=5D61409E-1FA3-48CF-8023-E8F38E709BA6&amp;displaylang=en">Visual Studio 2005 extensions for .NET Framework 3.0 (Windows Workflow Foundation)</a>
