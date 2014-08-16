---
layout: page
title: "HowTo: Microsoft Silverlight 1.0 (Bilder &quot;kippen&quot; samt Spiegeleffekte)"
date: 2007-09-12 21:42
author: robert.muehsig
comments: true
categories: []
tags: []
---
{% include JB/setup %}
<a href="http://code-inside.de/blog/artikel/howto-microsoft-silverlight-10-dynamische-spiegeleffekte/">Gestern</a> ging es ja um die ersten "dynamischen" Berührungspunkte mit Silverlight - das fetzt zwar ja - aber noch nicht richtig. Text zu spiegel ist natürlich klasse, aber was ist denn mit Bildern oder gar Videos? Da ich momentan keine Videos zur Verfügung habe, werde ich das einfach mal anhand eines Bildes machen.

<strong>Grundproblematik:</strong> Silverlight nutzt zwar Teile von WPF, aber eben nur Teile. Eine wichtige Funktionalität fehlt bislang vollkommen (traurigerweise) : 3D. Es gibt zwar "3D" Beispiele mit Silverlight (das Beispiel von <a target="_blank" href="http://www.telerik.com/demos/aspnet/silverlight/Cube/Examples/RoomDesigner/DefaultCS.aspx">Telerik</a>), allerdings wenn man hinschaut, hat das nicht viel mit 3D zutun. Die Würfel werden nur verzerrt dargestellt, sodass es beinah aussieht wie 3D. Eigentlich müssten die Kanten nach hinten kürzer werden, bei dem Beispiel verändern sie sich aber kein Stück.

Es gibt noch eine kleine 3D Funktionalität, allerdings ist das eher schlecht als recht anzuprogrammieren. Auf <a target="_blank" href="http://www.codeplex.com/Balder">Codeplex gibts eine 3D Engine namens Balder</a>. Wer Interesse hat, sollte die mal anschauen, aber nicht zu viel erwarten.

Wir wollen am Ende sowas ähnliches (vom Effekt her - nicht die Funktionalität) wie dieser <a target="_blank" href="http://advertboy.wordpress.com/project-silverlight-11/">hier</a> erreichen (der iTunes Silverlight Clone).

<strong>Schritt 1: Beliebiges Bild von Amazon holen</strong>

Ich glaub den Schritt brauch ich nicht weiter kommentieren - ich hab das <a target="_blank" href="http://amazon.de/dp/3866454074/ref=s9_asin_image_2-1966_p/303-3639703-8211416?pf_rd_m=A3JWKAKR8XB7XF&amp;pf_rd_s=center-6&amp;pf_rd_r=1MMSKNCAH3H4NGHBJ0QM&amp;pf_rd_t=101&amp;pf_rd_p=142680291&amp;pf_rd_i=301128">Buchcover</a> gewählt. Speichert es lokal auf eurer Festplatte - DragnDrop direkt ins Expression Blend ging bei mir nicht.

<strong>Schritt 2: Silverlight Projekt (es ist egal ob 1.0 oder 1.1 - ich mach es mit 1.0) in Expression Blend 2 August Preview erstellen</strong>

Müsste ebenfalls noch bekannt sein aus den vorherigen HowTos ;)

<strong>Schritt 3:</strong> <strong>Bild hinzufügen</strong>

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image18.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images/image-thumb18.png" alt="image" height="187" style="border: 0px" /></a>

Recht schwach ist noch das "Add Existing Item..." zu sehen - dort einfach das Bild hinzufügen und dannach kann man es per DragnDrop auf die Arbeitsfläche ziehen:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image19.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images/image-thumb19.png" alt="image" height="218" style="border: 0px" /></a>

<strong>Schritt 4: Bild verzerren</strong>

Unter den "Properties" des Bildes findet man den Punkt "Transform", dort einfach mal bei "Skew" malÂ klicken und in dem Y Wert -15 eintragen:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image20.png"><img border="0" width="498" src="{{BASE_PATH}}/assets/wp-images/image-thumb20.png" alt="image" height="277" style="border: 0px" /></a>

