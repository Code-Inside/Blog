---
layout: post
title: "HowTo: YouTube mit C# durchsuchen - Einstieg in die YouTube API / Google Data API"
date: 2008-01-09 19:38
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET, .NET 2.0, ATOM, Google, HowTo, Xml, YouTube]
---
Vor einige Zeit habe ich bereits in einem meiner <a target="_blank" href="http://code-inside.de/blog/2007/12/24/wchentliche-rundablage-aspnet-mvc-aspnet-35-adonet-data-services-astoria-aspnet-ajax-silverlight/">Wöchentlichen Rundablagen</a> diesen interessanten Blogeintrag gefunden: <a href="http://www.dotneat.net/2007/12/20/QueryingYoutubeAPIUsingC.aspx">Querying Youtube API using C#</a>

Aufbauend auf diesen, habe ich mich selber mit der YouTube API beschäftigt und schreib mal etwas darüber.

<strong>Was kann die YouTube API?</strong>

Die YouTube API wurde durch die Übernahme durch Google geändert (siehe <a target="_blank" href="http://www.youtube.com/dev">YouTube Dev</a>) und ist jetzt Teil der <a target="_blank" href="http://code.google.com/apis/youtube/overview.html">GData API</a>. Die YouTube API basiert auf den <a target="_blank" href="http://de.wikipedia.org/wiki/ATOM">ATOM</a> XML Format und kann daher auch <strong>ohne Anmeldung</strong> oder sonstiges in einem normalen Browser betrachtet werden. Wir suchen einfach mal YouTube nach Videos von U2 über die API ab:

<a href="http://gdata.youtube.com/feeds/videos?q=u2">http://gdata.youtube.com/feeds/videos?q=u2</a>

<a href="{{BASE_PATH}}/assets/wp-images/image214.png"><img border="0" width="244" src="{{BASE_PATH}}/assets/wp-images/image-thumb193.png" alt="image" height="117" style="border: 0px" /></a>
(Ergebnis im IE7)

<strong>Bietet YouTube / Google sonst noch was?</strong>

Da ATOM auch nur XML ist, könnte man jetzt über XmlDocument die Ergebnisse auch selber parsen. Google stellt allerdings für .NET ein SDK bereit, womit man diesen ATOM Feed besser parsen kann: <a target="_blank" href="http://code.google.com/p/google-gdata/downloads/list">Googles GData .NET Library</a> (einfach das aktuellste nehmen).

Entpackt oder Installiert man das SDK befindet sich in diesem Ordner alle nötigen DLLs: cs\lib\Release

Für die YouTube API gibt es keine gesonderte DLL, sondern wir benötigen diese zwei:
<ul>
	<li>Google.GData.Client.dll</li>
	<li>Google.GData.Extensions.dll</li>
</ul>
<strong>Das tolle Test-Such-Konsolen-Programm</strong>

Als Demonstration nehm ich einfach ein Konsolenprogramm - auch wenn dies natürlich bei einer Videosuche etwas "unsinnig" ist - es ist am einfachsten ;)

Folgende Namespaces müssen eingebunden werden (und die 2 DLLs von Google und die System.Web DLL müssen mit referenziert werden):

<p class="CodeFormatContainer">
<pre class="csharpcode"><span class="kwrd">using</span> System.Web; 
<span class="kwrd">using</span> Google.GData.Client; 
<span class="kwrd">using</span> Google.GData.Extensions;</pre>
Wie bereits weiter oben gezeigt, benötigt man für das Suchen auf YouTube diese URL als Ausgangspunkt: <a href="http://gdata.youtube.com/feeds/videos?q=[SUCHWORT">http://gdata.youtube.com/feeds/videos?q=[SUCHWORT</a>]

Das entsprechende "[SUCHWORT]" muss natürlich entsprechend noch für den Einsatz in der URL maskiert werden. Hier hab ich eine schöne Übersicht über die URL-maskier Möglichkeiten im .NET Framework gefunden: <a target="_blank" href="http://schneegans.de/asp.net/url-escape/">URL-Maskierung</a>

Über die Klasse "<a target="_blank" href="http://msdn2.microsoft.com/de-de/library/system.web.httputility.urlencode.aspx">HttpUtility.UrlEncode</a>" bekommen wir den gewünschten maskierten Suchstring - dafür müssen wir auch "System.Web" mit referenzieren.

Das Test Program bietet einfach eine Eingabemöglichkeit und gibt die 20 ersten Suchtreffer wieder, hier der komplette Quellcode:

<p class="CodeFormatContainer">
<pre class="csharpcode">        <span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args) 
        { 
            Console.WriteLine(<span class="str">"Suchwort:"</span>); 
            <span class="kwrd">string</span> searchTerm = Console.ReadLine(); 

            <span class="kwrd">string</span> uriSearchTerm = HttpUtility.UrlEncode(searchTerm); 
            <span class="kwrd">string</span> url = <span class="str">"http://gdata.youtube.com/feeds/videos?q="</span> + uriSearchTerm; 

            Console.WriteLine(<span class="str">"Connection to YouTube - Searching: "</span> + searchTerm); 

            FeedQuery query = <span class="kwrd">new</span> FeedQuery(<span class="str">""</span>); 
            Service service = <span class="kwrd">new</span> Service(<span class="str">"youtube"</span>, <span class="str">"sample"</span>); 
            query.Uri = <span class="kwrd">new</span> Uri(url); 
            query.StartIndex = 0; 
            query.NumberToRetrieve = 20; 
            AtomFeed resultFeed = service.Query(query); 

            <span class="kwrd">foreach</span> (AtomEntry entry <span class="kwrd">in</span> resultFeed.Entries) 
            { 
                Console.WriteLine(<span class="str">"Title: "</span> + entry.Title.Text); 
                Console.WriteLine(<span class="str">"Link: "</span> + entry.AlternateUri.Content); 
                Console.WriteLine(<span class="str">"Tags:"</span>); 
                <span class="kwrd">foreach</span> (AtomCategory cat <span class="kwrd">in</span> entry.Categories) 
                { 
                    Console.Write(cat.Term + <span class="str">", "</span>); 
                } 
                Console.WriteLine(); 
            } 

            Console.ReadLine(); 
        }</pre>
