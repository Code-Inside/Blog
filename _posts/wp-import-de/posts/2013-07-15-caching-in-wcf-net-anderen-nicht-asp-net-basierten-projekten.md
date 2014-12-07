---
layout: post
title: "Caching in WCF, .NET & anderen nicht ASP.NET-basierten Projekten"
date: 2013-07-15 21:33
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Cache]
language: de
---
{% include JB/setup %}
<p><a href="http://msdn.microsoft.com/en-us/library/xsbfdd8c(v=vs.100).aspx">Caching ist in ASP.NET</a> seit der ersten Version ein mitgeliefertes Feature. Es gibt viele Gründe für Caching, allerdings kommt es immer auf das jeweilige Problem an. Caching ist (oder sollte zumindest – sonst macht man etwas falsch ;)) “deutlich schneller” als herkömmliche Datenbankabfragen &amp; co. sein. Wie kommt man denn aber in den Genuss von Caching in WCF Services &amp; co. ohne grosse 3rd Party Services zu benutzen?</p> <h3>Caching in WCF &amp; co.: ObjectCache &amp; MemoryCache im Framework</h3> <p>Seit der Version 4 gibt es die abstrakte Klasse <a href="http://msdn.microsoft.com/en-us/library/system.runtime.caching.objectcache.aspx"><strong>ObjectCache</strong></a> mit der Implementierung eines InMemory-Caches namens “<a href="http://msdn.microsoft.com/en-us/library/system.runtime.caching.memorycache.aspx"><strong>MemoryCache</strong></a>”.</p> <p>Die API ist ziemlich simpel und orientiert sich auch an die API des ASP.NET Caches:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">private void btnGet_Click(object sender, EventArgs e)
{
    ObjectCache cache = MemoryCache.Default;
    string fileContents = cache["filecontents"] as string;

    if (fileContents == null)
    {
        CacheItemPolicy policy = new CacheItemPolicy();
        
        List&lt;string&gt; filePaths = new List&lt;string&gt;();
        filePaths.Add("c:\\cache\\example.txt");

        policy.ChangeMonitors.Add(new 
        HostFileChangeMonitor(filePaths));

        // Fetch the file contents.
        fileContents = 
            File.ReadAllText("c:\\cache\\example.txt");
        
        cache.Set("filecontents", fileContents, policy);
    }

    Label1.Text = fileContents;
}</pre>
<p>Der Caching-Mechanismus kann angepasst werden bzw. kann man eine eigene Implementierung des ObjectCaches vornehmen.</p>
<p><strong>Weitere Features (ob alles im InMemory Cache verfügbar ist muss man in der MSDN nachlesen) :</strong></p>
<ul>
<li><em>AbsoluteExpiration</em>: Set a date/time when to remove the item from the cache. 
<li><em>ChangeMonitors</em>: Allows the cache to become invalid when a file or database change occurs. 
<li><em>Priority</em>: Allows you to state that the item should never be removed. 
<li><em>SlidingExpiration</em>: Allows you to set a relative time to remove the item from cache. 
<li><em>UpdateCallback</em> &amp; <em>RemovedCallback</em>: Two events to get notification when an item is removed from cache. <u><em>UpdateCallback</em></u> is called before an item is removed and<em>RemovedCallBack</em> is called after an item is removed.</li></ul>
<p><a href="http://bartwullems.blogspot.ch/2011/02/caching-in-net-4.html">Quelle</a></p>
<p><strong>Gibt es weitere Implementierungen des ObjectCaches? </strong></p>
<p>Von Microsoft selbst scheint es nur den InMemory Cache zu geben.</p>
<p><strong>Wird Azure Caching oder ein anderer Distributed Cache unterstützt?</strong></p>
<p>Scheinbar nicht direkt – bzw. müsste man selbst an dieser Stelle etwas implementieren. Zum Thema Azure Caching gibt es diese <a href="http://www.windowsazure.com/en-us/develop/net/how-to-guides/cache/">Info-Seite</a>. </p>
<p><strong>Vorteil dieser Variante: Null Installationsaufwand – es ist im Framework.</strong></p>
<h3>Alternative: CacheAdapter – InMemory, Memcached, AppFabric &amp; ASP.NET Cache</h3>
<p>Wer etwas flexibler sein möchte, der kann direkt sich <strong><a href="https://bitbucket.org/glav/cacheadapter">dieses Projekt</a></strong> näher anschauen:</p>
<p><a href="https://bitbucket.org/glav/cacheadapter"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image1874.png" width="519" height="220"></a> </p>
<p>Im <a href="https://bitbucket.org/glav/cacheadapter/wiki/Home">Wiki gibt es nähere Informationen</a> zur Verwendung der Bibliothek. Die Bibliothek ist auch noch am “Leben” – jedenfalls gibt es Commits auf das Repository.</p>
<h3></h3>
<h3>Was nutzt ihr für Caching Lösungen? </h3>
<p>Das sind zwei Varianten die ich gefunden habe. Die erste hat den Vorteil das man garnichts installieren muss. Die zweite Variante bezieht eine Bibliothek mit ein, allerdings kann diese Lösung theoretisch auch einfach InMemory laufen. Bestimmt gibt es noch mehr. Mich würde interessieren: Was nutzt ihr? Gab es vielleicht schon große Reinfälle?</p>
