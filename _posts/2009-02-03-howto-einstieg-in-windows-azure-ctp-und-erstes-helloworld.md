---
layout: post
title: "HowTo: Einstieg in Windows Azure CTP und erstes HelloWorld"
date: 2009-02-03 00:49
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, Azure, Cloud, Cloud Computing, HowTo, Web Role, Windows Azure]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image615.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="161" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb593.png" width="240" align="left" border="0" /></a>In <a href="http://code-inside.de/blog/2009/01/15/howto-einstieg-in-cloud-computing/">einem letzten Blogpost</a> habe ich &#252;ber Cloud Computing im Allgemeinen geschrieben. </p>  <p>Darin hab ich bereits etwas &#252;ber die Windows Azure Plattform gesprochen und m&#246;chte nun eine &quot;Hello World&quot; Anwendung auf Windows Azure erstellen.</p> 
<!--more-->
  <p><strong>Azure Service Platform      <br /></strong>Die <a href="http://www.microsoft.com/azure/services.mspx">Azure Service Platform</a> baut auf dem Kern &quot;<a href="http://www.microsoft.com/azure/windowsazure.mspx">Windows Azure</a>&quot; auf. </p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image616.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="225" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb594.png" width="486" border="0" /></a> </p>  <p>Das so genannte Windows f&#252;r die Wolke, &#252;bernimmt die <strong>Basisfunktionalit&#228;t</strong>. <strong>Web bzw. Worker Prozesse </strong>k&#246;nnen dort gehostet werden, sowie auch Files in einem <strong>Blob Storage</strong>.     <br />Das alles soll nat&#252;rlich hochverf&#252;gbar und genau auf den Bedarf abgestimmt. Dieses Management &#252;bernimmt Wndows Azure.     <br />Alle Daten etc. sind &#252;ber ein <a href="http://de.wikipedia.org/wiki/Representational_State_Transfer">REST</a> Interface zu erreichen.</p>  <p><strong>Die verschiedenen Services      <br /></strong>Auf der Basis von Windows Azure laufen ein paar Services, welche ich hier nur kurz anschneiden m&#246;chte:</p>  <ul>   <li><a href="http://dev.live.com/">Live Services</a> - mit dem Live Framework und Live Mesh </li>    <li><a href="http://www.microsoft.com/azure/netservices.mspx">.NET Services</a> - f&#252;r Workflows, Authentifizierung &amp; Services </li>    <li><a href="http://www.microsoft.com/azure/sql.mspx">SQL Services</a> - Eine Datenbank im Web </li>    <li>SharePoint und CRM </li> </ul>  <p><strong>Informationen &#252;ber Windows Azure      <br /></strong>Gute Informationen liefern diese <a href="http://www.microsoft.com/azure/videos.mspx">Videos</a>:</p>  <p><iframe marginwidth="0" marginheight="0" src="http://www.microsoft.com/azure/slMediaPlayer/videosSLMP.htm" frameborder="0" width="666" scrolling="no" height="297"></iframe></p>  <p>(Edit: Auch wenn der Player das Design auf der Seite etwas kaputt macht, lass ich ihn drin, da die Videos doch recht gut gemacht sind)</p>  <p><strong>Praktisches Anfang      <br /></strong>Nachdem die Theorie nun behandelt wurde, gehen wir ins Praktische &#252;ber. <strong>Momentan</strong> (Januar 2009) ist alles wor&#252;ber ich hier schreibe <strong>im CTP Status</strong>, daher kann sich dies jederzeit &#228;ndern. Am Ende soll eine HelloWorld Applikation rauskommen (wie kreativ!)</p>  <p><strong>Schritt 1: SDKs + Access Key      <br /></strong>Die SDKs findet man auf der Windows Azure Seite (<a href="http://www.azure.com">www.azure.com</a>) frei <a href="http://www.microsoft.com/azure/sdk.mspx">zum Download</a>. Ratsam sind erstmal folgende SDKs</p>  <ul>   <li>Windows Azure SDK (allgemeine Informationen) </li>    <li>Windows Azure Tools for Microsoft Visual Studio </li> </ul>  <p>Um es jedoch sp&#228;ter direkt auf Azure hochladen zu k&#246;nnen, ben&#246;tigt man eine Einladung. Ich wei&#223; leider nicht, wie momentan der Stand ist, allerdings hab ich meinen Key relativ schneller erhalten.    <br /><strong>Registrieren</strong> kann man sich daf&#252;r <a href="http://www.microsoft.com/azure/register.mspx">hier</a>.</p>  <p><strong>Schritt 2: Web Cloud Service Projekt anlegen      <br /></strong>Im Visual Studio gibt es nun eine neue Kategorie &quot;Cloud Services&quot;, in dem man Web bzw. Worker Cloud Services anlegen (oder beides in einem).</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image617.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="349" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb595.png" width="491" border="0" /></a></p>  <p>Nachdem man einen &quot;Web Cloud Service&quot; angelegt hat, sieht man im Visual Studio folgende Projektstruktur: </p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image618.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="204" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb596.png" width="244" border="0" /></a></p>  <ul>   <li>&quot;WindowsAzureHello&quot;:      <ul>       <li>Enth&#228;lt Konfigurationseinstellungen f&#252;r die &quot;Cloud&quot; </li>     </ul>   </li>    <li>&quot;WindowsAzureHello_WebRole&quot;:      <ul>       <li>Eine Standard ASP.NET Seite </li>     </ul>   </li> </ul> <strong>Schritt 3: Erster Blick auf die &quot;Debugging&quot; Umgebung / Development Fabric&quot;    <br /></strong>Wenn man nun F5 dr&#252;ckt, wird beim ersten Start der Development Storage hinzugef&#252;gt. Dieser erstellt eine Datenbank auf dem SQL Server (Download <a href="http://www.microsoft.com/germany/Express/">SQL Express</a>). Es wird die &quot;Cloud-Umgebung&quot; auf dem lokalen Client abgebildet, sodass man sp&#228;ter auf Azure keine gro&#223;en &#220;berraschungen begegnet.   <br />  <p><a href="{{BASE_PATH}}/assets/wp-images/image619.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="125" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb597.png" width="392" border="0" /></a>&#160;</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image620.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="324" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb598.png" width="424" border="0" /></a> </p>  <p>Erstellte Tabellen auf dem lokalen Client, um die Cloud-Umgebung zu simulieren:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image621.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="219" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb599.png" width="244" border="0" /></a></p>  <p>In der Windows Tray findet man dieses kleine Zeichen: <a href="{{BASE_PATH}}/assets/wp-images/image622.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="24" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb600.png" width="30" border="0" /></a></p>  <p>Hier sieht man nun die &quot;<strong>Development Fabric</strong>&quot;: </p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image636.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="384" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb614.png" width="511" border="0" /></a> </p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image637.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="383" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb615.png" width="509" border="0" /></a></p>  <p>&#160;<strong>Schritt 4: Eine kleine &#196;nderung an der ASP.NET Seite - &quot;HelloWorld&quot;      <br /></strong>Damit man &#252;berhaupt irgendwas sieht, f&#252;ge ich diese Zeilen in der ASP.NET Seite ein:     <br /></p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:048c021e-292e-46b2-9676-b7a5cb6f4e13" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;form id="form1" runat="server"&gt;
    &lt;div&gt;
        Hello World @ Code Inside Blog &lt;br /&gt;
        http://code-inside.de
    &lt;/div&gt;
    &lt;/form&gt;</pre></div>

