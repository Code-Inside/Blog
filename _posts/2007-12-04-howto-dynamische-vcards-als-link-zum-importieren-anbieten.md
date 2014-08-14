---
layout: post
title: "HowTo: Dynamische vCards als Link zum Importieren anbieten"
date: 2007-12-04 21:02
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASHX, ASP.NET, HowTo, Outlook, vCard]
---
{% include JB/setup %}
<p>Eine <a href="http://de.wikipedia.org/wiki/Vcard" target="_blank">vCard</a> ist bestimmt jedem ein Begriff der schonmal Outlook oder ein vergleichbares Programm offen hatte und Kontakte importieren oder exportieren wollte.<br>Da vCards sehr beliebt sind um sein Outlook Adressbuch etc. zu füllen und die vCard an sich ein Standard ist, gibt es natürlich viele Implementationen.</p> <p>Wer mal bei bei seinem örtlichen Suchmonopolisten nach "vcard .net" oder ähnliches sucht, wir schnell fündig. Allerdings hat die Sache einen kleine Haken (jedenfalls meistens ;) ) - wir wollen die vCard nicht ins Dateisystem speichern sondern als Link anbieten. Solch eine Funktion ist z.B. bei einer Plattform wie XING nützlich um auf Knopfdruck sein Outlook zu befüllen.</p> <p><u>Ausgangssituation:</u></p> <p>Da ich das Rad nicht 100 Mal neu erfinden will und auch eine recht schlanke Lösung gesucht habe, bin ich auf diesen <a href="http://blogs.geekdojo.net/ryan/archive/2004/04/28/1797.aspx" target="_blank">Blog Artikel</a> aufmerksam geworden.<br>Auf Basis dieses Generators werden wir einfach eine kleines Webfrontend bauen.</p> <p><strong>Schritt 1: Webprojekt &amp; Default.aspx erstellen</strong></p> <p>In unserer Default.aspx will ich einfach einen Link angeben, welcher auf auf Knopfdruck dann die Meldung bringt, ob ich die vCard speichern oder mit Outlook öffnen möchte.</p> <p>Code:</p> <div class="CodeFormatContainer"><pre class="csharpcode">    ...
    &lt;form id=<span class="str">"form1"</span> runat=<span class="str">"server"</span>&gt;
    &lt;div&gt;
        &lt;a href=<span class="str">"XXX"</span>&gt;Roberts dynamische VCard generieren.&lt;/a&gt;
    &lt;/div&gt;
    &lt;/form&gt;
    ...</pre></div>
<p>Der Link könnte natürlich ebenso dynamisch erzeugt werden und im Hintergrund eine Datenbank abfragen.</p>
<p><strong>Schritt 2: ASHX erstellen</strong></p>
<p>Als nächstes erstellen wir uns eine ASHX die unsere VCard erstellt und letztendlich ausliefert:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">&lt;%@ WebHandler Language=<span class="str">"C#"</span> Class=<span class="str">"VCardService"</span> %&gt;

<span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Web;

<span class="kwrd">public</span> <span class="kwrd">class</span> VCardService : IHttpHandler {
    
    <span class="kwrd">public</span> <span class="kwrd">void</span> ProcessRequest (HttpContext context) {
        VCard myVCard = <span class="kwrd">new</span> VCard();
        myVCard.FirstName = <span class="str">"Robert"</span>;
        myVCard.LastName = <span class="str">"Mühsig"</span>;
        myVCard.Role = <span class="str">"Blogger"</span>;

        context.Response.ContentType = <span class="str">"text/x-vcard"</span>;
        context.Response.ContentEncoding = System.Text.Encoding.Default;
        context.Response.Write(myVCard.ToString());
    }
 
    <span class="kwrd">public</span> <span class="kwrd">bool</span> IsReusable {
        get {
            <span class="kwrd">return</span> <span class="kwrd">false</span>;
        }
    }

}</pre></div>
<p>Die Klasse VCard kommt aus dem Blogeintrag und ist recht intuitiv gestaltet. Schade ist, dass diese Version noch keine generischen Collections nutzt, sondern z.B. bei den Adressen einfach eine ArrayList annimmt - aber das kann man ja noch ändern.<br>In unserem Beispiel füge ich nur wenige Infos an die VCard an - man kann später ja noch ein anderen VCardGenerator nehmen (gibt ja viele ;) ).</p>
<p><u>Jetzt kommen wir zum wichtigsten:</u> Über ContentType = "text/x-vcard" kommt die Meldung, ob die VCard mit Outlook geöffnet werden soll:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image183.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="318" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb162.png" width="592" border="0"></a> </p>
<p>Damit es keine Probleme mit Umlauten kommt, muss bei ContentEncoding noch System.Text.Encoding.Default eingetragen werden (UTF8 ging bei mir nicht).<br>Jetzt setzen wir unseren Link in der Default.aspx noch auf die ASHX (ich hab sie VCarsService.ashx) genannt und fertig ist unser vCard import:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image184.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="254" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb163.png" width="412" border="0"></a> </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image185.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="200" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb164.png" width="402" border="0"></a> </p>
<p><strong>Fazit:</strong></p>
<p>Der Generator ist wahrscheinlich nicht der aller tollste, aber er verrichtet erstmal seinen Dienst. Über die ASHX ist es sehr leicht möglich auf die Response Einfluss zu nehmen und so z.B. solche Sachen zu realisieren.<br>Bei richtig generierten Daten, d.h. mit einer Datenbank im Hintergrund, macht dies natürlich wesentlich mehr Sinn.</p>
<p><strong>[ <a href="{{BASE_PATH}}/assets/files/democode/vcard/dynvcard.zip" target="_blank">Download Source Code</a> (VCard implementation siehe <a href="http://blogs.geekdojo.net/ryan/archive/2004/04/28/1797.aspx" target="_blank">Blogpost</a>) | <a href="http://code-developer.de/democode/vcard/" target="_blank">Demoanwendung</a> ]</strong></p>
