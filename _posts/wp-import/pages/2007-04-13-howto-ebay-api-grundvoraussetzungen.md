---
layout: page
title: "HowTo: eBay API (Grundvoraussetzungen)"
date: 2007-04-13 09:25
author: robert.muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-ebay-api-grundvoraussetzungen
---
{% include JB/setup %}
Das ist das erste HowTo auf dieser Seite und ich hoffe es werden noch mehrere Folgen.

In diesem HowTo geht es um die eBay API. die eBay API kann eine ganze Menge - ich würde beinah meinen, man kann mit der API fast alles machen, was man auch auf der eBay Seite machen kann: Suchen, Bieten, Kaufen, Verkaufen, Kommentare hinzufügen, Bewerten usw.

Die hier ist der erste Teil - alles was man für den Einstieg braucht. In den nächsten HowTos geh ich dann direkt auf das Programmieren mit der API in Zusammenhang mit .NET ein.

Wie auf unserer ShoppingMap zu sehen ist, verwenden wir die eBay API. Wenn man auf <a href="http://www.ebay.de">www.ebay.de</a> etwas weiter runterscrollt, fällt einem der Link hier auf: <a target="_blank" href="http://pages.ebay.de/entwickler/?ssPageName=home:f:f:DE" title="Entwicklerprogramm">Entwicklerprogramm</a>

Neben der eBay API bietet eBay selber noch mehrere andere interessante Entwicklerprogramme an, die bekanntesten sind aber wohl:
<ul>
	<li>- <a target="_blank" href="https://www.paypal.com/de/cgi-bin/webscr?cmd=p/pdn/intro-outside" title="Paypal Entwicklerprogramm">Paypal</a></li>
	<li>- <a target="_blank" href="https://developer.skype.com/DevZone" title="Skype Entwickerprogramm">Skype</a></li>
</ul>
<strong>Voraussetzung für das Nutzen der eBay API</strong>

Die eBay API kann jeder Nutzen und ist auch völlig kostenlos. Bedingung ist, dass man ein "normales" eBay Benutzerkonto hat und sich <a target="_blank" href="http://pages.ebay.de/entwickler/anmeldung.html" title="Anmeldung">als eBay Entwicklermitglied registriert.</a>
Die richtigen eBay Entwicklerseiten sind alle auf englisch. Was aber für alle deutschsprachigen eBay Entwickler interessant sein dürfte sind folgende Sachen:
- <a href="http://dev-forums.ebay.com/forum.jspa?forumID=7">Deutsches Entwicklerforum</a>
- <a target="_blank" href="http://developer.ebay.com/join/licenses/de" title="Lizenz von eBay">Deutschsprache API Lizenz</a>

Wer sich mehr mit der eBay API beschäftigen will, für den ist vielleicht auch die <a href="http://entwickler.ebay.de/konferenz/" title="Entwicklerkonferenz">1. eBay Entwicklerkonferenz in München</a> nicht verkehrt.

Nachdem man nun als eBay Entwickler unter der englischsprachigen Developer Seite angemeldet ist, braucht man bevor man direkt startet noch 3 Keys und ein Token.
Details zu allem, was jetzt hier steht, findet Ihr natürlich auch auf der Entwicklerseite von eBay: <a target="_blank" href="http://developer.ebay.com/quickstartguide" title="Quickstart">Quickstart</a>

Um Ihre Anwendung zu Testen, stellt eBay eine Testumgebung bereit, da es ja sehr gefährlich sein kann, nur mal so zum Testen 20 neue Produkte einzustellen ;)

<strong>eBay Keys und Tokens</strong>

Daher gibt es Sandbox und Productiv Keys.

Um die Sandbox nutzen zu können, muss man sich (ähnlich wie auf der richtigen eBay Seite) einen Sandbox User anlegen. Die kann unter dem Menüpunkt "My Account" geschehen.
Da ich selber nur auf eBay suche, habe ich auch nie einen Sandbox User angelegt und fahre deshalb gleich mit den Productiv Keys fort.

Um diese Keys zu erhalten, muss man einen kleinen <a target="_blank" href="http://developer.ebay.com/DevZone/launch/SelfCertify.asp" title="Self Certify - eBay Fragebogen">Fragebogen</a> zur Applikation ausfüllen. Nachdem dieser erfolgreich bestanden ist, bekommt man seine Keys mitgeteilt (und kann zudem 10.000 Aufrufe pro Monat an eBay schicken) und kann nun fortfahren, zum User Token.

Beim <a target="_blank" href="http://developer.ebay.com/tokentool/" title="Token Generator">Auth &amp; Auth Token Generator</a> bekommt man nun sein User Token. Hier ist die Unterscheidung zwischen Productiv und Sandbox wichtig.

Nachdem man nun alle 3 Keys (DevID, AppID, CertID) zusammenhat und auch das Token nicht fehlt kann man <a target="_blank" href="http://developer.ebay.com/DevZone/build-test/test-tool.asp" title="Test Tool">hier</a> seine Keys und auch die ersten Aufrufe mal testen.

<strong>Weiterführendes</strong>

Die eBay API wurde für viele Programmiersprachen ausgelegt und unterstützt diese auch, darunter PHP, die .NET Familie, Java... SOAP, XML und REST spielen auch eine Rolle. Für jedes einzelne gibt es sehr umfangreiche <a target="_blank" href="http://developer.ebay.com/support/docs/" title="eBay Dokus">Dokumentationen</a>.
Wenn man seine Anwendung, wie z.B. ShoppingMap, erfolgreich aufgebaut hat und feststellt das 10.000 Aufrufe pro Monat sehr knapp sind oder man in das <a href="http://cgi6.ebay.de/ws/eBayISAPI.dll?SolutionsDirectory">Applikationsverzeichnis</a> von eBay will, kann man dies auch völlig kostenlos machen:
<ul>
	<li>- <a target="_blank" href="http://pages.ebay.de/entwickler/services.html" title="Übersicht">Übersicht über alle Gebühren und Angeboten</a></li>
	<li>- <a target="_blank" href="http://developer.ebay.com/support/certification" title="eBay Certification">eBay Certification</a></li>
</ul>
Nach erfolgreichen Bestehen der Standard Prüfung darf man das <a href="http://developer.ebay.com/images/APILicenselogos/smallcompatibleapplogojpg">"Compatible Application" Logo</a> nutzen.

<strong>Logos - was man darf und nicht.</strong>
<ul>
	<li><strong>- <a href="http://developer.ebay.com/DevProgram/logoguidelines.pdf" title="eBay Lizenzbedingungen">(PDF) Lizenzbedingungen</a></strong></li>
</ul>
Beim nächsten HowTo werde ich die API Aufrufe erklären und zeigen, welche auch auf ShoppingMap zum Einsatz kommen. Bis dahin...

<a href="http://www.dotnetkicks.com/kick/?url=http://code-inside.de/blog/?page_id=15"><img border="0" src="http://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url=http://code-inside.de/blog/?page_id=15" alt="kick it on DotNetKicks.com" /></a>
