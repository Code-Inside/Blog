---
layout: post
title: "HowTo: Create RSS Feeds with LINQ to XML (XLinq)"
date: 2008-06-20 05:48
author: codemin
comments: true
categories: [HowTo]
tags: [HowTo, LINQ, LINQ to XML, RSS, Xml]
language: en
---
{% include JB/setup %}
<p>It&#180;s really easy to create XML with LINQ to XML - you can find <a href="http://code-inside.de/blog/2008/02/28/howto-linq-to-xml-daten-schreiben/">a HowTo on my german blog</a>.     <br />Now we&#180;ll try to create an RSS Feed with XLINQ</p>  <p><strong>My Projectfiles:</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image27.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="171" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb27.png" width="227" border="0" /></a> </p>  <p>The &quot;Rss.ashx&quot; will create your RSS. At first I want to make sure, that my site-visitors detect my nice RSS Feed automatically:    <br /></p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c0c0a456-a1a6-4592-8a52-4ee9d7e0de23" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;head runat="server"&gt;
    &lt;title&gt;Untitled Page&lt;/title&gt;
    &lt;link rel="alternate" href="Rss.ashx" type="application/rss+xml" title="" id="rss" /&gt;
&lt;/head&gt;</pre></div>

<p></p>

<p>This RSS feature is called &quot;<a href="http://www.rssboard.org/rss-autodiscovery">RSS Autodiscovery</a>&quot;.</p>

<p><strong>The &quot;Rss.ashx&quot;:</strong></p>

<p>We create the head (name, declaration and so on) of the RSS XML in the ProcessRequest Method:</p>

<p></p>

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
        }</pre></div>

<p></p>

<p>At the end of the method the&#160; <a href="http://msdn.microsoft.com/en-us/library/system.xml.linq.xdocument.aspx">XDocument</a> is saved into the Response.Output. Your RSS items are created in the &quot;<strong>CreateElements</strong>&quot; Method.</p>

<p>The &quot;<strong>CreateElements</strong>&quot;-Method:</p>

<p>This method returns IEnumberable&lt;XElement&gt; and the elements will be appended the channel-Element (which is created in the ProcessRequest-Method):</p>

<p></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7dd90de0-4ead-49a7-8870-9405b21dbccb" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">private IEnumerable&lt;XElement&gt; CreateElements()
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
        }</pre></div>

<p></p>

<p>That&#180;s it :)</p>

<p><strong><a href="http://code-inside.de/files/democode/xlinqrss/xlinqrss.zip">[ Download Source Code ]</a></strong></p>
