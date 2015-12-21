---
layout: post
title: "HowTo: RSS Feeds mit LINQ to XML erstellen (XLinq)"
date: 2008-06-19 22:49
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [HowTo, LINQ, LINQ to XML, RSS, Xml]
language: de
---
{% include JB/setup %}
<p>Ein XML zu erstellen ist mit Linq to XML recht einfach - ähnliches habe ich bereits in diesem <a href="{{BASE_PATH}}/2008/02/28/howto-linq-to-xml-daten-schreiben/">HowTo</a> beschrieben.</p> <p>Der Unterschied ist eigentlich nur in der Verwendung und in dem dynamischen anlegen der Items zu finden.</p> <p><strong>Hier erstmal der Projektaufbau:</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image465.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="171" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb444.png" width="227" border="0"></a> </p> <p>Damit unsere Besucher auch auf den RSS Feed aufmerksam werden, hab ich noch im HEAD einen Link auf den RSS-Feed gemacht:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e1cb8bf2-ee8d-4116-8774-ee6da4bbdd45" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;head runat="server"&gt;
    &lt;title&gt;Untitled Page&lt;/title&gt;
    &lt;link rel="alternate" href="Rss.ashx" type="application/rss+xml" title="" id="rss" /&gt;
&lt;/head&gt;</pre></div>
<p><strong>Die "Rss.ashx":</strong></p>
<p>Das Grundgerüst erzeugen wir direkt in der ProcessRequest Methode:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d1392f9b-f8ff-47ee-840a-e012854da8ce" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public void ProcessRequest(HttpContext context)
        {

            XDocument document = new XDocument(
                                    new XDeclaration("1.0", "utf-8", "yes"),
                                    new XElement("rss",
                                        new XAttribute("version", "2.0"),
                                        new XElement("channel", this.CreateElements())
                                       ));

            context.Response.ContentType = "text/xml";
            document.Save(context.Response.Output);
            context.Response.End();
        }</pre></div></p>
<p>Hier wird die Deklaration gemacht und das <a href="http://msdn.microsoft.com/en-us/library/system.xml.linq.xdocument.aspx">XDocument</a> wird in den Response.Output geschrieben. Unsere Items erzeugen wir an einer anderen Stelle - und zwar in der "<strong>CreateElements</strong>" Methode.</p>
<p>Die "<strong>CreateElements</strong>"-Methode:</p>
<p>Diese Methode gibt IEnumberable&lt;XElement&gt; zurück und kann somit direkt in den Baum eingefügt werden:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:eeba6da7-0edb-480f-b32f-38b94a0fa822" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">private IEnumerable&lt;XElement&gt; CreateElements()
        {
            List&lt;XElement&gt; list = new List&lt;XElement&gt;();

            for (int i = 1; i &lt; 100; i++)
            {
                XElement itemElement = new XElement("item",
                                            new XElement("title", i),
                                            new XElement("link", "http://code-inside.de")
                                       );
                list.Add(itemElement);
            }

            return list;
        }</pre></div></p>
<p>Sehr einfach und schnell gemacht :)</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/xlinqrss/xlinqrss.zip">[ Download Source Code ]</a></strong></p>
