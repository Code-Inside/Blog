---
layout: page
title: "HowTo: Microsoft p&p - Web Service Factory / Service Factory (Teil 3: Praktisches &quot;Hello World&quot;)"
date: 2007-10-24 00:43
author: robert.muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-microsoft-pp-web-service-factory-service-factory-teil-3-praktisches-hello-world
---
{% include JB/setup %}
In den letzten Beiden (<a href="{{BASE_PATH}}/artikel/howto-microsoft-pp-web-service-factory-service-factory-teil-1-grundlagen-asmx-variante/">Teil 1</a>, <a href="{{BASE_PATH}}/artikel/howto-microsoft-pp-web-service-factory-service-factory-teil-2-wcf-variante/">Teil 2</a> (und dem <a href="{{BASE_PATH}}/artikel/howto-microsoft-patterns-practices-software-factories-verstehen/">"Grundkurs für Software Factories"))</a> ging es um die Grundlagen und um die <a href="http://www.codeplex.com/servicefactory/Wiki/View.aspx?title=HandsOnLab&amp;referringTitle=Home">HOLs</a> - jetzt setzen wir das mal selber um.
Ich werde das hier alles Schritt für Schritt zeigen und erklären - diesmal wirds sehr Bilderreich.

<strong>Das Szenario:</strong>
Ich möchte nur einen sehr einfachen Webservice erstellen - eine Art "Hello World" Beispiel. Wir möchten ein Buzzword (oder in Fachkreisen auch Bull***t) Katalog anfertigen.

<strong>Vorbereitung:</strong>

- <a href="http://www.microsoft.com/downloads/details.aspx?FamilyId=E3D101DB-6EE1-4EC5-884E-97B27E49EAAE&amp;displaylang=en">GAT</a> / <a href="http://www.microsoft.com/downloads/details.aspx?FamilyId=C0A394C0-5EEB-47C4-9F7B-71E51866A7ED&amp;displaylang=en">GAX</a> sowie natürlich <a href="http://www.microsoft.com/germany/msdn/vstudio/products/express/default.mspx">Visual Studio 2005</a>
- <a href="http://www.microsoft.com/downloads/details.aspx?familyid=db996113-6e92-4894-9b7e-0debb614d72f%20&amp;displaylang=en">Service Factory</a>
- <a href="http://www.microsoft.com/germany/msdn/vstudio/products/express/sql/default.mspx">Microsoft SQL Server (Express reicht aus)</a>
- <a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=c243a5ae-4bd1-4e3d-94b8-5a0f62bf7796&amp;DisplayLang=de">Microsoft SQL Server Management Studio</a>

<strong>Schritt 1: MS SQL Datenbank erstellen</strong>

Wir verbinden uns zur MS SQL (Express) Datenbank und lassen die Standardwerte.
<u>Zu Beachten ist:</u> Das Microsoft SQL Server Management Studio sollte mit Administratorrechten laufen, sonst kommt es beim Anlegen der DB zu einem Fehler!

<strong><a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image87.png"><img border="0" width="243" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb66.png" alt="image" height="182" style="border: 0px" /></a> </strong>

Dannach legen wir eine neue Datenbank an...

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image88.png"><img border="0" width="246" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb67.png" alt="image" height="151" style="border: 0px" /></a>

<strong><a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image89.png"><img border="0" width="340" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb68.png" alt="image" height="120" style="border: 0px" /></a> </strong>

... und benennen diese "<strong>Buzzword</strong>" und lassen die restlichen Standardparameter und Optionen so.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image90.png"><img border="0" width="187" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb69.png" alt="image" height="103" style="border: 0px" /></a>

Dannach legen wir uns eine neue Tabelle an...

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image91.png"><img border="0" width="359" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb70.png" alt="image" height="59" style="border: 0px" /></a>

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image92.png"><img border="0" width="367" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb71.png" alt="image" height="108" style="border: 0px" /></a>

welche zwei Spalten hat:
<ul>
	<li>id: int (NULL nicht zulassen &amp; Primärschlüssel &amp; als ID festlegen) - einfache Zählvariable</li>
	<li>name: nvchar(50) (NULL NICHT zulassen!) - das wird unser Lagerort für unser Wörter ;)</li>
</ul>
<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image93.png"><img border="0" width="258" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb72.png" alt="image" height="94" style="border: 0px" /></a>

... und benennen diese "<strong>buzzwords</strong>".

<strong>Schritt 2: Service Factory Projekt anlegen</strong>

Im Visual Studio erstellen wir jetzt unser "BlogPosts.Buzzwords" Projekt.
<u>Beachtet</u>: Bitte mit Administrator Rechten ausführen!

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image94.png"><img border="0" width="408" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb73.png" alt="image" height="274" style="border: 0px" /></a>

