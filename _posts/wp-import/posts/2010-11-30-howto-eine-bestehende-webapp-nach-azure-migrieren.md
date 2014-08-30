---
layout: post
title: "HowTo: Eine bestehende WebApp nach Azure migrieren"
date: 2010-11-30 01:00
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Azure, HowTo]
---
{% include JB/setup %}
<p><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" border="0" align="left" src="{{BASE_PATH}}/assets/wp-images/image1109.png" width="142" height="125" />Die Windows Azure Plattform gibt es schon eine ganze Weile, allerdings bin ich bislang noch nicht wirklich dazu gekommen eine bestehende Webanwendung nach Azure zu migrieren. Ich versuche dies mal Schritt für Schritt zu dokumentieren. Die ersten Schritte sind jedenfalls recht einfach: WebApp Package bauen und auf SQLAzure gehen (die einfachste Möglichkeit).</p> <!--more-->  <p></p>  <p><strong>"Abgrenzung” - mein Szenario</strong></p>  <p>Die Web Anwendung die bei diesem Blogpost als Grundlage diente, war eine ASP.NET MVC 2 Applikation, welche einen SQL Server als Datenbank benutzte. Irgendwelche Windows Dienste, Services Bus-Geschichten oder anderer Konstrukte waren nicht teil davon. Ich wollte einfach, dass im simpelsten Fall meine WebApp mit einer Instanz auf Azure läuft. Das ist noch nicht der große Wurf, aber ein erster Schritt ;)</p>  <p><strong>Was braucht man?</strong></p>  <p>Man braucht das aktuelle Windows Azure SDK (ich hab die <a href="http://www.microsoft.com/downloads/en/details.aspx?FamilyID=21910585-8693-4185-826e-e658535940aa">June 2010 Version genommen</a> - ist das die aktuelle? ;) ) Dann benötigt man noch ein SQL Management Studio Express und falls man ein großen SQL Server auf seinem Rechner installiert hat, der sollte sich noch das <a href="{{BASE_PATH}}/2010/11/23/fix-windows-azure-tools-failed-to-initialize-the-development-storage-service/">hier durchlesen</a>.</p>  <p><strong>DemoSolution</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1112.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb294.png" width="227" height="225" /></a> </p>  <p>Wir haben eine Standard MVC App, welche auch keine Referenzen zu irgendwelchen Azure Assemblies hat. Dazu haben wir noch im SQL Server irgendwo unsere Datenbank. Zum SQL Server komm ich aber noch später.</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p><strong>Cloud Projekt hinzufügen</strong></p>  <p>Nach der Installation des Windows Azure SDKs findet man einen neuen Projekttyp:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1113.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb295.png" width="432" height="382" /></a> </p>  <p></p>  <p>Im nachfolgenden Fenster <strong>könnte</strong> man gleich ein Projekt neu erzeugen, allerdings gehen wir von unserem Szenario aus: Wir haben schon eine WebApp.</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1114.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb296.png" width="450" height="283" /></a> </p>  <p>Also einfach auf <strong>"OK” klicken.</strong></p>  <p><strong>Nun das bestehende Projekt hinzufügen</strong></p>  <p>Über das Kontextmenü können wir z.B. eine bestehende Web Anwendung als Web Role hinzufügen</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1115.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb297.png" width="447" height="168" /></a> </p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1116.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb298.png" width="447" height="357" /></a> </p>  <p><strong>Debugging</strong></p>  <p>Man kann nun ganz normal das MVC Projekt starten, aber auch das Cloud Projekt. Beim Cloud Projekt gehen wird die Anwendung auf der lokalen Cloud-Dev-Plattform gehostet:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1117.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb299.png" width="475" height="259" /></a> </p>  <p><strong>Config Anpassen - DiagnosticsConnectionString</strong></p>  <p>Für die Logausschriften in der lokalen Umgebung wird ein Config Eintrag in den Cloud configs gemacht. Dieser muss unbedingt <a href="http://www.davidaiken.com/2010/05/28/remember-to-update-your-diagnosticsconnectionstring-before-deploying/">vor dem Deployment entfernt werden</a>.</p>  <p><u>Meine ServiceConfiguration.cscfg</u></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ac48adcd-81ff-4601-ab77-9dcda14bd0fd" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0"?&gt;
&lt;ServiceConfiguration serviceName="MoveToAzure.WebHost" xmlns="http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceConfiguration"&gt;
  &lt;Role name="MoveToAzure.WebApp"&gt;
    &lt;Instances count="1" /&gt;
    &lt;ConfigurationSettings /&gt;
  &lt;/Role&gt;
&lt;/ServiceConfiguration&gt;</pre></div>

<p><u>Meine ServiceDefinition.csdef</u></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:eaaaab28-a509-430a-8a38-01442232148f" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;ServiceDefinition name="MoveToAzure.WebHost" xmlns="http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceDefinition"&gt;
  &lt;WebRole name="MoveToAzure.WebApp"&gt;
    &lt;InputEndpoints&gt;
      &lt;InputEndpoint name="HttpIn" protocol="http" port="80" /&gt;
    &lt;/InputEndpoints&gt;
    &lt;ConfigurationSettings /&gt;
  &lt;/WebRole&gt;
&lt;/ServiceDefinition&gt;</pre></div>

<p>Beide "ConfigurationSettings” sind gelerrt. Ansonsten würde unser Projekt nicht in der Cloud starten.</p>

