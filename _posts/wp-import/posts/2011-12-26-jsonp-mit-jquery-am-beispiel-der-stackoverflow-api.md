---
layout: post
title: "JSONP mit jQuery am Beispiel der Stackoverflow API"
date: 2011-12-26 12:03
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, jsonp, Stackoverflow]
---
{% include JB/setup %}
<p><a href="http://stackoverflow.com/">Stackoverflow.com</a> – der Segen für alle Programmierer und die, die es werden wollen. Die Seite enthält nicht nur Fragen und Antworten, sondern hat über die Tagging Funktion auch eine Art “Mini”-Wiki für Technologien entwickelt. <a href="http://api.stackoverflow.com">Stackoverflow bietet natürlich auch eine API</a> an und für einfache lesende Zugriffe gibt es auch eine Variante, welche die eigenen Serverkapazitäten schont und ziemlich clever ist: Die Rede ist von <a href="http://en.wikipedia.org/wiki/JSON#JSONP">JSONP</a>.</p> <p><strong>Was ist JSONP?</strong></p> <p>Durch das <a href="http://en.wikipedia.org/wiki/Same_origin_policy">Sicherheitsmodell</a> im Browser ist es heutzutage nicht wirklich einfach möglich AJAX Requests an Seiten zu schicken, welche eine andere Domain haben. Allerdings kann man einen kleinen Workaround benutzen: Es ist erlaubt, fremde Ressourcen von anderen Domains über GET einzubinden. Dazu zählt natürlich auch Javascript.</p> <p>JSONP bedient sich diesem Trick: Der Browser erlaubt es, dass man fremden Javascript Content via Http GET auf die eigene Seite einbindet. Der fremde Javascript Code kann alles mögliche sein, u.a. auch JSON. Damit ist die Idee der JSONP API geboren.</p> <p><strong>jQuery und JSONP – sieht aus wie AJAX. Ist auch fast dasselbe.</strong></p> <p>Ein <u>normaler</u> jQuery AJAX Aufruf, um ein</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:20b50d4e-902e-4144-86fd-380badbc13f2" class="wlWriterEditableSmartContent"><pre name="code" class="c">$.ajax({
  url: "test.html",
  cache: false,
  success: function(html){
    $("#results").append(html);
  }
});</pre></div>
<p>&nbsp;</p>
<p>Der <u>JSONP jQuery Aufruf</u> ist leicht modifiziert und enthält ein “dataType jsonp” Property.</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:56b3ddf7-fdfc-410d-a355-a2ae0e0fad6a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">
$.ajax({
  url: "otherDomain...",
  cache: false,
  dataType: 'jsonp',
  success: function(html){
    $("#results").append(html);
  }
});</pre></div>
<p><strong>Beispiel Stackoverflow API:</strong></p>
<p>Ich möchte die Wiki Information über das Tag “<a href="http://stackoverflow.com/tags/ravendb/info">RavenDB</a>” mir über JSONP holen.</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c7a6d6af-5eb9-4b6e-9c92-5405fb7103a8" class="wlWriterEditableSmartContent"><pre name="code" class="c#">            
                $.ajax({
                    type: 'GET',
                    url: 'http://api.stackoverflow.com/1.1/tags/ravendb/wikis',
                    dataType: 'jsonp',
                    success: function (data) {
                        if (data.tag_wikis.length &gt; 0) {
                            alert(data.tag_wikis[0].wiki_excerpt);
                     	}  
                    },
                    jsonp: 'jsonp'
                });</pre></div>


<p>Als Ergebnis kommen die Daten über den Browser geladen direkt von Stackoverflow.</p>
<p><strong>Was bringt das?</strong></p>
<p>Durch jsonp erspart man sich den Proxy, welcher zwischen dem Browser und dem eigentlichen Service vermitteln müsste. Allerdings sind die Anwendungsfälle recht beschränkt und ein praktischer Einsatz ist mir nur bei lesenden Sachen bekannt. Evtl. geht hier aber später mehr mit Websockets &amp; co. </p>