<p></p>

<p><strong>Schritt 5: Cloud Service publishen 
    <br /></strong>Wenn man ein Rechtsklick auf das &quot;WindowsAzureHello&quot; Projekt macht, bekommt man nicht nur die allgemeinen Buttons, sondern auch zwei weitere:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image625.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="76" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb603.png" width="244" border="0" /></a> </p>

<p>Vorher muss man allerdings das &quot;WindowsAzureHello&quot;-Projekt publishen, danach &#246;ffnet sich automatisch der Windows Explorer und der bevorzugte Browser. 
  <br />Im Windows Explorer findet man zwei Files:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image626.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="53" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb604.png" width="197" border="0" /></a> </p>

<p><strong>Schritt 6: Hosted Service auf Windows Azure erstellen</strong> 

  <br />Im Browser sieht man nun die Azure Service Page, in der man einen &quot;Hosted Service&quot; anlegt:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image627.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="183" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb605.png" width="483" border="0" /></a> </p>

<p>Direkt im Anschluss legt man einen Namen fest und registriert sich eine (Sub)Domain:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image628.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="215" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb606.png" width="445" border="0" /></a> </p>

<p>Nachdem dies erfolgt ist, sieht man folgenden Screen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image629.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="332" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb607.png" width="421" border="0" /></a></p>

