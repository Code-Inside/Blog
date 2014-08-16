---
layout: post
title: "Vergleichstest 2: String vs. StringBuilder "
date: 2007-07-11 21:22
author: oliver.guhr
comments: true
categories: [Allgemein]
tags: [.NET]
---
{% include JB/setup %}
Ich habe gerade mit dem Code aus Roberts Vergleichstest noch etwas gespielt.

<strong>Test 1</strong>
Als erstes habe ich die Anzahl der Durchläufe auf 1000 erhöht.

1. String mit +=
3,2012 ms bis 7,9336 ms

2. String mit StringBuilder
0,0595 ms bis 0,0603 ms

<strong>Test 2</strong>
Weil man aber meistens nicht nur einen String verbindet, sondern mehrere habe ich den Code angepasst:

returnString += "noch" + "ein" + "Test"; <strong>vs.</strong> returnString.Append("noch"+"ein"+"test");
1. String mit +=
33,3514 ms bis 28,0035 ms
<strong>2. String mit StringBuilder
0,0835 ms bis 0,1801 ms</strong>
Das heisst das sich bei "+=" die Zeiten verzehnfacht (!) haben wärend sie sich die Zeiten bei dem StringBuilder nur verdoppelt haben.

<strong>Test 3</strong>
Manchmal sieht man auch diese Variante um den Code übersichtlich zu halten:

returnString += "noch";
returnString += "ein";
returnString += "Test";

vs.

returnString.Append("noch");
returnString.Append("ein");
returnString.Append("test");


1. String mit +=
174,3137 ms bis 36,2311 ms

2. String mit StringBuilder
0,1625 ms bis 0,2123 ms

Diese Schreibweise += hat sich als echter Performance Killer erwiesen, die selbe Aufgabe benötigte nochmal ein vielfaches der Zeit.

<strong>Test 4</strong>
Also sollte ich jetzt immer den StringBuilder benutzen? Dazu habe ich einen Test mit nur einem Durchlauf, mit dem Code von Test 3, gemacht.

1. String mit +=
0,003 ms

2. String mit StringBuilder
0,0036 ms bis 0,0053 ms

Bei diesem Test ergaben sich sogar Vorteile für die += Variante. Auch nach dem 5. Test blieb die Zeit 0,003 ms.

<strong>Fazit</strong>

Der StringBuilder bringt Performance Vorteile, wenn man viele Strings verknüpfen muss, bei wenigen aufrufen kann man getrost zur bequemeren += Variante griefen. Der Vorteil für den StringBuilder wurde bei dem Code von Test 3 ab 10 durchläufen deutlich.
Für einfachste Aufgaben kann man die += Schreibweise nutzen, wenn's aber aufwendiger wird ergeben sich deutliche Vorteile für den StringBuilder.
