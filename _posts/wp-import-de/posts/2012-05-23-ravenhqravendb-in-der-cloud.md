---
layout: post
title: "RavenHQ–RavenDB in der Cloud"
date: 2012-05-23 00:46
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [Cloud, RavenDB, RavenHQ]
language: de
---
{% include JB/setup %}
<p>Ayende Rahien hat <a href="http://ayende.com/blog/156289/ravenhq-goes-out-of-beta">es heute verkündet</a> – RavenHQ, der RavenDB Cloud Hoster (natürlich von und mit Ayende) ist ab heute raus aus der Beta und man kann es von überall aus nutzen. In der Betaphase waren nur Nutzer von AppHarbor zugelassen.</p> <p><strong>Was ist RavenHQ?</strong></p> <p><a href="https://ravenhq.com/">RavenHQ</a> ist im Grunde ein gehostes <a href="https://ravendb.net/">RavenDB</a> in den Rechenzentren von <a href="https://appharbor.com/">AppHarbor</a>. Ähnliches wäre z.B. die SQL Variante auf Azure oder MongoHQ – eigentlich gibts zu fast allen NoSQL Lösungen auch Hoster ;)</p> <p><strong>Was hat man von RavenHQ?</strong></p> <p>Ein Wort: Backups. Vielleicht auch sechs: Die Jungs sind cleverer als ich. RavenHQ nimmt einen die Bürde des Datenbank Managements und fertig Backups an und spielt Updates ein. Nebenbei macht es natürlich den Einstieg in die Entwicklung mit RavenDB wesentlich einfacher. Wer RavenDB lieber selber hostet – auch kein Problem – es ist nur eine Variante RavenDB zu nutzen :) </p> <p><strong>Erste Schritte in RavenHQ</strong></p> <p>Nach der völlig kostenlosen Anmeldung aur <a href="https://ravenhq.com/">RavenHQ.com</a> erblickt man eine schlanke Oberfläche. Erste Aufgabe: Eine Datenbank anlegen.</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1557.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb718.png" width="599" height="212"></a></p> <p><strong>RavenHQ Preisspanne – von kostenlos bis 500$</strong></p> <p>Bei der Anlage einer Datenbank wählt man seine Plan aus. Solange man keine Rechnungsdaten hinterlegt hat gibt es aber nur die “Bronze” Variante. Diese ist kostenlos und reicht zum Experimentieren aus. Die einzelnen <a href="https://ravenhq.com/Pricing">Featuresets sieht man hier</a>.</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1558.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb719.png" width="601" height="613"></a></p> <p><strong>RavenHQ ConnectionString + ApiKey</strong></p> <p>Nach der Anlage der Datenbank kann man sich Details zur Datenbank anschauen (verbrauchter Speicherplatz), die Datenbank über “Admin Tasks” löschen und den Plan über “Upgrade” ändern. Wichtigster Punkt am Anfang ist der ConnectionString, welchen wir auch gleich benötigen.</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1559.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb720.png" width="605" height="302"></a></p> <p>Die Angaben sollten natürlich streng geheim bleiben – aber die Datenbank, welche hier abgebildet ist, existiert ohnehin nicht mehr ;)</p> <p><strong>RavenDB Management – in the Cloud!</strong></p> <p>Natürlich kommt auch die Management Software mit. Der Link ist unter dem “Database Information” zu finden.</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1560.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb721.png" width="483" height="324"></a></p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1561.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb722.png" width="484" height="376"></a></p> <p><strong>Demo Projekt</strong></p> <p>Um zu zeigen wie easy das ist, mal eine winzige ASP.NET MVC DemoApp.</p> <p>Den RavenDB Client via NuGet runterladen:</p>   <p><a href="{{BASE_PATH}}/assets/wp-images-de/SNAGHTML670bb06.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="SNAGHTML670bb06" border="0" alt="SNAGHTML670bb06" src="{{BASE_PATH}}/assets/wp-images-de/SNAGHTML670bb06_thumb.png" width="479" height="331"></a></p> <p>Achtung: Den Code würde ich so nicht in ernsthaften Projekten einsetzen!</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0b819a51-6cd2-4d98-8f24-141f1d3d5d77" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public ActionResult Index()
        {
            using (var documentStore = new DocumentStore { Url="https://1.ravenhq.com/databases/Robert0Muehsig-CodeInside", ApiKey="c4c3c135-e202-4a9e-b7d7-baa67298722a" })
			{
				documentStore.Initialize();

			    using(var session = documentStore.OpenSession())
			    {
			        var album = session.Load&lt;Album&gt;("albums/609");
                    ViewBag.Message = "Album Nr. 609 on RavenHQ cost about " + album.Price;
			    }


			}

            return View();
        }</pre></div>
<p>&nbsp;</p>
<p>Nicht schön, aber dafür zeigen wir Daten von RavenHQ an!</p>







<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1562.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb723.png" width="375" height="186"></a></p>
<p>Das Projekt findet ihr <a href="https://github.com/Code-Inside/Samples/tree/master/2012/RavenHQ">hier</a> – auch wenn es nicht wirklich viel ist ;)</p>
<p><strong>Was gibt es Negatives?</strong></p>
<p>Aktuell ist RavenHQ in US Rechenzentren gehostet, erst in ca. 2 Monaten stehen auch europäische Rechenzentren mit RavenDB bereit:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1563.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb724.png" width="450" height="89"></a></p>
<p>Natürlich sollte man <a href="{{BASE_PATH}}/2010/08/05/europische-data-center-von-microsoft-co-vs-us-patriot-act/">sich immer überlegen</a>, ob man die Daten fremdhosten möchte und wenn es um sensible Kundendaten geht den Kunden entsprechend auch aufmerksam machen. </p>
<p><strong>RavenDB Lizenzieren oder auf RavenHQ “mit nutzen”</strong></p>
<p>RavenDB ist Open Source, allerdings benötigt man für <a href="http://ravendb.net/licensing">den kommerziellen Einsatz eine Lizenz</a>. Wer RavenHQ nutzt, bekommt auch für Closed Source Applikationen eine Lizenz. Damit relativiert sich der Preis doch noch um einiges wie ich finde.</p>
