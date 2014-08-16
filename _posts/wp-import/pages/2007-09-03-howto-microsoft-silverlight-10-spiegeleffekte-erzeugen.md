---
layout: page
title: "HowTo: Microsoft Silverlight 1.0 (Spiegeleffekte erzeugen)"
date: 2007-09-03 20:46
author: robert.muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-microsoft-silverlight-10-spiegeleffekte-erzeugen
---
{% include JB/setup %}
Heute geht es eher um das Expression Tool "Microsoft Blend 2 (August Preview)". Gerne sieht man bei den tollen Silverlight Anwendungen Spiegeleffekt, aber wie erzeugt man diese? Hier in dem HowTo werde ich das kurz zeigen. Hier wird das "Hello World!" als Beispiel genutzt - die richtige Anwendung soll aber kreativer werden ;)

<strong>Schritt 1: Silverlight Projekt erstellen</strong>

Im Expression Blend 2 (August Preview) erstellen wir eine Silverlight 1.0 (mit Javascript) Anwendung.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image5.png"><img border="0" width="472" src="{{BASE_PATH}}/assets/wp-images/image-thumb5.png" alt="image" height="305" style="border: 0px" /></a>

Im Anschluss sieht man eine leere Seite.

Auf der linken Seite sieht man ein paar (wenige) Controls, z.B. das Canvas oder Text etc.. Auf der rechten Seite sieht man dann je nachdem was man anklickt die Eigenschaften des jeweiligen Objektes.

Es gibt auch die Möglichkeit direkt in den XAML Modus zu wechseln, sodass ihr euch anschauen könnt, was direkt im Markup sich verändert.

<strong>Schritt 2: Erste Begegnungen mit Expression Blend</strong>

Als erstes ändern wir die Hintergrundfarbe des gesamten Bildes von weiß zu schwarz, dazu gehen wir in die Eigenschaften des Canvas Objektes:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image6.png"><img border="0" width="259" src="{{BASE_PATH}}/assets/wp-images/image-thumb6.png" alt="image" height="124" style="border: 0px" /></a>

Auf der rechten Seite kann man nun unter dem Reiter "Properties" die Eigenschaften des Objektes direkt verändern:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image7.png"><img border="0" width="243" src="{{BASE_PATH}}/assets/wp-images/image-thumb7.png" alt="image" height="320" style="border: 0px" /></a>

Ändert hier nun die Farbe von weiß auf schwarz.

<strong>Schritt 3: "Hello World!" erstellen</strong>

Im Anschluss wird ein "TextBlock" erstellt - dieser befindet sich bei den Controls:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image8.png"><img border="0" width="59" src="{{BASE_PATH}}/assets/wp-images/image-thumb8.png" alt="image" height="198" style="border: 0px" /></a>

Damit nun ein "Hello World!" auf dem schwarzen Hintergrund erstellen und dannach die Textfarbe von schwarz auf weiß umstellen und die Schriftgröße unter "Text" ändern.

<strong>SchrittÂ 4: Den Spiegeleffekt erstellen</strong>

Der Spiegeleffekt wird nur mittels eines kleinen Tricks erstellt - man muss den TextBlock komplett kopieren und die Kopie etwas nach unten ziehen.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image9.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images/image-thumb9.png" alt="image" height="94" style="border: 0px" /></a>

Nun muss bei dieser Kopie noch der "Spiegeleffekt" eingestellt werden: Unter "Transform" bei den "Properties" auf "Flip" gehen und dort die Y-Achse "flippen":

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image10.png"><img border="0" width="335" src="{{BASE_PATH}}/assets/wp-images/image-thumb10.png" alt="image" height="142" style="border: 0px" /></a>

<strong>SchrittÂ 5: Farbverlauf erstellen</strong>

Jetzt haben wir die Schrift zwar gespiegelt, aber irgendwie fetzt es noch nicht, daher muss noch ein Farbverlauf rein.

Das ist eigentlich jetzt der kniffligste Moment: Leider hat wohl das Tool eine Macke, wenn es darum geht, Farbverläufe auf Texte zu setzen. Man muss den Text markieren um den Farbverlauf einzustellen, kann dort aber nur einen horizontalen Farbverlauf bekommen:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image11.png"><img border="0" width="326" src="{{BASE_PATH}}/assets/wp-images/image-thumb11.png" alt="image" height="214" style="border: 0px" /></a>

Eigentlich gibts dann noch diesen kleinen Pfeil um die Richtung zu bestimmen:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image12.png"><img border="0" width="45" src="{{BASE_PATH}}/assets/wp-images/image-thumb12.png" alt="image" height="50" style="border: 0px" /></a>

Allerdings verschwindet dann wieder die Markierung - ärgerlich wie ich finde (oder es lag doch an mir). Das macht aber nix, denn obwohl das Tool die gespiegelte und mit farbverlaufversehenene Fassung anzeigt, bekommt man einen Fehler wenn man es ausführt. Grund ist (laut Errormessage), dass das TextElement eigentlich nix ausser den eigentlichenÂ Text enthalten darf (-&gt; scheinbar, ansonsten würde es ja gehen).

Nun müssen wir ins XAML:

Vorher -

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image13.png"><img border="0" width="464" src="{{BASE_PATH}}/assets/wp-images/image-thumb13.png" alt="image" height="116" style="border: 0px" /></a>

Beachtet die Attribute "EndPoint" und "StartPoint". Hier müsst ihr den Farbverlauf nun manuell einstellen, ich hab es auf so eingestellt: EndPoint="1,1" StartPoint="1,0.2". Damit erhält man einen leichten Farbverlauf nach unten. Nun müssen wir noch das TextElement "Run" leer machen-Â  die untere Variante hat bei mir geklappt. Den LinearGradientBrush hab ich einfach in den Textblock geschoben:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image14.png"><img border="0" width="524" src="{{BASE_PATH}}/assets/wp-images/image-thumb14.png" alt="image" height="135" style="border: 0px" /></a>

<strong>Endresultat:</strong>

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image15.png"><img border="0" width="188" src="{{BASE_PATH}}/assets/wp-images/image-thumb15.png" alt="image" height="115" style="border: 0px" /></a>

(ich hab noch ein kleine Ellipse eingefügt - sahÂ cool ausÂ fand ich ;) )

Soviel erstmal dazu - heute ging es eher um Expression Blend - beim nächsten HowTo werde ich die Einbindung in unser ASP.NET AJAX Projekt zeigen und das ganze etwas dynamisieren ;)