Die Solution Properties lassen wir ebenso...

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image95.png"><img border="0" width="415" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb74.png" alt="image" height="308" style="border: 0px" /></a>

... und schon haben wir unsere Projektstruktur:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image96.png"><img border="0" width="314" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb75.png" alt="image" height="297" style="border: 0px" /></a>

<strong>Schritt 3: DB Verbindungsdaten hinterlegen</strong>

Um die Database Connection zu hinterlegen, gehen wir auf die Service Factory (Data Access) Eigentschaften des Hosts.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image97.png"><img border="0" width="402" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb76.png" alt="image" height="162" style="border: 0px" /></a>

Geben dort als Connection Name "<strong>Buzzwords</strong>" ein und wählen den MS SQL Server als Datenquelle...

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image98.png"><img border="0" width="424" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb77.png" alt="image" height="290" style="border: 0px" /></a>

... und stellen unsere Verbindungseinstellungen ein.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image99.png"><img border="0" width="252" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb78.png" alt="image" height="344" style="border: 0px" /></a> 

<strong>Schritt 4: BusinessEntities erzeugen</strong>

Also nächstes wollen wir direkt eine Klasse anhand der DB Struktur erstellen, also auf die BusinessEntities und dann "Create business entities from database".

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image100.png"><img border="0" width="378" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb79.png" alt="image" height="72" style="border: 0px" /></a>

Das Hostprojekt und den passenden Connection name wählen...

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image101.png"><img border="0" width="470" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb80.png" alt="image" height="75" style="border: 0px" /></a>

... unsere Tabelle auswählen...

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image102.png"><img border="0" width="469" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb81.png" alt="image" height="96" style="border: 0px" /></a>

... und aus dem aus der DB stammenden "buzzwords" ein "Buzzword" machen - sieht im .NET Code schöner aus.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image103.png"><img border="0" width="469" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb82.png" alt="image" height="62" style="border: 0px" /></a>

Resultat:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image104.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb83.png" alt="image" height="68" style="border: 0px" /></a>

<strong>Schritt 5: In der Data Access CRUD Befehle erstellen</strong>

Um die Datenbank auch mit Daten zu befüttern kann man direkt CRUD Befehle erstellen:
Create/Read/Update/Delete.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image105.png"><img border="0" width="484" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb84.png" alt="image" height="114" style="border: 0px" /></a>

Dazu werden stored procedures erstellt... 

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image106.png"><img border="0" width="482" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb85.png" alt="image" height="229" style="border: 0px" /></a>

... welche man am Ende als SQL File in dem Projektordner wieder sieht.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image107.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb86.png" alt="image" height="77" style="border: 0px" /></a>

 Dies kann man nun per Kommandozeile oder per SQL Studio machen:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image108.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb87.png" alt="image" height="63" style="border: 0px" /></a>

Einfach das SQL reinkopieren und ausführen, als Ergebniss erhält man alle Stored Procedures:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image109.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb88.png" alt="image" height="218" style="border: 0px" /></a>

<strong>Schritt 6: Data Repository Klassen erschaffen</strong>

Um die Daten auch abzurufen, muss man Data Repository Klassen erstellen, dabei werden diese Anhand der Business Entities geniert.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image110.png"><img border="0" width="397" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb89.png" alt="image" height="82" style="border: 0px" /></a>

Man selber wählt anhand der Stored Procedur ein Mapping zu den Entities (wie in dem Screenshot zu sehen). 

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image111.png"><img border="0" width="486" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb90.png" alt="image" height="331" style="border: 0px" /></a>

Resultat:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image112.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb91.png" alt="image" height="184" style="border: 0px" /></a> 

<strong>Schritt 7: BusinessLogic erschaffen</strong>

Die BusinessLogic ist das Bindeglied zwischen dem was man machen will und den Repository Klassen. Dieser Code muss per Hand geschrieben werden - ist aber nicht viel, da das meiste bereits die anderen Klassen machen.

<u>Beispielcode aus dem BuzzwordListManager:</u>

class BuzzwordListManager
{
    public List&lt;Buzzword&gt; Load()
    {
        BuzzwordRepository rep = new BuzzwordRepository("Buzzword");
        List&lt;Buzzword&gt; result = rep.GetAllFrombuzzwords();
        if (result == null)
        {
            // Not found
            throw new NotImplementedException();
        }
        return result;
    }
}

Resultat:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image113.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb92.png" alt="image" height="94" style="border: 0px" /></a>

<strong>Schritt 8: Service - DataContract erschaffen</strong>

