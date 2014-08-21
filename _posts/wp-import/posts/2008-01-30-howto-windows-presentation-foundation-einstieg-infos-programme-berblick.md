---
layout: post
title: "HowTo: Windows Presentation Foundation (Einstieg, Infos, Programme, Überblick)"
date: 2008-01-30 22:39
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET 3.0, .NET 3.5, Expression, HowTo, ICQ, RSS, Silverlight, Vista, WPF]
---
{% include JB/setup %}
Da ich mich auch langsam der WPF Programmierung zuwende, möchte ich einfach mal einen Einstiegs-HowTo schreiben. Inhalte sollen hier das grobe Konzept hinter WPF sein, was man dafür braucht, welche Programme man nimmt und was man sich mal anschauen kann.

<strong>WPF? .NET 3.0? Um was gehts?</strong>

Die <a href="http://de.wikipedia.org/wiki/Windows_Presentation_Foundation" target="_blank">Windows Presentation Foundation</a> ist Teil des <a href="http://de.wikipedia.org/wiki/.NET_Framework_3.0#.NET_3.0_und_Vista" target="_blank">.NET 3.0 Frameworks</a> und wurde auch unter .NET 3.5 weiterentwickelt - was konkret, schauen wir uns dann später mal an. .NET 3.0 kam ungefähr mit Vista auf und ist für <strong>XP, Windows Server 2003</strong> und <strong>Vista</strong> entwickelt wurden.

Um es mal grob zu sagen, was man mit WPF machen kann: Endlich schicke Windows Applikationen! Windows.Forms sind leider in Bezug auf Design recht zickig - mit WPF will man endlich "sexy" Applikationen auch im Unternehmensumfeld kultivieren. Das hat Teilweise schon zu <a href="http://www.istartedsomething.com/20080109/frog-design-wpf-sexy-enterprise-software/" target="_blank">Erfolgen</a> geführt.

<a href="http://de.wikipedia.org/wiki/Silverlight" target="_blank">Silverlight</a> nutzt als Basis auch WPF - allerdings momentan noch sehr begrenzt, aber das Konzept bleibt gleich.

<strong>Was ist denn das Konzept?</strong>

Stellen wir uns eine perfekte Welt vor, wo der Designer mit den entsprechenden Tools arbeitet und das Ergebnis direkt an den Entwickler übergeben kann und dieser ohne große Konvertierung oder Neuimplementierung das Design mit Funktionen befüllen kann. Wie gesagt, wir gehen von einer perfekten Welt aus ;)

Genau hier setzt WPF an. WPF ist die "Oberflächensprache", welche direkt in .NET verwendet werden kann. Von den Designtools wird normalerweise eine <a href="http://de.wikipedia.org/wiki/XAML" target="_blank">XAML</a> Datei für ein Layout erstellt - das gesamte Design wird also in XML gegossen.
XAML selbst wird in eine .NET Objekt Hierarchie serialisiert - daher kann der Entwickler in seiner gewohnten Umgebung direkt drauf zugreifen.

Ein nettes Whitepaper gibts auch <a href="http://blogs.msdn.com/steffenr/archive/2007/12/19/whitepaper-xaml-wpf-und-den-neuen-design-workflow-verstehen.aspx" target="_blank">hier</a> zum Runterladen.

<strong>Mhh... klingt schon mal nach einer netten Idee - was gibts denn für Tools?</strong>

Bei Tools möchte ich mal eine Trennung zwischen "ist für Designer geeignet" und "ist eher für Entwickler geeignet". Der Unterschied liegt daran, dass die Entwickler Anwendungen meist nur die "Handeingabe" ermöglichen - das gefällt natürlich keinem Designer ;)
<ul>
	<li><u>Designer:</u>
<ul>
	<li><a href="http://www.microsoft.com/expression/" target="_blank">Expression Produkte</a>: Direkt von Microsoft für die Designer entwickelt. In Version 2 wird Silverlight auch direkt unterstützt. Momentan ist diese noch Beta - ansonsten sind die Tools recht "teuer".</li>
	<li><a href="http://www.adobe.com/products/illustrator/" target="_blank">Adobe Illustrator</a>: Da WPF Vectorgrafiken nutzt und Illustrator genau auf sowas abzielt, gibt es auch ein <a href="http://www.mikeswanson.com/xamlexport/" target="_blank">XAML Export Plugin</a>.</li>
	<li><a href="http://www.inkscape.org/" target="_blank">Inkscape</a>: Interessante Alternative zu den oberen beiden, weil es kostenlos ist und auch ein <a href="http://weblogs.asp.net/jgalloway/archive/2008/01/10/inkscape-to-support-xaml-export.aspx" target="_blank">XAML Export</a> bietet.</li>
	<li><a href="http://blogs.msdn.com/wpf3d/archive/2008/01/28/blender-to-xaml-exporter-updated.aspx" target="_blank">Blender soll demnächst auch einen XAML Export bieten!</a></li>
</ul>
</li>
	<li><u>Entwickler:</u>
