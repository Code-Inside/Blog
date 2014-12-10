---
layout: post
title: "Use RavenDB as embedded Filebase"
date: 2011-11-05 10:09
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: [NoSQL, RavenDB]
language: en
---
{% include JB/setup %}
<p>In my <a href="http://code-inside.de/blog-in/">first post</a> about this subject I’ve showed you how to start quickly with RavenDB and several ways of deployment.</p> <p>One option was to run RavenDB in the application – the advantage is that you don’t need a separate server even <a href="http://ravendb.net/faq/embedded-with-http">the Web-Admin-UI is able to activate</a> because of that the usage in the WebApp is not useful. I’ve heard about better opportunities (more about that later).</p> <p>RavenDB as Embedded Version is also available as NuGet Package:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-en/image1336.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image1336" border="0" alt="image1336" src="{{BASE_PATH}}/assets/wp-images-en/image1336_thumb.png" width="514" height="180"></a></p> <p>The code is almost the same like in the first post but in fact we only the Embedded Namespace including the DocumentStore:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c1fd9200-7021-4db3-bd0b-baa720407396" class="wlWriterSmartContent"><pre class="c#">   private static IDocumentStore CreateDocumentStore()
        {
            var documentStore = new EmbeddableDocumentStore
            {
                ConnectionStringName = "RavenDB"
            }.Initialize();

            return documentStore;
        }</pre></div>
<p>In the web.config you will find this:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ef978e23-521f-4a07-a060-7e521decb2b2" class="wlWriterSmartContent"><pre class="c#"> &lt;connectionStrings&gt;
    &lt;add name="RavenDB" connectionString="DataDir = ~\App_Data" /&gt;
  &lt;/connectionStrings&gt;</pre></div>
<p>Beware: If you use the usual DocumentStore you will receive this error message:</p>
<p>‘RavenDB could not be parsed, unknown option: datadir’ – so take care to check if it’s the right type from the Embedded Area.</p>
<p>The different types of the <a href="http://ravendb.net/documentation/client-api/connection-string">ConnectionStrings</a> are described here. The result is that all Files are abandoned at App_Data without an additional service needs to run.</p>
<p><a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2FEmbeddedRavenDB">[Democode @ Google Code]</a></p>
