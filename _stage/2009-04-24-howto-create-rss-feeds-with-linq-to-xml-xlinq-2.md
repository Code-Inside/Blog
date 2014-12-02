---
layout: post
title: "HowTo: Create RSS Feeds with Linq to XML / XLinq"
date: 2009-04-24 01:32
author: codemin
comments: true
categories: [HowTo]
tags: [HowTo, LINQ, LINQ to XML, RSS]
---
{% include JB/setup %}
<a href="http://code-inside.de/blog-in/wp-content/uploads/image83.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="108" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb98.png" width="107" align="left" border="0" /></a>  <p>It&#180;s very easy to create an RSS using Linq to XML. In my sample I create a ASP.NET page, which offers a RSS Feed. We add also a meta tag so that users can find our RSS Feed.</p>  <p>&#160;</p>  <p>&#160;</p> 
<!--more-->
  <p><strong>Project structure:</strong></p>  <p><a href="http://code-inside.de/blog-in/wp-content/uploads/image84.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="175" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb99.png" width="231" border="0" /></a> </p>  <p>To let the user know that we offer a RSS Feed we create the following markup in the head of our ASP.NET page:</p>  <p></p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:50ae3ecc-c6dc-4b9c-80c9-38d5609d9613" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;head runat="server"&gt;
    &lt;title&gt;Untitled Page&lt;/title&gt;
    &lt;link rel="alternate" href="Rss.ashx" type="application/rss+xml" title="" id="rss" /&gt;
&lt;/head&gt;</pre></div>

<p></p>

<p><strong>&quot;RSS.ashx&quot;</strong>

  <br />To create a RSS we use directly the ProcessRequest method of the ASHX:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:64648015-9deb-447f-89c0-e70f11b13e11" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public void ProcessRequest(HttpContext context)
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

<p>Each time we create a new level of the XML tree we &quot;chain&quot; our XElements and return at the end the <a href="http://msdn.microsoft.com/en-us/library/system.xml.linq.xdocument.aspx">XDocument</a>. The RSS Items will be create in a seperate method called &quot;<strong>CreateElements</strong>&quot;:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:11c28e5c-b853-46b1-ab86-9a80c6b250d1" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">private IEnumerable&lt;XElement&gt; CreateElements()
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

<p>In this method we create the RSS Items and return this XElement list to the ASHX handler. </p>

<p>As you can see: Creating of an RSS Feed is really simple with Linq to&#160; Xml. :)</p>

<p><strong><a href="http://code-inside.de/files/democode/xlinqrss/xlinqrss.zip">[ Download Source Code ]</a></strong></p>
