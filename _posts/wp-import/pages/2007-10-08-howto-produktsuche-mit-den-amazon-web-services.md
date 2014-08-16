---
layout: page
title: "HowTo: Produktsuche mit den Amazon Web Services"
date: 2007-10-08 19:52
author: robert.muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-produktsuche-mit-den-amazon-web-services
---
{% include JB/setup %}
Der Amazon Webserivce ist einer der meistgenutzten "richtige" Webservice. Ich selber habe diesen auch schön öfters genutzt, bislang blieb aber noch ein kleines HowTo aus.

In diesem HowTo werden wir schnell eine Produktsuche realisieren, ähnlich wie ich es bei der <a target="_blank" href="http://code-inside.de/blog/projekte/opensource-shoppingmap/" title="ShoppingMap Beispiel">ShoppingMap Beispielapplikation</a> getan habe.

Am Ende wird die Beispielapplikation auch zum Downloaden sein.

<strong>Schritt 1: Access Key besorgen</strong>

Der Link zu den (dt.) Einstiegsseiten ist in dem "Make Money" Bereich zu finden - direktunter Amazon Web Services.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image57.png"><img border="0" width="163" src="{{BASE_PATH}}/assets/wp-images/image-thumb36.png" alt="image" height="304" style="border: 0px" /></a>

Unter diesen <a target="_blank" href="http://www.amazon.com/webservices" title="Amazon Web Services">Direktlink</a> (den man auch in der dt. Einstiegsseite findet) man alle Web Services die Amazon anbietet:
<ul>
	<li>Amazon E-Commerce Service: Der bekannteste, u.a. mit Produktsuche oder Produktkauf.</li>
	<li>Amazon Elastic Compute Cloud: Wer Rechenkraft benötigt, könnte hier mal reinschauen.</li>
	<li>Amazon Flexible Payments Service: PayPal ähnliches System (* geschätzt - nie ausprobiert)</li>
	<li>Amazon Mechanical Turk</li>
	<li>Amazon Simple Storage Service</li>
	<li>Amazon Simple Queue Service</li>
	<li>Alex Web Services: Amazons hauseigene Suchmaschine <a target="_blank" href="http://alexa.com/">Alexa</a></li>
</ul>
Wir beschränken uns hier auf den E-Commerce Service.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image58.png"><img border="0" width="238" src="{{BASE_PATH}}/assets/wp-images/image-thumb37.png" alt="image" height="100" style="border: 0px" /></a>

Um einen Account anzulegen einfach den Schritten folgen, die auf der AWS Seite beschrieben sind:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image59.png"><img border="0" width="220" src="{{BASE_PATH}}/assets/wp-images/image-thumb38.png" alt="image" height="293" style="border: 0px" /></a>

Nachdem das geschehen ist, hat man zwei Keys:

<strong>- Access Key:</strong> Damit kann Amazon nachverfolgen, wer was mit dem Webservice macht.

<strong>- Associates Account:</strong> Mit diesem Accout kann man etwas Geld verdienen indem bei Links die von Amazon kommen (z.B. bei einer Produktsuche wie wir es vor haben), dass ein bestimmter Parameter noch an die URL drangehängt wird. Wird viel über solche Links gekauft, bekommt man selber Geld.

Die Accountinformationen findet man auch hier später wieder:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image60.png"><img border="0" width="200" src="{{BASE_PATH}}/assets/wp-images/image-thumb39.png" alt="image" height="235" style="border: 0px" /></a>

Unter "AWS Access Identifiers" findet man seinen Access Key sowie den Secret Access Key.

<strong>Schritt 2: WSDL finden</strong>

Um an die WSDL zu gelangen genügt es wieder auf die Amazon E-Commerce Service Seite zurückzugehen und sich einfach mal diese Links zu gemüte führt.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image61.png"><img border="0" width="354" src="{{BASE_PATH}}/assets/wp-images/image-thumb40.png" alt="image" height="118" style="border: 0px" /></a>Â 

<strong>Schritt 3: Demoapplikation und Webserive einbinden</strong>

Für unsere Beispielapplikation erstellen wir eine Konsolenanwendung und integrieren den Webservice.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image62.png"><img border="0" width="638" src="{{BASE_PATH}}/assets/wp-images/image-thumb41.png" alt="image" height="192" style="border: 0px" /></a>

Nachdem wir (im Standardfall!) den Namespace "[Projektname].com.amazon.webservices" eingebunden haben, können wir den Webserice nutzen.

Die Hauptklasse "<strong><em>AWSECommerceService</em></strong>" fungiert dabei als Zentrum des ganzen. Er nimmt Requests entgegen und gibt Response zurück.

In unserem Beispiel wollen wir eine "<strong><em>ItemSearch</em></strong>" Operation ausführen, und geben unseren Request darin ein. Daher übergibt man der "<strong><em>ItemSearch</em></strong>" Methode derÂ "<strong><em>AWSECommerceService</em></strong>" Klasse ein "<strong>ItemSearch</strong>" Objekt, welche wiederrum ein "<strong><em>ItemSearchRequest</em></strong>" Objekt enthält. Die Response "<strong><em>ItemSearchResponse</em></strong>" bekommen wir durch den Rückgabewert der "<strong><em>ItemSearch</em></strong>" Methode. Easy oder? Am besten ihr schaut euch das im Programmcode an.

Die Keys werden dabei jeder Operation einzeln übergeben.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image63.png"><img border="0" width="632" src="{{BASE_PATH}}/assets/wp-images/image-thumb42.png" alt="image" height="273" style="border: 0px" /></a>

Eigentlich ist es recht einfach - wenn man das Modell verstanden hat, kann man noch sehr viele interessante Dinge machen.

Hier gibts auch noch den Democode zum Runterladen:

<a href="http://{{BASE_PATH}}/assets/files/democode/amazondemo/amazondemosource.zip" title="AmazonDemo Source">[Source Code runterladen]</a>

<strong>Links:</strong>

<a target="_blank" href="http://www.amazon.com/webservices" title="Amazon Web Services (engl.)">Amazon Web Services (engl.)</a>
<a target="_blank" href="http://developer.amazonwebservices.com/connect/forum.jspa?forumID=9">Amazon E-Commerce Service Forum (engl.)</a>
<a target="_blank" href="http://webservices.amazon.com/AWSECommerceService/AWSECommerceService.wsdl?">Amazon E-Commerce Service WSDL</a>
<a target="_blank" href="http://developer.amazonwebservices.com/connect/kbcategory.jspa?categoryID=19">Amazon E-Commerce Reference</a>
<a href="http://{{BASE_PATH}}/assets/files/democode/amazondemo/amazondemosource.zip" title="Demo Source Code runterladen">Demo Source Code runterladen</a>
