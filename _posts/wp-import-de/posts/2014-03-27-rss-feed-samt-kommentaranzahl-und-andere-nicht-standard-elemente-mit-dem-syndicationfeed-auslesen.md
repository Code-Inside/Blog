---
layout: post
title: "RSS Feed samt Kommentaranzahl und andere nicht Standard Elemente mit dem SyndicationFeed auslesen"
date: 2014-03-27 21:13
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [RSS, SyndicationFeed]
language: de
---
{% include JB/setup %}
<p>Jetzt mal ein Blogpost ohne ein fancy NuGet Package: Seit .NET 3.5 gibt es die <a href="http://msdn.microsoft.com/en-us/library/system.servicemodel.syndication.syndicationfeed.aspx">SyndicationFeed</a> Klasse. Eine schon etwas ältere API, reicht aber aus um Atom bzw. RSS Feeds zu lesen. In diversen RSS Feeds gibt es aber Erweiterungen, welche man natürlich auch auslesen möchte. </p> <p>So gibt Wordpress z.B. auch die Anzahl der geposteten Kommentare weiter (mehr dazu z.B. auf <a href="https://developer.mozilla.org/en-US/docs/RSS/Article/Why_RSS_Slash_is_Popular_-_Counting_Your_Comments">mozilla.org</a>) :</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image2009.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1145.png" width="570" height="150"></a> </p> <p>Diese sind allerdings nicht direkt im <a href="http://msdn.microsoft.com/en-us/library/system.servicemodel.syndication.syndicationitem(v=vs.110).aspx">SyndicationItem</a> abgebildet, können jedoch relativ einfach mit abgefragt werden. Alle nicht “erkannten” Elemente verbleiben im Property <a href="http://msdn.microsoft.com/en-us/library/system.servicemodel.syndication.syndicationitem.elementextensions.aspx">ElementExtensions</a>, welches über Bordmitteln auch wieder auszulesen ist:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    class Program
    {
        static void Main(string[] args)
        {
            var reader = XmlReader.Create("http://blog.codeinside.eu/feed");
            var feed = SyndicationFeed.Load(reader);

            foreach (var feedItem in feed.Items)
            {
                int commentCount = 0;

                Console.WriteLine(feedItem.Title.Text);

                foreach (SyndicationElementExtension extension in feedItem.ElementExtensions)
                {
                    XElement extensionElement = extension.GetObject&lt;XElement&gt;();

                    if (extensionElement.Name.LocalName == "comments" &amp;&amp; extensionElement.Name.NamespaceName == "http://purl.org/rss/1.0/modules/slash/")
                    {
                        Console.WriteLine("Comments: " + extensionElement.Value);
                    }
                }
            }

            Console.ReadLine();
        }
    }</pre>
<p>Für die Syndication-Klassen wird die Assembly “System.ServiceModel” benötigt.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image2010.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1146.png" width="570" height="299"></a> </p>
<p>Gebraucht hatte ich diese Funktionalität für den “Hub”:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image2011.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1147.png" width="570" height="382"></a> </p>
<p>Damit sollte es klappen. Der Code ist natürlich auch auf <a href="https://github.com/Code-Inside/Samples/tree/master/2014/SyndicateItemAndCommentsCount/SyndicateItemAndCommentsCount">GitHub</a> zu finden.</p>
