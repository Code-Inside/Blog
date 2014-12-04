---
layout: post
title: "Speech Input API – speech input with an attribute in the Web?"
date: 2012-03-16 16:24
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

By accident I found the page of <a href="http://code.nasa.gov/">code.nasa.org</a> today. A little icon showing a microphone cached my attention:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb613.png" border="0" alt="image" width="535" height="109" />

<a href="http://www.thechromesource.com/how-to-demo-chrome-11s-speech-recognition-feature/">Since Chrome 11</a> there is a “support” for the <a href="http://lists.w3.org/Archives/Public/public-xg-htmlspeech/2011Feb/att-0020/api-draft.html">Speech Input API</a>. I’ve read about this but in fact I thought the integration would be more extensive. Surprisingly the implementation is very easy – with the attribute “x-webkit-speech” (later on it’s only “speech”). The whole thing should be able to work with Input and Textarea elements:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3628542e-0da2-407e-80b2-458cc7027018" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">//Supported elements

&lt;input type="text" x-webkit-speech /&gt;
&lt;textarea x-webkit-speech /&gt;</pre>
</div>
<strong>A bottle of bitterness</strong>

<strong> </strong>

It only works on Chrome and you have to speak very slow and clear. He doesn’t understand German and only a few English. Hmm… not a Siri at all. The Speech Input API is still in his baby shoes and there aren’t that many improvements since the Release of Chrome 11.

<strong>Have a try</strong>

You are able to try it for example <a href="http://slides.html5rocks.com/#speech-input">here</a>. But this video shows how it works as well (for those who are not Chrome users <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile35.png" alt="Zwinkerndes Smiley" />)

&nbsp;
<div id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:700036c3-e6e0-4b00-9d49-ff44f8acfdcb" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<div><object width="640" height="360"><param name="movie" value="http://www.youtube.com/v/i225WaqV8tM?hl=en&amp;hd=1" /><embed type="application/x-shockwave-flash" width="640" height="360" src="http://www.youtube.com/v/i225WaqV8tM?hl=en&amp;hd=1"></embed></object></div>
</div>