<p><strong>MVC Anpassungen</strong></p>

<p>Die Cloud kennt momentan noch nicht die MVC2 DLL, daher müssen wir dort noch "Copy Local” einstellen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1118.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb300.png" width="293" height="227" /></a> </p>

<p>Ansonsten lässt sich auch in diesem Fall die WebApp nicht starten!</p>

<p><strong>Cloud - publish...</strong></p>

<p>Wer eine SQL Datenbank einsetzt und auf SQL Azure umschwenken will, sollte den Teil weiter unten zuerst lesen, da man nach dem Deployment nicht mehr auf die web.config zugreifen kann. Hierbei müsste man noch die WebApp etwas anpassen, damit man solche Sachen auch komfortabler erreichen kann. Aber wir machen mal mit dem ganz simplen Fall "ohne DB” weiter:</p>

<p>Über das Kontextmenü des Cloud-Projekts können wir uns ein Package bauen lassen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1119.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb301.png" width="390" height="356" /></a> </p>

<p><strong><u>Wichtig zu erwähnen:</u> </strong>Die Configuration für den Buildvorgang sollte möglichst auf Release sein.</p>

<p><strong>Ab in die richtige Cloud</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1120.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb302.png" width="244" height="73" /></a></p>

<p>Über <a href="http://windows.azure.com">http://windows.azure.com</a> legt man sich ein neuen Service an. </p>

<p>&#160;</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1121.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb303.png" width="313" height="162" /></a> </p>

<p>Dann wählt man sich einen "Hosted Service”. Der andere ist nur "Speicherplatz” für Tabellen, Queues und Blobs. Erst einmal nicht interessant für uns.</p>

<p>&#160;</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1122.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb304.png" width="244" height="133" /></a> </p>

<p>In diesem Screen gibt man dem Service einen Namen und evtl. eine Beschreibung.</p>

<p>&#160;</p>

<p>&#160;</p>

<p>Hier muss man nun etwas aufpassen. Wenn man im kleinen Maßstab anfängt, sollte man darauf achten, dass z.B. die SQLAzure Instanz in derselben Region wie die WebApp ist. Ansonsten vergibt man hier noch eine Domain für den Dienst.</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1123.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb305.png" width="460" height="291" /></a> </p>

<p>Danach kommt man auf eine Seite, wo man den momentan Status der Produktionsumgebung bzw. Stagingumgebung sieht:</p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1124.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb306.png" width="456" height="198" /></a> </p>

<p>Ein klick auf "Deploy” bringt uns da hin. Dort die vorher gebauten Package Dateien auswählen und hochladen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1125.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb307.png" width="407" height="305" /></a> </p>

<p></p>

<p><strong>Nach</strong> dem erfolgreichen hochladen muss noch "<strong>Run</strong>” gedrückt werden. Dann kann es noch ein paar Minuten dauern, bis die WebApp in den Rechenzentren von Microsoft hochgefahren ist.</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1126.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb308.png" width="225" height="302" /></a> </p>

<p><strong>Nach dem Klick auf "Run”:</strong></p>

<p>Jetzt starten die Instanzen. Dieser Vorgang kann aber gut 5 bis 10 Minuten in Anspruch nehmen. Als erstes ist die Init Phase, danach folgt eine kurze Busy Phase und erst dann wird das Icon auf Grün mit "Ready”. Nun funktioniert es. Falls man die Änderungen von oben (DiagnosticsConnectionString &amp; MVC DLL) nicht angepasst hat, wird die WebApp nicht starten und ewig auf "Busy” bleiben und dann irgendwann stoppen. Es gibt da keine schönen Fehlermeldungen :(</p>

<p><strong></strong></p>

<p><strong>Daher hab ich auch das HowTo geschrieben ;)</strong></p>

<p><strong>SQL Azure</strong></p>

<p>Wer eine MS SQL Datenbank benutzt, kann auf dem Azure Service Portal sich auch eine SQLAzure Datenbank anlegen. Dort wird auch ein ConnectionString angezeigt, dieser kann dann z.B. ganz normal im SQL Management Studio verwendet werden um sich zur Datenbank zu connecten. Als Schutz muss man auch seine IP mit angeben, dies ist aber soweit alles selbsterklärend.</p>

<p>Wahrscheinlich gibt es viele Wege, wie man die Daten von A nach B bekommt. Ich habe mir aber ein SQL Script generieren lassen, hilfreich waren da auch diese beiden Parameter:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1127.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb309.png" width="370" height="332" /></a> </p>

<p>Zu dem Dialog kommt man, wenn man auf eine SQL DB geht und dort "Rechtsklick” "Tasks” "Generate Scripts...” aufruft.</p>

<p>Danach das SQL per Copy &amp; Paste über das Management Studio nach SQL Azure und fertig :)</p>

<p>Dann noch den ConnectionString in der WebApp anpassen und nun kann man mal schauen, ob es noch funktioniert ;) </p>

<p><strong>Fazit</strong></p>

<p>Die WebApp samt DB sollte erst einmal auf Azure nun stabil laufen. Allerdings gibt es noch diverse Probleme zu lösen, darunter z.B. wie man die Session oder den Cache unter Azure nutzen könnte um so eine richtig skalierbare Anwendung zu bauen. Für den Anfang passt das aber erst mal ;)</p>

<p>[<strong><a href="{{BASE_PATH}}/assets/files/democode/movetoazure/movetoazure.zip">Download Democode</a>]</strong></p>
