---
layout: post
title: "Chrome Instant Page/ Prerendering – what is it and how can I use it?"
date: 2011-08-10 23:04
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: [Chrome; Instant Page; Prerendering]
language: en
---
{% include JB/setup %}
&nbsp;

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image.png" src="{{BASE_PATH}}/assets/wp-images-de/image1325.png" border="0" alt="image.png" width="300" height="184" />

With the Version 13 of Chrome Google activated a <a href="http://chrome.blogspot.com/2011/08/instant-pages-on-google-chrome.html">new feature named “Instant Page”.</a> It’s another step into “making the web faster”. What “instant page” is shows this video:
<div id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:727e700d-ddca-4ce2-a62e-1f6162e22e2c" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<div><object width="380" height="231"><param name="movie" value="http://www.youtube.com/v/_Jn93FDx9oI?hl=en&amp;hd=1" /><embed type="application/x-shockwave-flash" width="380" height="231" src="http://www.youtube.com/v/_Jn93FDx9oI?hl=en&amp;hd=1"></embed></object></div>
</div>
Of course Google integrated the feature into the Google search page.

<strong>What’s the function of Google Instant Page?</strong>

The basic principle is quite simple: While the user is checking the search results for fitting answers the first matches are loading in the background. The consequence is that the first search results appear directly if you click on the link in the Google search. Cool Feature and very clever.

There are some scenarios where this could be very useful. For example searching pages or Wizard-pages or multilateral articles – on all alternatives it’s possible that the user clicks on the searching results or enters the next side.

<strong>Beware – you should use it careful </strong>

<strong> </strong>

Here is the little challenge: To do this with every link is the wrong way because of this files will be transmitted senseless which has bad results for the user and for the provider – a lot of traffic but without visitors.

<strong>Testpage</strong>

<strong> </strong>

Google offers a simple testpage which tests if Prerender is activated or not (the page is only interesting in Chrome): <a href="http://prerender-test.appspot.com/">http://prerender-test.appspot.com/</a>

<strong>Okay, how does this work? </strong>

On the <a href="http://code.google.com/chrome/whitepapers/prerender.html">Chrome Developer Side</a> there are some interesting things but in fact the implementation is very easy. To find out how many traffic accrues I take a look on the Network Tab of the Chrome Dev Tools and I use <a href="http://www.fiddler2.com/fiddler2/">Fiddler</a>.

Following HTML Code <strong>without Prerendering</strong>:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f7093b7c-cdfa-4461-9ff9-1e7ceb9a5e56" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">&lt;!DOCTYPE html&gt;

&lt;html&gt;

&lt;head&gt;

    &lt;meta charset="utf-8" /&gt;

    &lt;title&gt;Index&lt;/title&gt;

&lt;/head&gt;

&lt;body&gt;

&lt;a href="{{BASE_PATH}}"&gt;Link Code Inside&lt;/a&gt;

&lt;/body&gt;

&lt;/html&gt;</pre>
</div>
There is just a Request/Response and a Favicon will be searched (doesn’t matter at the moment). No surprise so far.

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb508.png" border="0" alt="image" width="244" height="207" />

If you are navigating to the link Code-Inside.int it’s going to load in this moment = slow.

<strong>Activate Prerendering </strong>

If we want to activate Prerendering now all we have to do is to add this line into &lt;head&gt;:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:586d358a-ab37-44e4-a830-58004d8a4751" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">&lt;link rel="prerender" href="{{BASE_PATH}}"&gt;</pre>
</div>
Now you can see in the Chrome Dev Tools that the address is requested but there are no other files shown – only with Chrome 14 we will get new information’s.

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb509.png" border="0" alt="image" width="404" height="207" />

A few into Fiddler will give us more information’s. With the Prerendering all needed files will be downloaded:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb510.png" border="0" alt="image" width="499" height="454" />

Now the side appears with a click.

<strong>Compendium</strong>

Prerendering is an interesting technology which will be used from other browser providers soon. But, as I said before it’s not useful to use it with every link.

Technical you can activate it with &lt;link rel=”prerender”href=”…”&gt;. Assumption is of course that the browser knows it – which is only possible with Chrome Version 13 at the moment.

<strong> </strong>

<strong>Forecast</strong>

Google proposed a <a href="http://code.google.com/chrome/whitepapers/pagevisibility.html">Page Visibility API</a> to afford the side provider to see what the browser “see” while prerendering.

[<a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2FChromePrerender">Democode on Google Code</a> / <a href="{{BASE_PATH}}/assets/files/democode/chromeprerender/chromeprerender.zip">Download as Zip</a>]