<u>Kurz erklärt:</u>
<ul>
	<li>Der Suchstring wird über UrlEncode maskiert.</li>
	<li>"FeedQuery" ist eine spezielle Google.GData Klasse, mit welchem man ATOM Feeds leichter abrufen kann.</li>
	<li>Bei "Service service = new Service("youtube", "sample")" muss der "Servicename" und der "Applicationname" übergeben werden, obwohl dies wohl keinerlei Bedeutung hat.</li>
	<li>Bei "service.Query(query)" wird die Suchanfrage abgeschickt (max. Suchergebnisse sind wohl 20 Einträge pro Request) und als Ergebnis kommt ein "AtomFeed".</li>
	<li>Dieser "AtomFeed" wird pro Entity entsprechend ausgegeben.</li>
	<li>Die für YouTube interessante "watch" Adresse, versteckt sich in entry.AlternAteUri.Content - z.B. <a href="http://www.youtube.com/watch?v=w-TssRlmmBE">http://www.youtube.com/watch?v=w-TssRlmmBE</a> für einen U2 Song</li>
</ul>
Resultat für die Suchanfrage für "Die Ärzte":

<a href="{{BASE_PATH}}/assets/wp-images/image215.png"><img border="0" width="373" src="{{BASE_PATH}}/assets/wp-images/image-thumb194.png" alt="image" height="190" style="border: 0px" /></a>

Der SourcecodeÂ wurde nur wenig vomÂ <a target="_blank" href="http://www.dotneat.net/2007/12/20/QueryingYoutubeAPIUsingC.aspx">originalen</a>Â abgeändert.

<strong>Was macht man nun damit?</strong>

Das ganze bringt momentan in der Konsolenanwendung relativ wenig - in einer Windows.Forms Anwendung und mit dem "<a target="_blank" href="http://msdn2.microsoft.com/de-de/library/system.windows.forms.webbrowser.webbrowsersite(VS.80).aspx">WebBrowser</a>" in dem das Flashfile abgespielt werden kann, ist das schon brauchbarer (oder in einer ASP.NET Anwendung)

Leider gibt es wohl keine Möglichkeit (jedenfalls nicht mit dieser API - weiß einer einen anderen Weg?) das Flash von außen zu steuern. Das heisst, das man das embedded HTML (wie es bei YouTube üblich ist) immer mit einbauen muss - dafür kann man z.B. gut das "WebBrowser" Control nehmen.

<strong>Das Demoprojekt runterlade</strong>

Runterladen könnt ihr das Demoprojekt natürlich auch - ich hab es diesmal mit dem Visual Studio 2008 (die <a target="_blank" href="http://www.microsoft.com/express/">Express Edition</a> kann jeder sich kostenlos runterladen) erstellt - falls jemand nur Visual Studio 2005 zur Hand hat und den Code benutzen möchte, steht dem nichts im Wege - einfach die CS Datei öffnen. In dem Demoprojekt wird kein .NET 3.5 benötigt - ich wollte nur mal rumexperimentieren.

<a target="_blank" href="{{BASE_PATH}}/assets/files/democode/youtube/youtubetest.zip">[Download Democode]</a>

<strong>Links:</strong>
<ul>
	<li><a target="_blank" href="http://code-inside.de/blog/2007/12/24/wchentliche-rundablage-aspnet-mvc-aspnet-35-adonet-data-services-astoria-aspnet-ajax-silverlight/">Blogeintrag: Wöchentliche Rundablage</a></li>
	<li><a target="_blank" href="http://www.dotneat.net/2007/12/20/QueryingYoutubeAPIUsingC.aspx">Blogeintrag: Querying Youtube API using C#</a></li>
	<li>YouTube nach U2 absuchen: <a href="http://gdata.youtube.com/feeds/videos?q=u2">http://gdata.youtube.com/feeds/videos?q=u2</a></li>
	<li><a target="_blank" href="http://code.google.com/apis/youtube/overview.html">Google Code - YouTube API</a></li>
	<li><a target="_blank" href="http://code.google.com/p/google-gdata/downloads/list">Googles GData .NET Library</a></li>
	<li><a target="_blank" href="http://schneegans.de/asp.net/url-escape/">.NET URL Maskierungsübersicht</a></li>
	<li><a target="_blank" href="http://msdn2.microsoft.com/de-de/library/system.web.httputility.urlencode.aspx">MSDN HttpUtility.UrlEncode</a></li>
	<li><a target="_blank" href="http://msdn2.microsoft.com/de-de/library/system.windows.forms.webbrowser.webbrowsersite(VS.80).aspx">MSDN WebBrowser</a></li>
	<li><a target="_blank" href="http://www.microsoft.com/express/">Microsoft VS 2008 Express Editions</a></li>
	<li><a target="_blank" href="http://www.youtube.com/dev">YouTube Dev Seite</a></li>
	<li><a target="_blank" href="http://de.wikipedia.org/wiki/ATOM">Wikipedia ATOM Format</a></li>
</ul>
