---
layout: page
title: "HowTo: Microsoft Patterns & Practices Software Factories verstehen"
date: 2007-10-08 23:09
author: Robert Muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-microsoft-patterns-practices-software-factories-verstehen
---
{% include JB/setup %}
<img src="http://msdn2.microsoft.com/ms998572.PATTPRAC(en-us,MSDN.10).gif" alt="Patterns Practices" />

In dieser HowTo-Serie geht es um Software Factories.
In dem ersten Teil geht es erstmal primär um das Verstehen, was Software Factories sind und was man grob mit ihnen anfangen kann - und was sie uns bringen.

<strong>Was ist denn eine Software Factory und warum sollte ich eine benutzen?</strong>

Wenn man sich grob mal das ganze Thema Software Factories anschaut und sich die unterschiedlichen Tools etc. installiert, ist man doch erstmal erschlagen. Der gemeine Hobbyentwickler gibt eigentlich an dieser Stelle auf. "Echte" Entwickler sollten sich aber durchkämpfen.

Ein kurzer Abriss in den Ablauf der Softwareentwicklung: Es gibt ein bestimmtes Problem und man hat bereits einen Lösungsansatz. Man bindet z.B. einen Webservice ein oder fragt eine Datenbank ab, als Programm soll dann ein Windows Programm dienen.
In der Regel fängt dannach der Entwickler an eine neue Solution zu erstellen und bastelt alles von Grund auf neu. Der Vorteil: Man ist Herr über seinen eigenen Code und denkt sich dabei was.
Das Problem: Nicht jeder ist Experte und hinterher ärgert man sich über bestimmte Codestellen oder fragt sich, wie man am besten, dies und jenes implementieren könnte - nun ist das Produkt vielleicht fertig, aber wartungsfreundlich ist es nicht und es gibt auch keine guten allg. Lösungsansätze, da es ja eine ganz individuelle Entwicklung war.
Nun wäre es doch schön, würde man bestimmte Standardsachen einfach schon erstellen können um ein gutes Grundgerüst zu bekommen.
An dieser Stelle setzen Software Factories an.

Wenn man rubuste Software schreiben möchte, welche mit bewährten Techniken ein Grundgerüst gestellt bekommen - der sollte die Software Factories mal anschauen.

<strong>Woher bekomme ich diese Software Factories und was gibts für welche?</strong>

Das Logo oben ist von <a target="_blank" href="http://msdn2.microsoft.com/en-us/practices/default.aspx">Microsofts "patterns &amp; practices" Team</a> und ich beziehe mich bei dieser HowTo Serie nur auf das p&amp;p Team von Microsoft mit ihren Software Factories - es gibt wahrscheinlich noch mehr, aber das würde den Rahmen sprengen und mehr Zeit kosten.

Es gibt momentan 4 Factories:
<ul>
	<li><a target="_blank" href="http://msdn2.microsoft.com/en-us/library/aa480471.aspx">Mobile Client Software Factory:</a>
<ul>
	<li>Stand: CTP July 2006 </li>
	<li>Ziel: Für Windows Mobile-Applikationen</li>
</ul>
</li>
	<li><a target="_blank" href="http://msdn2.microsoft.com/en-us/library/aa480482.aspx">Smart Client Software Factory:</a>
<ul>
	<li>Stand: June 2006</li>
	<li>Ziel: Für Windows Desktop-Applikationen</li>
	<li>Zukunft: <a target="_blank" href="http://windowsclient.net/Acropolis/">Codename Acropolis (?)</a></li>
</ul>
</li>
	<li><a target="_blank" href="http://msdn2.microsoft.com/en-us/library/bb264518.aspx">Web Client Software Factory:</a>
<ul>
	<li>Stand: June 2007</li>
	<li>Ziel: Für ASP.NET Anwendungen</li>
</ul>
</li>
	<li><a target="_blank" href="http://msdn2.microsoft.com/en-us/library/aa480534.aspx">Web Service Software Factory:</a>
<ul>
	<li>Stand: July 2006</li>
	<li>Ziel: Serviceerstellungen (WCF / ASMX)</li>
</ul>
</li>
</ul>
<strong>Was benötige ich für die Software Factories und wie ist der Ablauf von den Factories?</strong>