Da es meiner Meinung nach jetzt etwas zu "schräg"/"schief" aussieht hab ich die Sache bei "Rotate" noch ein Wert von 1,1 gegeben - muss aber nicht sein.

<strong>Schritt 5: Spiegeleffekt hinzufügen</strong>

Das gesamte Bild (was ich inzwischeneinfach verkleinert hab, weil es ansonsten nicht auf die Fläche passte) hab ich kopiert und einfach etwas nach unten gezogen. Damit das Spiegelbild erstellt wird, müssen folgende Einzelschritte erledigt werden:

Y-Achse kippen:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image21.png"><img border="0" width="537" src="{{BASE_PATH}}/assets/wp-images/image-thumb21.png" alt="image" height="320" style="border: 0px" /></a>

Verzerrung umstellen auf -15:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image22.png"><img border="0" width="537" src="{{BASE_PATH}}/assets/wp-images/image-thumb22.png" alt="image" height="311" style="border: 0px" /></a>

Damit die nun direkt aufeinander passen beim Spiegelbild das Rotate wieder auf 0 setzen und an das Original ansetzen:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image23.png"><img border="0" width="534" src="{{BASE_PATH}}/assets/wp-images/image-thumb23.png" alt="image" height="293" style="border: 0px" /></a>

Durchscheineffekt hinzufügen:

Der Anfangspunkt (die lange leiste unten mit dem schwarzen "Kästel") war vorher direkt auf schwarz eingestellt, ich hab in dem Farbverlauf das auf fast weiß gesetzt undeinfach noch den AlphaKanal auf 41% gesetzt - ob das hinterher günstig ist, wird sich zeigen ;) - man kann den Wert aber auch auf 100% lassen. Selbst experimentieren ;)

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image24.png"><img border="0" width="651" src="{{BASE_PATH}}/assets/wp-images/image-thumb24.png" alt="image" height="280" style="border: 0px" /></a>

Der Endpunkt wurde ebenso angesetzt nur dass er dort direkt auf 100% durchsichtig gesetzt wurde.

Die Verlaufsrichtung noch anpassen (auf das Pfeilsymbol klicken) :

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image25.png"><img border="0" width="241" src="{{BASE_PATH}}/assets/wp-images/image-thumb25.png" alt="image" height="303" style="border: 0px" /></a>

Am Ende noch das etwas zurecht rücken und der Spiegeleffekt ist perfekt.

<strong>Schritt 6: Schatten beim Original hinzufügen</strong>

Um einen optischen Effekt noch hinzuzufügen, werd ich jetzt bei dem Originalbild noch ein leichten Schatten hinzufügen. Ich fands ganz schön ;)

Dafür legen wir ein Rectangle an dem Originalen an:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image26.png"><img border="0" width="70" src="{{BASE_PATH}}/assets/wp-images/image-thumb26.png" alt="image" height="205" style="border: 0px" /></a>

Hier muss jetzt leicht probiert werden - das Rectangle muss natürlich direkt an der Originalkante ran (d.h. etwas drehen) und ansonsten muss noch an der Größe rumgespielt werden. Der Farbverlauf muss angepasst werden und fertig.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image27.png"><img border="0" width="57" src="{{BASE_PATH}}/assets/wp-images/image-thumb27.png" alt="image" height="240" style="border: 0px" /></a>

<strong>Fertig: Ansicht im Browser</strong>

Direkt im Expression Blend können wir das nun testen - und das Ergebniss find ich erstmal recht ansprechend. Man kann es noch anpassen und insbesondere die Sache mit dem Setzen des Alphakanals macht mir jetzt Gedanken - aber für einen ersten Eindruck gehts und ist auch recht einfach.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image28.png"><img border="0" width="186" src="{{BASE_PATH}}/assets/wp-images/image-thumb28.png" alt="image" height="423" style="border: 0px" /></a>

Viel Spaß noch :)
