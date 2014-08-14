---
layout: post
title: "oEmbed–3rd Party Content (Video/Bilder/…) auf die eigene Seite einbetten"
date: 2011-11-22 02:40
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, oEmbed]
---
{% include JB/setup %}
<p>Content von anderen Seiten, z.B. YouTube, Flickr, Slideshare auf die eigene Seite einzubetten ist auf den ersten Blick immer nur schwer möglich. Insbesondere wenn man dies “automatisiert” anhand der URL machen möchte. Wie die Einbettung erfolgt hängt stark vom Content ab – bei YouTube und co. muss ein Videoplayer zum Einsatz kommen, Slideshare und co. nehmen Flash/JS für die Präsentationen. Allerdings gibt es einen Standard, welche genau diesen Fall abdecken möchte: <a href="http://oembed.com/">oEmbed</a>.</p> <p><strong>Ziel von oEmbed</strong></p> <p>oEmbed soll eine einheitliche Schnittstelle sein, über den der eigene Content von anderen Seiten eingebettet werden kann. Es gibt einige große Namen, welche oEmbed unterstützen, darunter YouTube und Flickr:</p> <p><strong>Beispiel Flickr:</strong></p> <p>Der Client ruft diese URL auf:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c0f0885e-4603-4d8a-af93-59984ad912ca" class="wlWriterEditableSmartContent"><pre name="code" class="c#">http://www.flickr.com/services/oembed/?url=http%3A//www.flickr.com/photos/bees/2341623661/</pre></div>
<p>&nbsp;</p>
<p>Und bekommt als Antwort:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:107f45b2-dba6-42a7-88de-8e209262b0ad" class="wlWriterEditableSmartContent"><pre name="code" class="c#">{
	"version": "1.0",
	"type": "photo",
	"width": 240,
	"height": 160,
	"title": "ZB8T0193",
	"url": "http://farm4.static.flickr.com/3123/2341623661_7c99f48bbf_m.jpg",
	"author_name": "Bees",
	"author_url": "http://www.flickr.com/photos/bees/",
	"provider_name": "Flickr",
	"provider_url": "http://www.flickr.com/"
}</pre></div>

<p><strong>Beispiel YouTube:</strong></p>
<p>Aufruf:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:01e64ad9-55cb-4467-893e-ea4332ea0355" class="wlWriterEditableSmartContent"><pre name="code" class="c#">http://www.youtube.com/oembed?url=http%3A//youtube.com/watch%3Fv%3DM3r2XDceM6A&amp;format=json</pre></div>
<p>Antwort:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:04b1503b-8fae-4912-bd8f-de81964cb6c7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">{
	"version": "1.0",
	"type": "video",
	"provider_name": "YouTube",
	"provider_url": "http://youtube.com/",
	"width": 425,
	"height": 344,
	"title": "Amazing Nintendo Facts",
	"author_name": "ZackScott",
	"author_url": "http://www.youtube.com/user/ZackScott",
	"html":
		"&lt;object width=\"425\" height=\"344\"&gt;
			&lt;param name=\"movie\" value=\"http://www.youtube.com/v/M3r2XDceM6A&amp;fs=1\"&gt;&lt;/param&gt;
			&lt;param name=\"allowFullScreen\" value=\"true\"&gt;&lt;/param&gt;
			&lt;param name=\"allowscriptaccess\" value=\"always\"&gt;&lt;/param&gt;
			&lt;embed src=\"http://www.youtube.com/v/M3r2XDceM6A&amp;fs=1\"
				type=\"application/x-shockwave-flash\" width=\"425\" height=\"344\"
				allowscriptaccess=\"always\" allowfullscreen=\"true\"&gt;&lt;/embed&gt;
		&lt;/object&gt;",
}</pre></div>
<p>&nbsp;</p>
<p>Insbesondere bei dem YouTube Beispiel kommt die Idee zum Tragen: Im HTML Property steht der komplette Code zum Einbinden des YouTube Players.</p>
<p><strong>oEmbed Rückgaben</strong></p>
<p>Laut Standard kann als Ergebnis entweder XML oder JSON zurückkommen, allerdings ist heute JSON eher gebräuchlich. YouTube unterstützt aber z.B. beides.</p>
<p><strong>jQuery oEmbed Bibliothek</strong></p>
<p>Es gibt auch eine <a href="http://code.google.com/p/jquery-oembed/">jQuery Bibliothek</a> um diese Services abzufragen. Dabei wird auf <a href="http://code-inside.de/blog/2009/12/11/howto-cross-domain-ajax-mit-jsonp-und-asp-net/">JSONP</a> zurückgegriffen.</p>
<p><strong>embed.ly – oEmbed Hub</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1393.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 5px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb575.png" width="186" height="72"></a></p>
<p>Durch oEmbed ist das Format vorgegeben, jedoch muss man trotzdem dutzende Provider einzeln anfragen und die entsprechenden URLs wissen. Mit dem Dienst embed.ly kann man auch auf eine Art “Hub” zurückgreifen. <strong>Embed.ly</strong> stellt einen oEmbed Endpunkt bereit und man kann <a href="http://embed.ly/providers">“fast” jede Adresse</a> an embed.ly senden und man bekommt meist eine passende Antwort.</p>
<p>embed.ly selbst kann einfach über das jQuery Plugin angesprochen werden. </p>
<p><strong>embed.ly – Kostenpunkt</strong></p>
<p>embed.ly hat allerdings auch einen Haken: Es ist nicht kostenlos. Es gibt allerdings <a href="http://embed.ly/pricing">einen kostenfreien Account-Typ (nach unten scrollen!).</a> Über diesen Account kann man monatlich 10.000 Aufrufe machen. Danach sind die <a href="http://embed.ly/pricing">Preise</a> gestaffelt.</p>
<p><strong>Für wen ist embed.ly und oEmbed interessant?</strong></p>
<p>Allen voran ist die offensichtlichste Nutzung bei “Link-Sharing” Seiten wie Digg.com etc. Allerdings bekommt man auch über die pure URL ein paar Meta-Informationen raus, sodass man sich u.a. auch die Anbindung an eine komplexe API sparen kann.</p>
<p><strong>Selbst ausprobieren auf embed.ly</strong></p>
<p>embed.ly stellt ein “<a href="http://embed.ly/docs/explore/oembed?url=http%3A%2F%2Fvimeo.com%2F18150336">Test-Client</a>” bereit über den man ein Gefühl dafür bekommt, welche Ergebnisse man erwarten kann. </p>
