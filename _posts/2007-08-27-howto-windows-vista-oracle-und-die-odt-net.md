---
layout: page
title: "HowTo: Oracle 10g und die Oracle Developer Tools unter Vista "
date: 2007-08-27 10:39
author: oliver.guhr
comments: true
categories: []
tags: []
---
<strong>Einleitung</strong>

Um eine Verbindung zu einer Oracle Datenbank aufzubauen gibt es viele Wege. Der wohl einfachste für .NET ist die "<em>Oracle Developer Tools for Visual Studio .NET</em>" zu nutzen. Diese integrieren eine ganze Reihe an Tools und den Oracle Namespace in das Visual Studio. Nach erfolgreicher Installation gelingt das Ansprechen der Datenbank mit wenigen Zeilen Code, zusätzlich liefert Oracle viele nützliche Codebeispiele gleich mit. Die Installation dieser Tools unter Vista ist allerdings etwas umständlicher.
Anleitung
Das benötigen Sie:
1. Visual Studio 2005
2. Oracle 10g Client 10.2.0.3.0 for Vista
<a href="http://www.oracle.com/technology/software/products/database/oracle10g/htdocs/10203vista.html">http://www.oracle.com/technology/software/products/database/oracle10g/htdocs/10203vista.html</a>
Bei der Installation sollte man möglichst diese Reihenfolge beachten:
(Oracles <a href="http://" title="http://www.oracle.com/technology/software/tech/windows/odpnet/install10202.html">Installationsanleitung</a>)

<strong>Schritt 1:</strong>
Installieren Sie das Visual Studio 2005.

<strong>Schritt 2:</strong>
1. Installieren Sie den "<em>Oracle 10g Client 10.2.0.3.0 for Vista</em>" und wählen Sie die Installationsart "Administrator" aus.

<strong>Schritt 3:</strong>
Wenn Sie <em>Office 2007 </em>installiert haben:
1. Wechseln Sie in der Windows Komandozeile in das Verzeichnis "<oracle></oracle>\OUI\Bin"
2. Führen Sie "<em>setup.exe use_prereq_checker=false</em>" aus
3. Wichtig: Geben Sie als Installationsverzeichnis das Verzeichnis an, in das Sie den Oracle 10g Client in Schritt 2 installiert haben.

Wenn Sie <em>kein Office 2007</em> installiert haben:
1. Wechseln Sie in der Windows Kommandozeile in das Verzeichnis "<em><oracle></oracle>\OUI\Bin</em>"
2. Wichtig: Geben Sie als Installationsverzeichnis das Verzeichnis an, in das Sie den Oracle 10g Client in Schritt 2 installiert haben.

Als nächstes benötigten Sie die "product.xml", dazu müssen Sie dasÂ folgende Setups runterladen:
ODAC1020221.exe or ODTwithODAC1020221.exe
Wenn man diesen entpackt findet man die "product.xml".

Dazu dann später noch das dazugehörige Setup starten und die Orcale Components installieren und den TNS Name soweit anpassen.

Viel Spass!
