---
layout: post
title: "RavenDB Studio für Embedded RavenDB nutzen"
date: 2011-11-08 23:37
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Embedded, NoSQL, RavenDB]
---
<p>Bereits im ersten <a href="http://code-inside.de/blog/2011/07/05/nosql-mit-ravendb-und-asp-net-mvc/">Blogpost um RavenDB</a> hatte ich auch das Management-Tool RavenDB Studio erwähnt. Wenn man RavenDB richtig als Server-Anwendung (z.B. <a href="http://ravendb.net/documentation/docs-deployment-iis">innerhalb des IIS</a>) ausführt, steht dort das Studio mit zur Verfügung. Wer allerdings <a href="http://code-inside.de/blog/2011/08/15/ravendb-als-embedded-datenbank-nutzen/">RavenDB innerhalb der Applikation</a> laufen lässt, muss zwei kleine Handgriffe machen um auch da die Management Oberfläche zu benutzen.</p> <p><strong>EmbeddedHttpServer mit starten</strong></p> <p>Das Studio muss innerhalb eines “Web-Servers” laufen – d.h. z.B. im IIS. Allerdings kann RavenDB auch einen “EmbeddedHttpServer” benutzen:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:14a1e35c-4cc1-43f9-8792-66c759ed95eb" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        private static IDocumentStore CreateDocumentStore()
        {
            var documentStore = new EmbeddableDocumentStore
            {
                ConnectionStringName = "RavenDB",
                UseEmbeddedHttpServer = true
            }.Initialize();

            return documentStore;
        }</pre></div>
<p>&nbsp;</p>
<p>Wichtig hier: UseEmbeddedHttpServer = true.Damit startet RavenDB auf Port 8080 einen Webserver.</p>
<p><strong>Fehlermeldung “Missing file”</strong></p>
<p>Wenn man nun auf Port 8080 über den Browser zugreift, kann einem diese Fehlermeldung begegnen:
<p><em>Could not find file Raven.Server.xap, which contains the RavenDB Studio functionality. Please copy the Raven.Server.xap file to the base directory of RavenDB and try again.</em>
<p>Hier muss man die XAP vom RavenDB Studio besorgen – dies kann man z.B. <a href="http://builds.hibernatingrhinos.com/builds/ravendb">hier</a> runterladen. Die “Raven.Studio.XAP” befindet sich u.A. in dem Server Verzeichnis. <u>Dieses File muss in das Root-Directory der Anwendung (Parallel z.B. zu eurer Global.ascx) kopiert werden.</u>
<p>Jetzt sollte das Studio aufgehen und man kann loslegen.</p>