Jetzt kommen wir zu der Service Interface Schicht.
DataContracts sind im Prinzip wieder Klassen, welche der Webservice entweder als Request oder als Response weitergibt.
Dadurch muss man nicht seine eigene BusinessLogic veröffentlichen oder ist bei Änderungen der jeweiligen Seite nicht so abhängig.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image114.png"><img border="0" width="387" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb93.png" alt="image" height="135" style="border: 0px" /></a>

Das Anlegen der Members geht über solch ein Grid, als Typen können die allgemeinen .NET Klassen genommen werden, aber auch andere DataContract Klassen. Die Klassen können auch kombiniert werden. Es gibt auch noch mehr Varianten, dies ist aber am Besten nachzulesen in der <a href="http://www.codeplex.com/servicefactory">Hilfe</a>.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image115.png"><img border="0" width="395" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb94.png" alt="image" height="106" style="border: 0px" /></a>

Resultat:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image116.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb95.png" alt="image" height="71" style="border: 0px" /></a>

<strong>Schritt 9: Service - ServiceContract erschaffen</strong>

Nachdem wir jetzt die Members des Service definiert haben, gilt es nun daran zu definieren, welche Schnittstellen der Service überhaupt haben soll.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image117.png"><img border="0" width="386" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb96.png" alt="image" height="104" style="border: 0px" /></a>

Hier legt man ein Namen für das Interface fest, sowie der XML namespace etc.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image118.png"><img border="0" width="476" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb97.png" alt="image" height="182" style="border: 0px" /></a>

Dannach definiert man die Operationen mit den Requests und den Response Objekten.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image119.png"><img border="0" width="472" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb98.png" alt="image" height="72" style="border: 0px" /></a>

Resultat:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image120.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb99.png" alt="image" height="68" style="border: 0px" /></a>

<strong>Schritt 10: Service - ServiceImplementation - Mapping des DataContracts auf die BusinessEntities</strong>

Nun kommen wir zum nächsten Punkt: Die Contracts sind soweit fertig, die BusinessLogic &amp; Entities ebenfalls - allerdings fehlt noch das Mapping dazwischen: Dazu gibts Contract Translators.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image121.png"><img border="0" width="338" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb100.png" alt="image" height="85" style="border: 0px" /></a>

Ein kleiner Fehler gibt es in dem Interface, welches aber bekannt ist:
Die Eingabefelder für das Mapping sind grau unterlegt, allerdings einfach mit der Maus auf das Feld klicken und dann Enter oder Leertaste drücken - schon kommt man zum Auswahlmenü.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image122.png"><img border="0" width="495" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb101.png" alt="image" height="224" style="border: 0px" /></a>

Hier wählt man nun zwei Klassen aus, welche man mappen möchte. In unserem Fall ist das natürlich sehr einfach:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image123.png"><img border="0" width="499" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb102.png" alt="image" height="162" style="border: 0px" /></a>

Im Anschluss erfolgt das Mapping der einzelnen Properties und eine TranslateBetweenXXXAndYYY entsteht.

<strong><a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image124.png"><img border="0" width="205" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb103.png" alt="image" height="65" style="border: 0px" /></a> </strong>

Resultat:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image125.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb104.png" alt="image" height="57" style="border: 0px" /></a>

<strong>Schritt 11: Service - ServiceImplementation</strong>

Jetzt kommen wir zum Hauptteil - und noch etwas Schreibarbeit:
Die Implementation des ganzen.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image126.png"><img border="0" width="366" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb105.png" alt="image" height="64" style="border: 0px" /></a>

Dabei implementiert man den ServiceContract, welcher als Request / Response die Teile aus dem DataContract nimmt.
In der Implementation greift man auf den Translator zu, damit man die BusinessLogic nutzen kann. 

<u>Beispielcode aus dem BuzzwordService:</u>

public void Insert(BlogPosts.Buzzwords.DataContracts.Buzzword request)
{
Buzzword BuzzwordEntity =
TranslateBetweenBuzzwordAndBuzzword.TranslateBuzzwordToBuzzword(request);
BuzzwordManager Manager = new BuzzwordManager();
Manager.Insert(BuzzwordEntity);
}

Resultat:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image127.png"><img border="0" width="262" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb106.png" alt="image" height="77" style="border: 0px" /></a>

<strong>Schritt 12: Service veröffentlichen</strong>

Als Abschluss veröffentlicht man den Service in der Host Anwendung.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image128.png"><img border="0" width="406" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb107.png" alt="image" height="80" style="border: 0px" /></a> 

Dabei kann man noch verschiedene Optionen treffen - hier mal ein Basic Web Service.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image129.png"><img border="0" width="422" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb108.png" alt="image" height="128" style="border: 0px" /></a>

