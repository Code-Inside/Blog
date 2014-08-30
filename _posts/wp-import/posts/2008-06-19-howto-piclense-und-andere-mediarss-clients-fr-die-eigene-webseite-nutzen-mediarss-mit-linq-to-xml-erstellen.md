---
layout: post
title: "HowTo: PicLens und andere MediaRSS Clients für die eigene Webseite nutzen (MediaRSS mit LINQ to XML erstellen)"
date: 2008-06-19 22:52
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, LINQ, LINQ to XML, MediaRss, RSS, XLINQ, Xml]
---
{% include JB/setup %}
<p>Dieses HowTo ist im Zusammenhang mit dem normalen "<a href="{{BASE_PATH}}/2008/06/19/howto-rss-feeds-mit-linq-to-xml-erstellen-xlinq/">RSS XLINQ</a>" Post entstanden - ist allerdings wesentlich cooler.</p> <p><strong>Worum geht es?<br></strong>Es geht um den "<a href="http://en.wikipedia.org/wiki/Media_RSS">MediaRSS</a>" Standard und wie man diesen für sich nutzen kann. Noch nie davon gehört? Ich bis heute auch nicht.<br>Allerdings gibt es ein bekanntes Firefox Plugin welches mit darauf basiert - die Rede ist von "<a href="http://www.piclens.com/">PicLens</a>".</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image466.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="87" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb445.png" width="244" border="0"></a>&nbsp;</p> <p><strong>Was kann "PicLens"?<br></strong>"PicLens" bietet eine sehr schicke Oberfläche für verschiedene bekannte Dienste wie YouTube, Google Bildersuche, Flickr oder auch Amazon:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image467.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="131" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb446.png" width="244" border="0"></a> <br>Hier mal die Amazon-Ansicht:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image468.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="184" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb447.png" width="244" border="0"></a> </p> <p><strong>Media RSS<br></strong>PicLens kann auch mit dem oben genannten "MediaRSS" Standard umgehen - auf der <a href="http://piclens.com/lite/webmasterguide.php">Seite ist auch gut beschrieben wie man das macht</a>. Da wir bereits ein RSS Feed mit XLinq erstellt haben, dürfte das ja nicht sonderlich schwerer sein.</p> <p><strong>XLINQ</strong></p> <p>Wir haben den selben Projektaufbau - nur in der ASHX müssen wir die Erstellung etwas anpassen:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8bd12e9a-8777-497b-8b4f-6468ea26fc9b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        XNamespace media = "http://search.yahoo.com/mrss";
        XNamespace atom = "http://www.w3.org/2005/Atom";
        public void ProcessRequest(HttpContext context)
        {
           

            XDocument document = new XDocument(
                                    new XDeclaration("1.0", "utf-8", "yes"),
                                    new XElement("rss",
                                        new XAttribute("version", "2.0"),
                                        new XAttribute(XNamespace.Xmlns + "media", media),
                                        new XAttribute(XNamespace.Xmlns + "atom", atom),
                                        new XElement("channel", this.CreateElements())
                                       ));

            context.Response.ContentType = "text/xml";
            document.Save(context.Response.Output);
            context.Response.End();
        }

        private IEnumerable&lt;XElement&gt; CreateElements()
        {
            List&lt;XElement&gt; list = new List&lt;XElement&gt;();

            for(int i = 1; i &lt; 100; i++)
            {
                XElement itemElement = new XElement("item",
                                            new XElement("title", i),
                                            new XElement("link", "Code-Inside.de"),
                                            new XElement(media + "thumbnail", 
                                                new XAttribute("url", "{{BASE_PATH}}/assets/wp-images/image-thumb" + i + ".png")),
                                            new XElement(media + "content",
                                                new XAttribute("url", "{{BASE_PATH}}/assets/wp-images/image-thumb" + i + ".png"))
                                       );
                list.Add(itemElement);
            }

            return list;
        }</pre></div>
<p>In dem ASHX Handler haben wir nun noch zwei zusätzliche <a href="http://msdn.microsoft.com/en-us/library/system.xml.linq.xnamespace.aspx">XNamespaces</a> deklariert. Diese sind (laut der Piclens Seite) notwendig um erstmal dieses XML zu erzeugen:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3a887256-5386-4b19-9bf9-01932c870343" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8" standalone="yes"?&gt;
&lt;rss version="2.0" xmlns:media="http://search.yahoo.com/mrss" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
...
&lt;/rss&gt;</pre></div>
<p>Diese Namespaces werden über ein <a href="http://msdn.microsoft.com/en-us/library/system.xml.linq.xattribute.aspx">XAttribute</a> hinzugefügt. Der Syntax ist meiner Meinung nach etwas ungünstig - ein "new XNamespace" oder etwas ähnliches hatte nicht funktioniert. Auch ein "new <a href="http://msdn.microsoft.com/en-us/library/system.xml.linq.xelement.aspx">XElement</a>('xmlns:media','...')" wurde mit einer Exception belohnt - daher dieser Weg.<br><br>In der <strong>CreateElement</strong> Methode müssen wir nur noch die "media:thumbnail" + "media:content" erstellen und fertig sind wir. Zusätzlich könnte man noch die anderen Elemente des Standards einbauen - schaut einfach nochmal in den <a href="http://piclens.com/lite/webmasterguide.php">Guide</a>.</p>
<p><strong>Ergebnis:<br></strong>Da wir in unserem Head immer noch den Link zum RSS Feed angegeben haben, prüft PicLens automatisch ob man die Bilder auf der "Wall" anzeigen kann:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image469.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="60" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb448.png" width="70" border="0"></a> </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image470.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="340" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb449.png" width="452" border="0"></a>&nbsp;<br>Wer also viele Bilder auf seiner Webseite hat, könnte dies doch leicht umsetzen - insbesondere da dies ein offener Standard (<a href="http://search.yahoo.com/mrss">Specification @ Yahoo</a>) ist und ich davon ausgehe, dass sowas noch häufiger eingesetzt wird. Ob nun PicLens als Client ist ja am Ende auch egal :)</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mediarss/mediarss.zip">[ Download Source Code ]</a></strong></p>
<p>PS: Als Bildquelle hab ich mal den Blog genommen - bitte aus Trafficgründen nicht überstrapazieren ;)</p>
