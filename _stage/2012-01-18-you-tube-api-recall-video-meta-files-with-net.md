---
layout: post
title: "You Tube API – recall Video Meta files with .NET"
date: 2012-01-18 11:48
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: [You Tube API]
language: en
---
{% include JB/setup %}
<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image.png" src="http://code-inside.de/blog/wp-content/uploads/image1387.png" border="0" alt="image.png" width="150" height="150" />

&nbsp;

A loooong time ago I’ve blogged about how to access to You Tube with the <a href="http://code.google.com/apis/youtube/getting_started.html#data_api">Google Data APIs</a>. After all that time there are several new ways how to recall files. Google offers You Tube a “simple” surface. If you prefer to do low-Level HTTP calls <a href="http://code.google.com/apis/youtube/2.0/developers_guide_protocol_audience.html">it is also possible</a>.

Aim: I want the files to this You Tube video – but I already have the URL:

<a href="http://www.youtube.com/watch?v=ItqQ2EZziB8">http://www.youtube.com/watch?v=ItqQ2EZziB8</a> (different to my former Blogpost where I was searching stuff)

<strong> </strong>

<strong>download the library with NuGet</strong>

<strong> </strong>

For comfortable excess I recommend you Google Data APIs. You will find this on NuGet as well:

All you need is the Google.GData.Client and the Google.GData.YouTube package:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb570.png" border="0" alt="image" width="537" height="168" />

<strong>Code</strong>

<strong> </strong>

(because my Testclient is a console application and I need the functionality from the System.Web Assembly I changed the whole Frameworkt to .NET 4.0)
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4b02cb9f-e4ee-45e5-9a0d-5166ef8197f1" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">Uri youTubeLink = new Uri("http://www.youtube.com/watch?v=ItqQ2EZziB8");
            var parameters = System.Web.HttpUtility.ParseQueryString(youTubeLink.Query);
            var videoId = parameters["v"];

            Uri youTubeApi = new Uri(string.Format("http://gdata.youtube.com/feeds/api/videos/{0}", videoId));
            YouTubeRequestSettings settings = new YouTubeRequestSettings(null, null);

            YouTubeRequest request = new YouTubeRequest(settings);
            var result = request.Retrieve&lt;Video&gt;(youTubeApi);

            Console.WriteLine(result.Title);
            Console.WriteLine(result.Description);
            Console.WriteLine(result.ViewCount);

            Console.ReadLine();</pre>
</div>
<strong>Declaration</strong>

In line 3 I take the “v” parameter for the video. In line 5 I apply empty YouTubeRequestSettings – with this I’m able to call every official service but I can’t leave comments or upload videos.

Afterwards the Video will be picked up with the request.Retrieve. Now I have several Meta information’s about the Video.

<strong>No “Retrive” Method?</strong>

During the development process I’ve recognized a strange problem – under the Request-Object I had no Retrieve or Get Method. I’m not sure what the problem is. At least the You Tube Request class is from the Google.YouTube namespace – maybe I got the wrong class.

More Informations on <a href="http://code.google.com/apis/youtube/2.0/developers_guide_protocol.html">the YouTube API.NET side</a>.

<strong> </strong>

<strong>Result of my codes:</strong>

<img title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb571.png" border="0" alt="image" width="555" height="222" />

<a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2Fyoutubeapi%253Fstate%253Dclosed">[Code on Google Code]</a>
