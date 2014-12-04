---
layout: post
title: "Caching / Cache-Control bei statischen Content via web.config"
date: 2011-08-30 23:01
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Caching, Http, IIS]
language: de
---
{% include JB/setup %}
<p>Statischer Content (Bilder, Javascripts, .HTML Files) können vom Client auch gecacht werden um die Daten nicht immer wieder zu übertragen. Das schont sowohl den Traffic als auch die Zeit, welche benötigt wird um die Seite zu rendern. Im Normalfall werden solche Inhalte ohne “Cache-Control” zum Client geschickt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1345.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb527.png" width="368" height="121"></a></p> <p>Dieses Verhalten kann man natürlich anpassen. Entweder direkt im IIS oder via Web.config</p> <p><strong>web.config Einstellungen</strong></p> <p>Da man nicht immer Zugriff auf den IIS hat, kann diese Einstellung ab IIS7 auch via der web.config erledigen (unter dem ASP.NET Development Server funktioniert diese Einstellung allerdings nicht, nur IIS7/IIS7.5 oder IIS Exoress) :</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8d212c13-934a-4370-ba72-399eebc5ba0e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;system.webServer&gt;
  &lt;staticContent&gt;
    &lt;clientCache cacheControlMode="UseMaxAge" cacheControlMaxAge="30.00:00:00" /&gt;
  &lt;/staticContent&gt;
&lt;/system.webServer&gt;</pre></div>
<p>&nbsp;</p>
<p>Durch diese Einstellung wird dem Client über den HTTP Response Header mitgeteilt, dass diese Inhalte 30 Tage lang gültig sind. Wenn sich allerdings an den Daten häufiger etwas ändert, dann sollte man eher eine niedrigere Zeit nehmen – 1 Tag zum Beispiel ist schon mal ein Anfang ;). </p>
<p>Die komplette Dokumentation findet sich <a href="http://www.iis.net/ConfigReference/system.webServer/staticContent/clientCache">hier</a>.</p>
<p>Nach der Änderung sieht die Response zum Beispiel so aus:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1346.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb528.png" width="339" height="155"></a></p>
<p><strong>Cache-Control vs. Expire</strong></p>
<p>Wer sich fragt, ob es nicht besser wäre die “Expire” Headers mitzuschicken (wie z.B. hier <a href="http://madskristensen.net/post/Add-expires-header-for-images.aspx">empfohlen</a>), der sollte sich diesen <a href="http://www.mnot.net/blog/2007/05/15/expires_max-age">Post</a> genauer durchlesen.</p>
<p><strong>Grundaussage:</strong> Eigentlich machen beide Header dasselbe, allerdings muss “Expire” eine genaue Datumsangabe enthalten. Solange man dies nicht über eine Library macht, sollte man lieber das einfachere “Cache-Control” nutzen, da man nur in Probleme läuft, wenn man die Datumsgrenze nicht anpasst.</p>
<p><strong>Best Practices – auch von Yahoo empfehlen</strong></p>
<p>Auch von Yahoo wird es empfohlen <a href="http://developer.yahoo.com/performance/rules.html">Expiration Headers bzw. Cache Control</a> zu setzen. <a href="http://developer.yahoo.com/yslow/">YSlow</a> von Yahoo ist ein tolles Tool um “Performance-Flaschen-Hälse” zu finden.</p>
