---
layout: post
title: "HowTo: RSS Feeds mit C# / XLINQ lesen"
date: 2009-04-21 01:16
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, LINQ, RSS, XLINQ]
---
<p><a href="{{BASE_PATH}}/assets/wp-images/image714.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="111" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb692.png" width="111" align="left" border="0" /></a>Vor einige Zeit hatte ich schon etwas zu <a href="http://code-inside.de/blog/2008/02/26/howto-linq-to-xml-daten-lesen/">XLinq (oder Linq to Xml) geschrieben</a>. RSS Feeds einlesen ist eigentlich keine gro&#223;e Sache, weil der Standard recht simpel ist. Allerdings gibt es da auch Abweichungen ;)    <br />Da ich bereits geschrieben habe wie man ein <a href="http://code-inside.de/blog/2008/06/19/howto-rss-feeds-mit-linq-to-xml-erstellen-xlinq/">RSS Feed erstellt</a>, zeige ich nun an einem einfachen Beispielen wie man <a href="http://de.wikipedia.org/wiki/RSS">RSS Feeds</a> einlesen kann.</p> 
<!--more-->
  <p><strong>DemoApp</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image715.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="141" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb693.png" width="191" align="left" border="0" /></a> Meine DemoApp ist in diesem Fall eine Consolen Anwendung. &quot;RssItem&quot; beschreibt mein Model, was ich aus dem Rss Feed rausziehen m&#246;chte. Der &quot;RssService&quot; bekommt eine Url &#252;bergeben und ich stelle diese RssItems des Feeds einfach dar.</p>  <p>&#160;</p>  <p><strong>Ein Blick auf RSS:</strong></p>  <p>Um die Funktionsweise meines RssService zu erkl&#228;ren ein kurzer Ausschnitt auf das XML eines RSS Feeds (in diesem Fall dem <a href="http://twitter.com/statuses/user_timeline/14109602.rss">Twitter RSS Feed von mir</a>) :</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image716.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="277" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb694.png" width="475" border="0" /></a> </p>  <p><strong>App:</strong></p>  <p>Hier meine Model Klasse - <strong>RssItem</strong>:</p>  <p>   <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cfb01500-2001-4517-b36e-f2d8041385c5" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">namespace ReadRss
{
    public class RssItem
    {
        public string Title { get; set; }
        public string Message { get; set; }
        public string Url { get; set; }
        public DateTime PublishedOn { get; set; }
    }
}
</pre></div>
</p>

<p>Und die <strong>RssService</strong> Klasse:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:28350059-39a2-4b2e-85ca-91ee68e531f3" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class RssService
    {
        public List&lt;RssItem&gt; GetItems(string feedUrl)
        {
            XDocument doc = XDocument.Load(feedUrl);
            return (from x in doc.Descendants("channel").Descendants("item")
                         select new RssItem()
                         {
                             Title = x.Descendants("title").Single().Value,
                             Message = x.Descendants("description").Single().Value,
                             Url = x.Descendants("link").Single().Value,
                             PublishedOn = DateTime.Parse(x.Descendants("pubDate").Single().Value)
                         }).ToList();

        }
    }</pre></div>

<p>Im XDocument lade ich den Feed und gehe dann &#252;ber die Descendants &#252;ber die Daten an die ich will und gebe mir pro &quot;item&quot; ein &quot;RssItem&quot; zur&#252;ck. Ich hangel mich quasi durch die Knoten durch.
  <br />Das ganze klappt auch mit dem RSS <a href="http://code-inside.de/blog/index.php">vom Blog</a>. </p>

<p>Am Ende gebe ich dies in der Program.cs aus:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:686beab8-df1a-4f63-8611-628f36403a8c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            RssService service = new RssService();
            List&lt;RssItem&gt; resultTwitter = service.GetItems("http://twitter.com/statuses/user_timeline/14109602.rss");
            
            Console.WriteLine("[Twitter]");
            foreach (RssItem item in resultTwitter)
            {
                Console.WriteLine("---");
                Console.WriteLine(item.Title);
                Console.WriteLine(item.Message);
                Console.WriteLine(item.PublishedOn.ToShortDateString());
                Console.WriteLine(item.Url);
                Console.WriteLine("---");
            }</pre></div>

<p><strong>Ergebnis:</strong> </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image717.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="188" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb695.png" width="378" border="0" /></a> </p>

<p><strong>Fazit:</strong>

  <br />Wer mal schnell auf einen RSS Feed zugreifen m&#246;chte, kommt im Regelfall auch sehr gut ohne andere Library aus.</p>

<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/readrss/readrss.zip">[ Download Democode ]</a></strong></p>