<ul>
	<li><a href="http://msdn2.microsoft.com/en-us/library/ms742398.aspx" target="_blank">XAMLPad</a>: Das Ursprungstool von Microsoft. Dieses ist enthalten im <a href="http://www.microsoft.com/downloads/details.aspx?familyid=C2B1E300-F358-4523-B479-F53D234CDCCF&amp;displaylang=en" target="_blank">Windows SDK</a>.</li>
	<li><a href="http://blogs.msdn.com/llobo/archive/2007/12/22/xamlpadx-v3-0.aspx" target="_blank">XAMLPadX V3</a>: Eine Erweiterung welche ich auf diesem <a href="http://blogs.msdn.com/llobo/default.aspx" target="_blank">Blog</a> gefunden habe. Es unterstützt auch <a href="http://blogs.msdn.com/llobo/archive/2007/12/26/creating-addins-for-xamlpadx.aspx" target="_blank">Plugins</a>. Leider ohne IntelliSense momentan.</li>
	<li>Visual Studio: VS 2008 bietet große Unterstützung - für Visual Studio 2005 gibt es ein <a href="{{BASE_PATH}}/2007/10/30/howto-visual-studio-2005-fr-net-30-wpf-wcf-wf-rsten/" target="_blank">AddIn</a>, welches allerdings auch mehr schlecht als recht ist.</li>
	<li><a href="http://notstatic.com/archives/121" target="_blank">Kaxaml 1.0</a>: Ein Geheimtipp wie ich finde. Sehr schick umgesetzt und sogar mit IntelliSense - daher aus meiner Sicht momentan besser als XAMLPad oder XAMLPADX V3.</li>
</ul>
</li>
</ul>
<strong>Scheint doch eine nette Auswahl zu sein, gibt es sonst irgendwelche Probleme mit WPF?</strong>

WPF hat einen (meiner Meinung nach) großen Nachteil gegenüber einer klassischen Windows.Forms Applikation - leider fehlen viele Controls welche man gewohnt war. Andere Kritikpunkte, welche sicherlich erst bei einem näheren Blick auffallen, sind <a href="http://weblogs.asp.net/okloeten/archive/2007/12/22/5489157.aspx" target="_blank">hier gut beschrieben</a>. Performance ist durch die Komplexität insbesondere im 3D Bereich auch nicht so ganz leicht - hier einige Informationen über die <a href="http://weblogs.asp.net/okloeten/archive/2007/12/18/5467521.aspx" target="_blank">Performance von WPF</a>.

Microsoft arbeitet daran und hat auch wie hier ein <a href="http://blogs.msdn.com/llobo/archive/2008/01/30/want-some-wpf-improvements-features-tell-us.aspx" target="_blank">offenes Ohr für Kritik</a>.

<strong>Was gibt es für Demoapplikationen, Referenzen und sonstige Infos?</strong>

Microsoft selbst hat einige Demoapplikationen zum Downloaden angeboten: <a href="http://windowsclient.net/downloads/folders/wpfsamples/default.aspx" target="_blank">WPF Samples</a>
Insbesondere möchte ich <a href="http://www.00001001.ch/download/HOL/WPF/Outlook_HOL_WPF.pdf" target="_blank">dieses PDF</a> empfehlen - hier wird die Outlook 2003 Oberfläche mit WPF nachgebaut und man sieht Schritt für Schritt wie etwas gemacht wird.

Auch seit kurzem zum Download verfügbar: Das <a href="http://windowsclient.net/wpf/starter-kits/sce.aspx" target="_blank">Syndicated Client Expericences Starter Kit Beta + MSDN Reader</a>. Hierbei handelt es sich im Allgemeinen um einen schicken RSS Feedreader mit WPF.

Microsoft bietet auch einige <a href="http://windowsclient.net/downloads/folders/hands-on-labs/default.aspx" target="_blank">Hands-on Labs</a> an, welche lesenswert sind, sowie <a href="http://www.microsoft.com/expression/kc/resources.aspx?product=blend&amp;type=selfstudy" target="_blank">Expression Blend Tutorials</a> und <a href="http://www.microsoft.com/expression/kc/resources.aspx?product=blend&amp;type=video" target="_blank">Videos</a>.

Wer nach Tutorials sucht, wird ebenfalls auf vielen Seiten fündig - z.B. <a href="http://www.tutorials.de/forum/net-tutorials/248017-windows-presentation-foundation-teil-1-einfuehrung.html">hier</a>.

Aus der Blogszene kommt auch einige interessante Infos, z.B. aus dem deutschen Blogumfeld von Norbert Eder:
<ul>
	<li><a href="http://blog.norberteder.com/index.php?entry=entry071001-201438" target="_blank">WPF Teil 1: Die Windows Presentation Foundation aus der Sicht eines Unternehmens</a></li>
	<li><a href="http://blog.norberteder.com/index.php?entry=entry071024-092559" target="_blank">WPF Teil 2: Windows Presentation Foundation oder doch lieber Windows Forms?</a></li>
	<li><a href="http://blog.norberteder.com/index.php?entry=entry080102-202416" target="_blank">WPF Teil 3: Das Softwaredesign will gut überlegt sein</a></li>
</ul>
Es gibt noch viele weitere interessante Posts (unter anderem einige bei Norbert), z.B. ein <a href="http://vb-magazin.de/forums/blogs/janm/archive/2007/12/27/14373.aspx" target="_blank">WPF ICQ Client</a> oder <a href="{{BASE_PATH}}/2008/01/17/howto-wpf-windows-mit-dem-vista-glass-effekt-ausstatten/" target="_blank">Vista Glass Effekt in WPF</a> - ansonsten auch die anderen Blogs welche in diesem Post waren.

<strong>Lohnt sich WPF?</strong>

Diese Frage kann man so sehr schlecht beantworten - in der Windows Client Entwicklung ist WPF ein sehr großer Schritt nach vorn - auch wenn es momentan noch Schönheitsfehler hat. Mit Silverlight erobert WPF auch das Web, daher kann es nie verkehrt sein, sich mit dieser Technologie auseinander zu setzen. Microsoft setzt z.B. interen WPF für die Expression Produkte ein, aber auch für die Zune Software. Auch gibt es Komponenten in Vista mit WPF - in Windows "7" wird gemunkelt, dass wohl mehrere Applikationen (Wordpad, Paint, Calc) mit WPF "neu" gemacht werden.

Ein Blick schadet also auf die WPF Entwicklung sicherlich nicht - daher auch dieser Post der als Einstieg dienen soll.