Um die Software Factories zu nutzen benötigt man die <a target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyId=C0A394C0-5EEB-47C4-9F7B-71E51866A7ED&amp;displaylang=en">Guidance Automation Extensions</a>. Software Architekten (oder die, die es werden wollen) können diese Pakete auch editieren mit dem <a target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyId=E3D101DB-6EE1-4EC5-884E-97B27E49EAAE&amp;displaylang=en">Guidance Automation Toolkit</a>.
Alle Software Factories sind in einzelne Pakete gegliedert und integrieren sich vollständig ins Visual Studio 2005 oder Visual Studio 2008 (Beta 2)).
Den direkten Ablauf werde ich dann im nächsten HowTo zeigen.

Soviel erstmal zum Ablauf:
Es wird ein Grundgerüst erstellt (direkte C# Projekte in einer Solution) und man hat zu jedem einzelnen Projekt (je nach zugewiesener Responsibility) Kontextmenüs oder zusätzliche Optionen welche man einstellen muss oder kann. Dadurch "klickt" man sich quasi die Software zusammen. Anpassungen können natürlich trotzdem genommen werden - es ist nur ein Grundgerüst, dass man nutzen kann, aber nicht muss.
Wenn man sich natürlich zu sehr davon entfernt wäre es günstiger direkt die Pakete zu bearbeiten oder sich eine andere Methode auszudenken ;)

<strong>
Irgendwie kommt mir manches aus der Software Factory XY bekannt vor?</strong>

Die Service Factories bauen intern auf die <a target="_blank" href="http://msdn2.microsoft.com/en-us/library/aa480453.aspx">Enterprise Library</a> und auf einigen <a target="_blank" href="http://msdn2.microsoft.com/en-us/practices/bb190359.aspx">Application Blocks</a> auf - beides einen Blick wert.

<strong>Gibts sonst noch gute Informationen oder Downloadlinks?</strong>

Die Links auf die jeweilige Software Factory in der MSDN Library (siehe oben) zeigen eigentlich schon viele Links, Samples und Dokumente etc.
Ansonsten verweisen die MSDN Library Seiten auch <a target="_blank" href="http://codeplex.com/Project/ProjectDirectory.aspx?TagName=patterns%20%26%20practices">öfters auf Codeplex</a>, wo das p&amp;p Team (und die Community) einiges zum Download bereit hält.

In späteren HowTos werden wir das dann natürlich noch mehr Besprechen und wie die einzelnen Teile alle zusammenhängen.

<strong>Links:
</strong><a target="_blank" href="http://msdn2.microsoft.com/en-us/practices/default.aspx">Microsoft patterns&amp;pratices Site @ MSDN</a>
<a target="_blank" href="http://msdn2.microsoft.com/en-us/library/ms998572.aspx">Microsoft patterns&amp;pratices Site @ MSDN Library</a>
<a target="_blank" href="http://msdn2.microsoft.com/en-us/library/aa480471.aspx">Mobile Client Software Factory</a>
<a target="_blank" href="http://msdn2.microsoft.com/en-us/library/aa480482.aspx">Smart Client Software Factory</a> (<a target="_blank" href="http://windowsclient.net/Acropolis/">Codename Acropolis</a> &amp; <a target="_blank" href="http://blogs.msdn.com/Acropolis/">Codename Acropolis Blog</a>)
<a target="_blank" href="http://msdn2.microsoft.com/en-us/library/bb264518.aspx">Web Client Software Factory</a>
<a target="_blank" href="http://msdn2.microsoft.com/en-us/library/aa480534.aspx">Web Service Software Factory</a>
<a target="_blank" href="http://msdn2.microsoft.com/en-us/teamsystem/aa718948.aspx">Guidance Automation Extensions &amp; Toolkit Site</a>
<a target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyId=C0A394C0-5EEB-47C4-9F7B-71E51866A7ED&amp;displaylang=en">Guidance Automation Extensions Download</a>
<a target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyId=E3D101DB-6EE1-4EC5-884E-97B27E49EAAE&amp;displaylang=en">Guidance Automation Toolkit Download</a>
<a target="_blank" href="http://msdn2.microsoft.com/en-us/library/aa480453.aspx">Enterprise Library</a>
<a target="_blank" href="http://msdn2.microsoft.com/en-us/practices/bb190359.aspx">Applications Blocks</a>