Ebenfalls die Metadaten mit anklicken und das Ergebnis ist ein XXX.svc Datei.

Resultat:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image130.png"><img border="0" width="228" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb109.png" alt="image" height="118" style="border: 0px" /></a>

<strong>Schritt 13: Testen des Services</strong>

Wenn man diese svc Datei nun im Browser anschaut, sieht man in der Mitte die WSDL des Webservice.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image131.png"><img border="0" width="386" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb110.png" alt="image" height="98" style="border: 0px" /></a>

Diese WSDL kann entweder über das Programm getestet werden, oder...

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image132.png"><img border="0" width="532" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb111.png" alt="image" height="28" style="border: 0px" /></a>

... wir binden dies ganz einfach in ein Projekt ein:

<strong><a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image133.png"><img border="0" width="306" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb112.png" alt="image" height="179" style="border: 0px" /></a> </strong>

Der Service implementiert momentan nur eine Load und Insert Methode - aufgrund der vorangeschrittenen Zeit werde ich dies als Beispiel zwar als Download anbieten, garantiere aber für nichts ;)

<u>Testcode:</u>

localhost.BuzzwordService Service =
new BlogPosts.Buzzwords.Client.localhost.BuzzwordService();
localhost.Buzzword request =
new BlogPosts.Buzzwords.Client.localhost.Buzzword();
request.Name = "Web 2.0";
Service.Insert(request);

Resultat:

<strong><a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image134.png"><img border="0" width="286" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb113.png" alt="image" height="70" style="border: 0px" /></a> </strong>

Jedenfalls der Testaufruf hat funktioniert - und das alles ohne viel Schreibarbeit.

<strong>Fazit:
</strong>Dieser Service ist natürlich äußerst einfach gestrickt und dieses HowTo sollte einen ersten Einblick gewähren, aber bereits während der Entwicklung dieses Services ging es sehr schnell voran. Sobald man erstmal sich überwunden hat, macht es weit weniger Aufwand als alles selber zu erstellen.
Wem die Wizards nicht gefallen, der kann sie entweder anpassen - oder auch alles manuell erstellen. In der Hilfe (direkt auf der Codeplex Seite ist das CHM File) ist dies neben der automatischen Generierung gut beschrieben.
Das heisst, man ist hier nicht auf irgendwelche "Hintergrund-Magie" angewiesen, sondern die Service Factory bietet eine sehr gute Unterstützung.

<strong>Download:</strong>

<a href="{{BASE_PATH}}/assets/files/democode/servicefactory/BlogPosts.Buzzwords.zip">[DemoCode - DB Connection muss natürlich angepasst werden]</a>

<strong>Links:</strong>

<u>Blog</u>
<a href="{{BASE_PATH}}/artikel/howto-microsoft-patterns-practices-software-factories-verstehen/">Software Factories verstehen</a>
<a href="{{BASE_PATH}}/artikel/howto-microsoft-pp-web-service-factory-service-factory-teil-1-grundlagen-asmx-variante/">Service Factory - Teil 1 (Grundlagen &amp; ASMX Variante)</a>
<a href="{{BASE_PATH}}/artikel/howto-microsoft-pp-web-service-factory-service-factory-teil-2-wcf-variante/">Service Factory - Teil  2 (WCF Variante)</a>
<a href="http://www.codeplex.com/servicefactory/Wiki/View.aspx?title=HandsOnLab&amp;referringTitle=Home">Service Factory HOLs @ Codeplex</a>

<u>Software
</u><a href="http://www.microsoft.com/germany/msdn/vstudio/products/express/default.mspx">Visual Studio 2005</a>
<a href="http://www.microsoft.com/downloads/details.aspx?FamilyId=E3D101DB-6EE1-4EC5-884E-97B27E49EAAE&amp;displaylang=en">GAT</a> / <a href="http://www.microsoft.com/downloads/details.aspx?FamilyId=C0A394C0-5EEB-47C4-9F7B-71E51866A7ED&amp;displaylang=en">GAX</a>
<a href="http://www.microsoft.com/downloads/details.aspx?familyid=db996113-6e92-4894-9b7e-0debb614d72f%20&amp;displaylang=en">Service Factory</a>
<a href="http://www.codeplex.com/servicefactory">Service Factory @ Codeplex</a>
<a href="http://www.microsoft.com/germany/msdn/vstudio/products/express/sql/default.mspx">SQL Server 2005</a>
<a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=c243a5ae-4bd1-4e3d-94b8-5a0f62bf7796&amp;DisplayLang=de">SQL Server 2005 Management Studio</a>
