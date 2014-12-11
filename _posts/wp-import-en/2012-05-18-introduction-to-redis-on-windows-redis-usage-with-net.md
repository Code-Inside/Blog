---
layout: post
title: "Introduction to Redis on Windows & Redis usage with .NET"
date: 2012-05-18 09:05
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

<a href="http://redis.io/">Redis</a> belongs to the NoSQL data banks and you will find it in the group of Key-Value Stores. Redis is often named “Blazing Fast” and according to the <a href="http://stackoverflow.com/questions/5252577/how-much-faster-is-redis-than-mongodb">Stackoverflow Thread</a> it is used to be two time (while writing) and three times (while reading) quicker than MongoDB. Even if the comparison is a little bit unfair (Document data bank vs. Key-Value).

<strong>Redis is going to be ported on Windows (and maybe also implemented as an Azure Service)</strong>

<strong> </strong>

It isn’t a secret that the <a href="http://blogs.msdn.com/b/interoperability/archive/2012/04/12/announcing-one-more-way-microsoft-will-engage-with-the-open-source-and-standards-communities.aspx">Microsoft Open Source department</a> is working on running Redis on Windows at all. <a href="http://blogs.msdn.com/b/interoperability/archive/2012/04/26/here-s-to-the-first-release-from-ms-open-tech-redis-on-windows.aspx">A first concept</a> was published last week. Microsoft sheared there <a href="https://github.com/MSOpenTech/redis">results on GitHub</a> – even if there is still a long way to go before the productive use on windows.

<strong> </strong>

<strong>Redis as an Azure Service?</strong>

&nbsp;

One of the firs comments is already mentioning Azure:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb694.png" border="0" alt="image" width="586" height="84" />

the answer:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb695.png" border="0" alt="image" width="589" height="120" />

Let’s take a look when this could be reality: additionally there are already some <a href="http://www.cloudhostingguru.com/redis-server-hosting.php">Redis Hoster</a>.

<strong>Getting Redis to run on Windows</strong>

Before it will work in the Cloud it should work on our Windows surrounding. At the Moment (May 2012) you need to download this <a href="https://github.com/MSOpenTech/redis/tree/bksavecow">Dev Branch</a> and open the RedisServer.sln with Visual Studio:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb696.png" border="0" alt="image" width="288" height="325" />

You need to build the Solution (consisting of C ++ Projects):

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb697.png" border="0" alt="image" width="244" height="198" />

Depending on your configuration you will receive the msvs\Debug folder or the msvs\Release folder. The folder contains numerous files including the redis-server.exe.

<strong>Start the Server</strong>

After the Start of the Server you will see the Server Port (a little bit hidden but still there)

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="SNAGHTMLd00e987" src="{{BASE_PATH}}/assets/wp-images-de/SNAGHTMLd00e987_thumb.png" border="0" alt="SNAGHTMLd00e987" width="501" height="265" />

<strong>Redis &amp; .NET AKA play around with API</strong>

<strong> </strong>

Advance notice: I do not know what to do with Redis it is just pure interest and ludic drive.

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb698.png" border="0" alt="image" width="381" height="222" />

For demonstration I’ve created a simple MVC project and searched Redis via NuGet:

Service.Stack.Redis – sounds good!

<a href="{{BASE_PATH}}/assets/wp-images-en/SNAGHTMLd040daa.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="SNAGHTMLd040daa" src="{{BASE_PATH}}/assets/wp-images-en/SNAGHTMLd040daa_thumb.png" border="0" alt="SNAGHTMLd040daa" width="508" height="351" /></a>

Democode:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a24bbcbc-c0cb-4852-80a8-b8dec91387fd" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#"> public ActionResult Index()
        {
            RedisClient client = RedisClientFactory.Instance.CreateRedisClient("localhost",6379);
            client.Add("Test", Guid.NewGuid());

            var result = client.Get&lt;Guid&gt;("Test");

            ViewBag.Message = "Welcome Redis: " + result;

            return View();
        }</pre>
</div>
E voilà! A GUID:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb699.png" border="0" alt="image" width="352" height="169" />

And there is also something going on in the console:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="SNAGHTMLd074196" src="{{BASE_PATH}}/assets/wp-images-de/SNAGHTMLd074196_thumb.png" border="0" alt="SNAGHTMLd074196" width="529" height="280" />

<strong>When should I use Redis? What is good? What is bad?</strong>

Because I’m not that experienced at the moment I would like to collect the oppinions on <a href="http://www.knowyourstack.com/what-is/redis">KnowYourStack.com</a>: <a href="http://www.knowyourstack.com/when-should-i-use/redis">Why should I use Redis</a>? <a href="http://www.knowyourstack.com/why/redis/rocks">What is good</a>? <a href="http://www.knowyourstack.com/why/redis/sucks">What is bad?</a>
