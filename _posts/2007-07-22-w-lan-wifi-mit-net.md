---
layout: post
title: "W-Lan / Wifi mit .NET "
date: 2007-07-22 19:17
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [.NET, Windows, Wlan]
---
Wer schon immer mal seinen eigenen W-Lan Scanner oder ein eigenes Verwaltungsprogramm für seine W-Lan Einstellungen schreiben will, für den ist der nachfolgende Text bestimmt interessant.

Wer Signalstärke oder SSIDs scannen will, der kann sich wunderbar mit <a href="http://code-inside.de/blog/nachschlagewerk/system-management/" title="Code-Inside: System.Management">WMI</a> auseinander setzen. Über WMI kann man auf allerhand Hardware- und PC-Eigenschaften zugreifen. Mit .NET ist es auch leicht durch den Namespace System.Management möglich WMI anzusprechen.

W-Lan Eigenschaften wie das setzen der Authentifizierung kann jedoch nicht über WMI gesetzt werden. Um solche Details zu setzen muss erstmal eine Grundvoraussetzung gesetzt sein: Windows muss für die Verwaltung der W-Lan Einstellung verantwortlich sein. Sobald angenommen das Intel-Wireless-Lan-Tool läuft, geht mein folgender Weg nicht.

Mit Windows XP SP 2 kam eine W-Lan API hinzu: Die <a target="_blank" href="http://msdn2.microsoft.com/en-us/library/ms706593.aspx" title="MSDN Wireless Zero Configuration (WZC)">Wireless-Zero-Configuration (WZC). </a>Diese ist für C/C++ Programmierer gedacht und ist daher für einen "normalen" .NET Entwickler erstmal äußerst hässlich. Da es außerdem auch bei dieser API zu Problemen kam, bietet MS einen Aufsatz für XP für diese API an: Die <a target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyID=52a43bab-dc4e-413f-ac71-158efd1ada50&amp;DisplayLang=en" title="MS Download Wireless Lan API">Wireless Lan API</a> - welche aber auch als <a target="_blank" href="http://msdn2.microsoft.com/en-us/library/ms706556.aspx" title="MSDN Native Wifi API">Native Wifi API </a>bezeichnet wird - unter Vista hat es allerdings mehr funktionen.
Das Update kann direkt von MS runtergeladen werden, erfordert aber eine WGA Prüfung.

Diese Native Wifi API (Vista) oder Wireless Lan API (XP SP2) sind allerdings auch eher für C/C++ Programmierer gedacht. Abhilfe schafft dieser Wrapper: <a target="_blank" href="http://www.codeplex.com/managedwifi" title="Codeplex Managed Wifi API">Managed Wifi API</a>

Mit dieser ist es leicht möglich Profileinstellungen zu setzen oder sich mit einem bestimmten W-Lan zu verbinden etc.

Tipp: <a target="_blank" href="http://msdn2.microsoft.com/en-us/library/aa369853.aspx" title="MSDN W-Lan Profiles">W-Lan Profile </a>können als XML importiert und exportiert werden. Da das XML doch recht doof aufgebaut ist, kann man es unter Vista einfach mit dem "netsh"-Befehl erstellen. Unter Vista gibt es direkt einen W-Lan Kontext.
Ein weiterer Tipp: Als ich das W-Lan XML Profil mit der Klasse XmlDocument geladen habe funktionierte es unter Vista ohne Probleme. Unter XP (mit der managed API) kam der Fehler, dass das XML Dokument ungültig ist. Abhilfe schaffte es, die XML Datei einfach über einen Textreader einzulesen.
