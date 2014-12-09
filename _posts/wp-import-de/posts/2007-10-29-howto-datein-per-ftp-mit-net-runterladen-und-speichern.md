---
layout: post
title: "HowTo: Datein per FTP mit .NET runterladen und speichern"
date: 2007-10-29 22:21
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET, FTP, HowTo]
language: de
---
{% include JB/setup %}
Ich mag FTP eigentlich nicht, allerdings kann man es manchmal nicht ändern und muss trotzdem irgendwelche Datein von einem FTP Server über .NET runterladen.

Es ist eigentlich nicht sonderlich schwer eine Datei runterzuladen - hier der Beispielcode (in der Zusammenstellung ungetestet - sollte aber so funktionieren) :

<p class="CodeFormatContainer">
<pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">static</span> <span class="kwrd">void</span> DownloadFile() 
    { 
        Uri serverUri = <span class="kwrd">new</span> Uri(<span class="str">"ftp://example.de/foo.jpg"</span>); 
        FtpWebRequest request = (FtpWebRequest)WebRequest.Create(serverUri); 
        request.Method = WebRequestMethods.Ftp.DownloadFile; 
        request.UseBinary = <span class="kwrd">true</span>; 
        request.Credentials = <span class="kwrd">new</span> NetworkCredential(<span class="str">"USER"</span>, <span class="str">"PASSWORD"</span>); 

        <span class="kwrd">try</span> 
        { 
            FtpWebResponse response = (FtpWebResponse)request.GetResponse(); 
            Image image = Image.FromStream(response.GetResponseStream()); 
            <span class="kwrd">string</span> path = Path.Combine(<span class="str">"C:\\MyImages\\", "</span>Foo.jpg"); 
            FileStream stream = <span class="kwrd">new</span> FileStream(path, FileMode.Create); 

            image.Save(stream,  System.Drawing.Imaging.ImageFormat.Jpeg); 
        } 
        <span class="kwrd">catch</span> (WebException e) 
        { 
            <span class="kwrd">string</span> ex = e.Message; 
        } 

    }</pre>
<strong><u>Erklärung:</u></strong>

Das .NET Framework kommt mit einer Klasse "<a href="http://msdn2.microsoft.com/de-de/library/system.net.ftpwebrequest(VS.80).aspx">FtpWebRequest</a>" daher, welches uns die eigentliche Arbeit abnimmt.
Als erstes nehmen wir unsere "<a href="http://msdn2.microsoft.com/de-de/library/system.uri.uri(vs.80).aspx">URI</a>" und erstellen einen "<a href="http://msdn2.microsoft.com/de-de/library/system.net.webrequest(VS.80).aspx">WebRequest</a>" welchen wir dann zum FtpWebRequest casten.

Jetzt kommt die Besonderheit des FTPs - jeder Befehl den man per FTP machen kann, gibt es in den "<a href="http://msdn2.microsoft.com/de-de/library/system.net.webrequestmethods.ftp.aspx">WebRequestMethodes.Ftp</a>":

<img border="0" width="231" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb114.png" height="214" />

Dannach den Username &amp; Passwort angeben und schon können wir versuchen, die Verbindung aufzubauen.

Der Rest ist eigentlich selbsterklärend: Wir holen uns den Response, dann den Stream, bauen daraus unser Bild und speichern dieses lokal auf unsere Platte.

<strong><u>Anmerkungen:</u></strong>

Wie in dem Screenshot zu sehen ist, gibt es auch ein ListDirectory - allerdings kann dies zu ungewöhnlichen Ergebnissen führen, wenn ein Proxy dazwischen ist. Denn dann kommt als Antwort des "<a href="http://msdn2.microsoft.com/de-de/library/system.net.ftpwebresponse.aspx">FtpResponse</a>" eine HTML Seite.

Ein Workaround ist nur, dass man direkt die Files vielleicht in ein XML File angibt und diese nacheinander runterlädt - allerdings ist dies dann nicht automatisch.

<strong><u>Links:</u></strong>

<strong>MSDN</strong>
<ul>
	<li><a href="http://msdn2.microsoft.com/de-de/library/system.net.ftpwebrequest(VS.80).aspx">FtpWebRequest</a></li>
	<li><a href="http://msdn2.microsoft.com/de-de/library/system.uri.uri(vs.80).aspx">URI</a></li>
	<li><a href="http://msdn2.microsoft.com/de-de/library/system.net.webrequest(VS.80).aspx">WebRequest</a></li>
	<li><a href="http://msdn2.microsoft.com/de-de/library/system.net.webrequestmethods.ftp.aspx">WebRequestMethodes.FTP</a></li>
	<li><a href="http://msdn2.microsoft.com/de-de/library/system.net.ftpwebresponse.aspx">FtpWebResponse</a></li>
</ul>
