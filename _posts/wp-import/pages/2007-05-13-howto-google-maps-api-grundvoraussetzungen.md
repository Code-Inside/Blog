---
layout: page
title: "HowTo: Google Maps API (Grundvoraussetzungen)"
date: 2007-05-13 21:55
author: robert.muehsig
comments: true
categories: []
tags: []
---
{% include JB/setup %}
Die wohl berühmteste Mashup API ist die <a target="_blank" href="http://www.google.com/apis/maps/" title="Google Maps API">Google Maps API</a>. Wie der Name schon erahnen lässt, geht es um den Kartendienst von Google.

Grundsätzlich ist der Dienst kostenlos, allerdings ist ein genauerer Blick in die <a href="http://www.google.com/apis/maps/terms.html" title="Google Maps Terms">Nutzungsbedingungen</a> nicht verkehrt. Wichtigster Punkt ist wahrscheinlich erstmal die Beschränkung auf 50.000 Aufrufe pro TagÂ um bestimmte Standorte zu lokalisieren.
Wenn dies überschritten ist, sollte man sich mit Google auseinander setzen. Leider ist die Informationspolitik seitens Google nur unvollständig.

Wichtigste Einschränkungen:
- 50.000 Georequests per Day
- keine Routingfunktion

Die normale Routingfunktion, wie man sie aus Google Maps kennt, ist noch nicht für alle offen. Es gibt aber Spekulationen, das dies wohl bald nachgereicht werden soll.

Grundsätzliche Funktionsweise:
Google Maps ist im Grunde eine Javascript Bibliothek mit der Google Maps Oberfläche. Die Technik dahinter basiert auf AJAX. Die eingebundene Google Maps Karte kann mit der umfassenden <a href="http://www.google.com/apis/maps/documentation/#API_Overview" title="API Overview">Bibliothek</a>Â "bearbeitet" und in der Darstellung verändert werden.

Da es im Prinzip nur ein eingebundenes Javascript ist, läuft es auf jedem Webserver und in allen unterstützen Browsern. Keine weiteren Plugins sind nötig.

Â Um den Dienst zu nutzen, muss man sich unter <a href="http://www.google.com/apis/maps/signup.html" title="Signup for Google Maps">dieser Adresse </a>registrieren. Man benötigt dazu ein Google Konto, was aber ebenfalls kostenlos ist.Â 
In der Registrierung für den Google Map Key muss man seine URL eingeben unter der späterÂ die Website erreichbar ist.Â Da man natürlich nicht immer auf dem Live-SystemÂ entwickelt,Â hab ich mir selber (weil ich viele Keys wieder vergessen habe)Â für die "localhost"Â Adresse mehrere Keys generiert. Da unter ASP.NET derÂ Webserver auf einen anderen Port läuft, musste ich auch für den jeweiligen Port einen eigenen Key anlegen.Â 
Wie man sieht, kannÂ man im Prinzip so viele Keys wieÂ man möchte anlegen.

Um mal zu sehen, wie man relativ einfach die Google Map einbinden kann, hat Google dieses Tool zur Verfügung gestellt: <a href="http://www.google.com/uds/solutions/wizards/mapsearch.html" title="Map Search Wizard">Map Search Wizard.</a>

Dies wars erstmal wieder zu denÂ Grundvoraussetzung. Mehr ist für den einfachen Gebrauch erstmal nicht relevant. In späteren HowTos wird dann näher auf die eigentliche API eingegangen.
