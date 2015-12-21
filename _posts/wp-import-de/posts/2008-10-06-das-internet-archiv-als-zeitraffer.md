---
layout: post
title: "Das Internet-Archiv als Zeitraffer"
date: 2008-10-06 23:02
author: Robert Muehsig
comments: true
categories: [Allgemein]
tags: []
language: de
---
{% include JB/setup %}
<p>Von dem <a href="{{BASE_PATH}}/2008/10/06/10-jahre-google-startseite-im-schnelldurchlauf/">Google Zeitraffer Video</a> war ich doch etwas angetan und habe mir gedacht, dass man sicherlich ein Teil davon automatisieren kann. Rausgekommen ist mein kleines "WebHistoryTimeline" Projekt, welches als Datenquelle das "<a href="http://web.archive.org/web/*/http://www.google.com">Internet Archive"</a> nutzt.</p> <p>Dabei hole ich mir über RegEx alle Links heraus und rufe diese Links über die <a href="{{BASE_PATH}}/2008/09/10/howto-dynamisch-webseiten-screenshots-erzeugen/">WebBrowser Klasse auf und speichere die gerenderte Seite im Dateisystem</a>.</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image546.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="184" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb524.png" width="473" border="0"></a> </p> <p><strong>Die Projektstruktur:</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image547.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="129" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb525.png" width="222" border="0"></a> </p> <p>Model beschreibt einfach unsere "Objektstruktur". Der Service macht hier nur ein kleine Überprüfung ob die eingegeben URLs mit "http://" beginnen - quasi etwas Validierung. Im Data passiert das eigentlich interessante:</p> <p>(ich bin kein RegEx Profi, sondern eher ein blutiger Anfänger und wollte schnell zu Ergebnissen kommen) :</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cd30608f-240b-4c5b-ad0c-6ef6061dca23" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public Website GetWebsite(string url)
        {
            string archiveUrl = "http://web.archive.org/web/*/" + url;
            HttpWebRequest rq = (HttpWebRequest)WebRequest.Create(archiveUrl);
            HttpWebResponse response = (HttpWebResponse)rq.GetResponse();
            StreamReader reader = new StreamReader(response.GetResponseStream());
            string html = reader.ReadToEnd();

            Website resultWebsite = new Website();
            resultWebsite.Url = url;

            MatchCollection matchs = Regex.Matches(html, @"&lt;a.href=.http://web.archive.org/web/\d.*?&lt;/a&gt;");
            foreach (Match match in matchs)
            {
                ArchiveWebsite archive = new ArchiveWebsite();
                archive.ArchiveUrl = Regex.Match(match.Value, @"http://web.archive.org/web/\d*").Value + "/" + url;
                archive.Date = DateTime.Parse(Regex.Match(match.Value, @"\w\w\w\s\d\d,\s\d\d\d\d").Value);
                resultWebsite.ArchiveWebsites.Add(archive);
            }

            return resultWebsite;
        }</pre></div>
<p>Die "WinApp" und die "ConsoleApp" sind zwei Demoanwendungen, wobei die Konsolenapplikation die Bilder auf die Festplatte speichert:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image548.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="206" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb526.png" width="404" border="0"></a> </p>
<p>Das ganze ist nicht besonders toll und Multithreading fehlt auch ;) - allerdings hat man hinterher folgendes Ergebnis (bei der Microsoft Seite)</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image549.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="225" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb527.png" width="580" border="0"></a> </p>
<p>Insgesamt sind es bei der Microsoftseite über 1300.</p>
<p>Da das vielleicht ein nettes Spielzeug für den einen oder anderen ist, werde ich den Sourcecode auf Codeplex veröffentlichen. Leider kann ich das gerade dort nicht einchecken, sodass ich erstmal nur die "Download-Variante" anbiete:</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/webhistory/webhistory.zip">[ Download Source Code ]</a></strong></p>
<p>Viel Spaß :)</p>
