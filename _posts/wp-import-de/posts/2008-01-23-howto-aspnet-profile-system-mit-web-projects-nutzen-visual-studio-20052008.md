---
layout: post
title: "HowTo: ASP.NET Profile System mit Web Projects nutzen (Visual Studio 2005/2008)"
date: 2008-01-23 19:47
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, HowTo, Membership, Visual Studio 2005, Visual Studio 2008]
language: de
---
{% include JB/setup %}
<p>ASP.NET 2.0 führte ein so genanntes "<a href="http://msdn2.microsoft.com/en-us/library/ms998347.aspx" target="_blank">Membership</a>" System ein - darunter sind allgemeine Benutzerregistrier-, Benutzerprofil- und Benutzerrollensystem gebündelt.</p> <p>Insbesondere das Profilsystem hat mich heute etwas beschäftigt (auch wenn es etwas älter ist). Mit dem Profilsystem kann man einfach Benutzern bestimmte Attribute zuordnen, z.B. Name, Alter, Wohnort oder andere Verweise zu bestimmten Daten innerhalb der Applikation.</p> <p>Das kann man natürlich auch selber in seiner DB zusammenbasteln - aber das ASP.NET Profile System bietet eine strenge Typsierung, sodass man in der Web.config folgendes anlegen kann:</p> <div class="CodeFormatContainer"><pre class="csharpcode">&lt;profile&gt;
  &lt;properties&gt;
    &lt;add name=<span class="str">"PostalCode"</span> /&gt;
  &lt;/properties&gt;
&lt;/profile&gt;</pre></div>
<p>Und im Code hinter so aufrufen kann "Profile.PostalCode" - man kann auch direkt typen angeben, sodass man direkt festlegen kann, welcher Typ eine Profileigenschaft hat:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">&lt;?xml version=<span class="str">"1.0"</span>?&gt;
&lt;configuration xmlns=<span class="str">"http://schemas.microsoft.com/.NetConfiguration/v2.0"</span>&gt;
  &lt;system.web&gt;
    &lt;profile&gt;
      &lt;properties&gt;
        &lt;add name=<span class="str">"BirthDate"</span> type=<span class="str">"DateTime"</span>/&gt;
        &lt;add name=<span class="str">"FavoriteNumber"</span> type=<span class="str">"int"</span>/&gt;
        &lt;add name=<span class="str">"Comment"</span> type=<span class="str">"string"</span>/&gt;
        &lt;add name=<span class="str">"FavoriteColor"</span> type=<span class="str">"string"</span> defaultValue=<span class="str">"Blue"</span>/&gt;
        &lt;add name=<span class="str">"FavoriteAlbums"</span> 
             type=<span class="str">"System.Collections.Specialized.StringCollection"</span> 
             serializeAs=<span class="str">"Xml"</span>/&gt;
      &lt;/properties&gt;
    &lt;/profile&gt;
  &lt;/system.web&gt;
&lt;/configuration&gt;</pre></div>
<p>Das ganze wird zudem mit der Membership Datenbank synchronisiert - dort gibt es direkt eine "Profile" Tabelle in dem diese Werte reingeschrieben werden:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image249.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="100" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb228.png" width="277" border="0"></a> </p>
<p>Das ganze kann man nun noch beliebig erweitern oder <a href="http://www.theserverside.net/tt/articles/showarticle.tss?id=CreatingProfileProvider" target="_blank">eigene Profil-Provider schreiben</a> - hier ein <a href="http://www.odetocode.com/Articles/440.aspx" target="_blank">anderer guter Artikel</a>.</p>
<p>Doch wie ruft man denn nun eigentlich die Profileigenschaften ab? Das was auf den MSDN Seiten immer "Profile.[PROPERTY]" verwendet wird, ist schlecht dokumentiert.</p>
<p>Jedenfalls erstellt VS im Hintergrund automatisch eine "ProfileCommon" Klasse die überall erreichbar ist (* hier kommt noch eine Anmerkung!)</p>
<p>So kommt man an die Profile Eigenschaften (System.Web.Profile Namespace):</p>
<p><code>ProfileCommon profile = HttpContext.Current.Profile<br>as ProfileCommon;</code>
<p>Danach kann man über "profile." seine Properties aufrufen.</p>
<p><strong>* - die Anmerkung</strong></p>
<p>Das ganze funktioniert aber nur mit dem "Web Site" Modell (<a href="http://weblogs.asp.net/scottgu/archive/2005/10/18/427754.aspx" target="_blank">hier z.B. ein Beispiel von Scott</a>) - in Web Applications wird die ProfileCommon nicht automatisch erstellt.<br>Scott Guthrie schrieb auf einer <a href="http://webproject.scottgu.com/CSharp/Migration2/Migration2.aspx" target="_blank">sehr alten Seite</a> (ganz unten) seine Lösung: <a href="http://www.codeplex.com/WebProfile" target="_blank">WebProfile Generator</a> (Alternative: Die Klasse manuell erstellen) </p>
<p><u>Problem hier:</u> Das ganze läuft unter Visual Studio 2008 bisher nicht (daher manuell erstellen :( ) - wird aber hoffentlich bald kommen. Auf der Codeplex Seite habe ich bereits einen Kommentar gefunden, kann daher wohl nicht mehr lange dauern.</p>
<p><strong>Anmerkung gernell</strong></p>
<p>Es gibt sicherlich&nbsp; noch die ein oder andere Möglichkeit auf die Profildaten zuzugreifen, aber extra wegen dieser streng-typisierten und leichten Variante habe ich das einer Eigenentwicklung vorgezogen - schauen wir mal, wann ich dies bereuen werde ;) </p>
<p>&nbsp;</p>
<p><font face="Courier New"></font></p>