<p>&quot;Production&quot; ist die Live Anwendung, welche unter der gew&#252;nschten Domain verf&#252;gbar ist - sp&#228;ter soll es auch m&#246;glich sein, richtige Domains zu registrieren. 
  <br />&quot;Staging&quot; ist die Testumgebung. Hier m&#252;ssen wir erst unsere Anwendung deployen. </p>

<p><strong>Schritt 7: Anwendung auf Staging deployen 
    <br /></strong>Auf der Oberfl&#228;che w&#228;hlt man die beiden Datein aus, die man im Schritt 5 erstellt hat, nach dem Upload Prozess, wird das Package deployed:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image630.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="170" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb608.png" width="244" border="0" /></a> </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image631.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="200" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb609.png" width="244" border="0" /></a> </p>

<p>Nach einer ganzen Weile (inklusive &quot;init-Phase&quot;, sollte es so aussehen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image632.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="227" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb610.png" width="406" border="0" /></a> </p>

<p>In der Staging-Umgebung sieht man nun unsere kreative Ausgabe:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image633.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="66" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb611.png" width="227" border="0" /></a> </p>

<p><strong>Schritt 8: Anwendung in &quot;Production&quot; setzen</strong> 

  <br />Jetzt kommt der Moment, in dem wir die Anwendung von Staging in den Produktionszustand setzen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image634.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="86" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb612.png" width="93" border="0" /></a> </p>

<p>... und kurz nachdem ich dies bet&#228;tigt habe, war die Anwendung live:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image635.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="227" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb613.png" width="244" border="0" /></a> </p>

<p>Unter der <a href="http://codeinside.cloudapp.net/Default.aspx">URL</a> ist diese nun auch zu erreichen.</p>

<p><strong>Das Ganze im Schnelldurchlauf:</strong> 

  <br />Das liesst sich vielleicht recht kompliziert, ist aber <a href="http://www.microsoft.com/azure/webdev.mspx">eigentlich in 3 Minuten</a> fertig:</p>

<p><iframe marginwidth="0" marginheight="0" src="http://www.microsoft.com/azure/slMediaPlayer/webDeveloperSLMP0.htm" frameborder="0" width="666" scrolling="no" height="297"></iframe></p>

<p><strong>Fazit:
    <br /></strong>Es wird mit den Visual Studio Tools sehr einfach Cloud-Anwendungen zu erstellen. Man braucht kein komplett neues Wissen erlernen, sondern kann bestehendes Know-How weiter nutzen.

  <br />Nat&#252;rlich ist der Dienst noch in der CTP Phase, aber die Ideen und die bisherige Umsetzung gef&#228;llt mir. Der erste Eindruck ist gut.</p>

<p><strong>Worauf man achten muss:</strong>

  <br />Bei dieser Art von Cloudanwendungen muss man nat&#252;rlich das Sessionhandling anders machen, daf&#252;r gibt es bereits vom Azure Team passende Provider, da es nicht sichergestellt ist, dass der Request immer zum selben Server f&#252;hrt.&#160; <br />Der Teufel steckt sicherlich wie immer nat&#252;rlich im Detail - aber das war ja auch erst der erste Blick darauf ;)</p>
