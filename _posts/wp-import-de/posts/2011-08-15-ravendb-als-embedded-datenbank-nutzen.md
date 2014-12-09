---
layout: post
title: "RavenDB als Embedded Datenbank nutzen"
date: 2011-08-15 23:58
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Embedded, HowTo, NoSQL, RavenDB]
language: de
---
{% include JB/setup %}
<p>In meinem <a href="{{BASE_PATH}}/2011/07/05/nosql-mit-ravendb-und-asp-net-mvc/">Einstiegspost</a> habe ich gezeigt, wie man relativ schnell mit <a href="http://ravendb.net/">RavenDB</a> loslegen kann und auch die verschiedenen Deployment Arten aufgezeigt. </p> <p>Eine davon war, RavenDB “in der Applikation” mit Laufen zu lassen – das hat den Vorteil, dass man keinen zusätzlichen Server braucht, selbst die <a href="http://ravendb.net/faq/embedded-with-http">Web-Admin-UI kann man aktivieren</a>, daher ist der Einsatz in einer WebApp etwas “ungünstig”, da soll es bessere Möglichkeiten geben (später mehr dazu).</p> <p>RavenDB als Embedded Version gib es auch als NuGet Package:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1336.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb518.png" width="558" height="196"></a></p> <p>Der Code ist fast derselbe wie bei dem ersten Post, jedoch nutzen wir nun den Embedded Namespace samt dessen DocumentStore:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a076d608-7d5a-425c-aeb5-3d9acec858ee" class="wlWriterEditableSmartContent"><pre name="code" class="py">        private static IDocumentStore CreateDocumentStore()
        {
            var documentStore = new EmbeddableDocumentStore
            {
                ConnectionStringName = "RavenDB"
            }.Initialize();

            return documentStore;
        }</pre></div>
<p>&nbsp;</p>
<p>In der web.config ist folgendes hinterlegt:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a4689b72-a3df-4dca-a120-5e78635635df" class="wlWriterEditableSmartContent"><pre name="code" class="c#">  &lt;connectionStrings&gt;
    &lt;add name="RavenDB" connectionString="DataDir = ~\App_Data" /&gt;
  &lt;/connectionStrings&gt;</pre></div>
<p>&nbsp;</p>
<p><strong>Achtung: </strong>Falls ihr den normalen DocumentStore nehmt, dann kommt folgende Fehlermeldung:</p>
<p>“RavenDB could not be parsed, unknown option: datadir” – daher darauf achten, ob es der Typ aus dem Embedded Bereich ist.</p>
<p>Die verschiedenen Arten der <a href="http://ravendb.net/documentation/client-api/connection-string">ConnectionStrings</a> sind hier näher beschrieben. Das Ergebnis ist nun, dass alle File unter App_Data abgelegt werden, ohne dass ein zusätzlicher Dienst laufen muss.</p>
<p><a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2FEmbeddedRavenDB"><strong>[ Democode @ Google Code ]</strong></a></p>
