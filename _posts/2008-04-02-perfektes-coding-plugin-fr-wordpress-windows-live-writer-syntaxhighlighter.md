---
layout: post
title: "Perfektes Coding Plugin für Wordpress & Windows Live Writer: SyntaxHighlighter"
date: 2008-04-02 20:39
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: []
---
{% include JB/setup %}
<p>Wer Code bloggen will, muss sich meist schnell nach einem tollen Wordpress Plugin suchen, damit das Ergebnis ansehnlich bleibt. Dort wird man zwar h&#228;ufig f&#252;ndig, leider brauch ich auch das Gegenst&#252;ck im Windows Live Writer. </p>  <p>Bislang hatte ich ein sehr seltsames Plugin, das sich leider bei meinem neuen Notebook nicht mehr installieren lie&#223;, daher waren viele Codeteile nur per Screenshot zu sehen.</p>  <p><strong>Jetzt hab ich dieses tolle &quot;Plugin&quot; entdeckt: <a href="http://code.google.com/p/syntaxhighlighter/">SyntaxHighlighter</a></strong></p>  <p><strong>Das passende Windows Live Writer Plugin gibts auf Codeplex:</strong> <a href="http://www.codeplex.com/wlwSyntaxHighlighter">SyntaxHighlighter for Windows Live Writer</a></p>  <p>Die Installation auf dem Server war etwas nervig, weil er seltsamerweise die Ordner (wahrscheinlich durch das UrlRewriting) nicht gefunden hatte - letztendlich funktioniert es aber...</p>  <p><strong>Und es rockt:</strong></p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e5cf2862-126b-468e-997d-06c3698ea17a" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public static class Pagination
    {
        public static PagedList&lt;T&gt; ToPagedList&lt;T&gt;(this IQueryable&lt;T&gt; source, int index, int pageSize)
        {
            return new PagedList&lt;T&gt;(source, index, pageSize);
        }

        public static PagedList&lt;T&gt; ToPagedList&lt;T&gt;(this IQueryable&lt;T&gt; source, int index)
        {
            return new PagedList&lt;T&gt;(source, index, 10);
        }
    }</pre></div>
