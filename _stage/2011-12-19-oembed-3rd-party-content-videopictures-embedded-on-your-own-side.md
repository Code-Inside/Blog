---
layout: post
title: "oEmbed – 3rd Party Content (Video/Pictures/…) embedded on your own side"
date: 2011-12-19 21:54
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

&nbsp;

To embed content from other sides like YouTube, Flickr, Slideshare seems to be very difficult at the first sight especially if you want to make it “automatically” from the URL. How the embedding works depends on the content – on YouTube and so on you need a video player for Slideshare and so on you need Flash/JS for the presentations. But there is a standard for exact this case: <a href="http://oembed.com/">oEmbed.</a>

<strong>Aims of oEmbed</strong>

oEmbed is used to be a standard surface to embed content from other sides on your own side. There are some important names supporting oEmbed like YouTube or Flickr:

<strong>Example Flickr:</strong>

The client calls this URL:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:baaad417-0975-4d49-b2f4-066f856357ed" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">http://www.flickr.com/services/oembed/?url=http%3A//www.flickr.com/photos/bees/2341623661/</pre>
</div>
And receives this answer:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8e2181e3-715a-4143-82b6-5e3144403129" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">{
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
}</pre>
</div>
<strong>Example YouTube:</strong>

Call:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2d8e2329-6d3f-4765-9616-a71d75177c33" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">http://www.youtube.com/oembed?url=http%3A//youtube.com/watch%3Fv%3DM3r2XDceM6A&amp;format=json</pre>
</div>
Answer:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4488d140-1ebe-444c-8d65-d6dc713209e3" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">{
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
}</pre>
</div>
Especially on YouTube the Idea works: In the HTML Property you will find the whole code do embed the YouTube player.

<strong>oEmbed Answers </strong>

According to the Standard the answer will be XML or JSON but at the moment JSON is the more in use. YouTube supports both.

<strong>jQuery oEmbed library </strong>

There is also a <a href="http://code.google.com/p/jquery-oembed/">jQuery library</a> to call this service. For this they use <a href="http://code-inside.de/blog/2009/12/11/howto-cross-domain-ajax-mit-jsonp-und-asp-net/">JSONP.</a>

<strong>Embed.ly – oEmbed Hub </strong>

<strong> </strong>

<a href="{{BASE_PATH}}/assets/wp-images-en/image1393.png"><img style="background-image: none; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; padding-top: 0px; border: 0px;" title="image1393" src="{{BASE_PATH}}/assets/wp-images-en/image1393_thumb.png" border="0" alt="image1393" width="186" height="72" align="left" /></a>Because of oEmbed the format is fixed but anyway you need to question numerous Providers to get to know the URLS. With the service embed.ly you can access to a kind of “Hub”. Embeded.ly provides a oEmbed endpoint and you can send <a href="http://embed.ly/providers">almost every kind of address</a> to emebd.ly and you will receive a fitting answer.

Embed.ly could be called easily with the jQuery Plugin.

<strong> </strong>

<strong>Embedy.ly – costs </strong>

There is a rub with embed.ly – it’s not for free. But there is <a href="http://embed.ly/pricing">a Account-Type for free (scroll to the bottom!)</a>. With this Account you are allowed to make 10.000 calls every month. Afterwards the prices are graded.

<strong>Who could be interested in embed.ly or oEmbed? </strong>

<strong> </strong>

The most important usage is for “link-sharing” sites like Digg.com and so on but you get some meta-information from the URL so you don’t need a complex connection to API.

<strong>Try it on embed.ly</strong>

Embed.ly offers a “<a href="http://embed.ly/docs/explore/oembed?url=http%3A%2F%2Fvimeo.com%2F18150336">Test-Client</a>” to get a feeling for the results you can await.
