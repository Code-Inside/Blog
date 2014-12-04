---
layout: post
title: "HowTo: Use PicLens and other MediaRSS Clients for your own Website (create MediaRSS with LINQ to XML)"
date: 2008-07-01 13:22
author: codemin
comments: true
categories: [HowTo]
tags: [HowTo, LINQ, LINQ to XML, MediaRss, RSS, XLINQ, Xml]
language: en
---
{% include JB/setup %}
<p>This blogpost is related to the &quot;<a href="http://code-inside.de/blog-in/2008/06/20/howto-create-rss-feeds-with-linq-to-xml-xlinq/">RSS XLINQ</a>&quot; post - but this time the result will be cooler ;).</p>  <p><strong>About this post      <br /></strong>This post is about the &quot;<a href="http://en.wikipedia.org/wiki/Media_RSS">MediaRSS</a>&quot; standard and how you can use it for your own website. If you have never heard of it - never mind. But maybe you have heard of a really cool Firefox Plugin called &quot;<a href="http://www.piclens.com/">PicLens</a>&quot;.</p>  <p><a href="http://code-inside.de/blog-in/wp-content/uploads/image28.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="87" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb28.png" width="244" border="0" /></a>&#160;</p>  <p><strong>&quot;PicLens&quot;?      <br /></strong>&quot;PicLens&quot; is a incredible surface for some internet services, like YouTube, Google picture search, Flickr or Amazon:</p>  <p><a href="http://code-inside.de/blog-in/wp-content/uploads/image29.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="131" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb29.png" width="244" border="0" /></a>     <br />This is the Amazon-Surface:</p>  <p><a href="http://code-inside.de/blog-in/wp-content/uploads/image30.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="184" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb30.png" width="244" border="0" /></a></p>  <p><strong>Media RSS      <br /></strong>The Piclens guys have implemented the &quot;MediaRSS&quot; standard - that means: Each site with an MediaRSS can be viewed in Piclens.&#160; <br /><a href="http://piclens.com/lite/webmasterguide.php">If you are a webmaster, you should take a look at this site.</a> We created in the last post an RSS feed with XLinq - MediaRSS shouldn&#180;t be much harder to code:</p>  <p><strong>XLINQ</strong></p>  <p>We have the same project files - only the RSS generation must be changed:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8bd12e9a-8777-497b-8b4f-6468ea26fc9b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        XNamespace media = "http://search.yahoo.com/mrss";
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
                                                new XAttribute("url", "http://code-inside.de/blog/wp-content/uploads/image-thumb" + i + ".png")),
                                            new XElement(media + "content",
                                                new XAttribute("url", "http://code-inside.de/blog/wp-content/uploads/image-thumb" + i + ".png"))
                                       );
                list.Add(itemElement);
            }

            return list;
        }</pre></div>

<p>This time we need 2 <a href="http://msdn.microsoft.com/en-us/library/system.xml.linq.xnamespace.aspx">XNamespaces</a> - &quot;media&quot; and &quot;atom&quot; are need to create a valid MediaRSS:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3a887256-5386-4b19-9bf9-01932c870343" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8" standalone="yes"?&gt;
&lt;rss version="2.0" xmlns:media="http://search.yahoo.com/mrss" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
...
&lt;/rss&gt;</pre></div>

<p>These namespaces must be added by using the <a href="http://msdn.microsoft.com/en-us/library/system.xml.linq.xattribute.aspx">XAttribute</a> class. The syntax is in my point of view a bit to complex, but I didn&#180;t&#160; find a better way.&#160; <br />

  <br />The source code above is everything you need to create a &quot;simple&quot; MediaRSS - there are some other elements supported by piclens - look at the <a href="http://piclens.com/lite/webmasterguide.php">Guide</a> for more information.</p>

<p><strong>Result: 
    <br /></strong>We created the RSS auto-detection in the last blogpost. Piclens can now find the MediaRSS elements and show us the pictures on the &quot;Wall&quot; (the Piclens-Button glow if it find a MediaRSS Feed on the site) :</p>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image31.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="60" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb31.png" width="70" border="0" /></a></p>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image32.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="340" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb32.png" width="452" border="0" /></a>&#160; <br />If you have several pictures on your site - publish a MediaRSS Feed. It&#180;s very easy and it&#180;s an open standard (<a href="http://search.yahoo.com/mrss">Specification @ Yahoo</a>) - Piclens is just one MediaRSS Client (but today the client with the best surface).</p>

<p><strong><a href="http://code-inside.de/files/democode/mediarss/mediarss.zip">[ Download Source Code ]</a></strong></p>

<p>PS: I use my german blog as the picture source - please don&#180;t abuse this example (traffic :( ) ;)</p>
