---
layout: post
title: "HowTo: Tweet with C#"
date: 2009-04-23 01:33
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Tweetsharp, Twitter]
language: en
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image82.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="111" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb97.png" width="164" align="left" border="0" /></a><a href="http://twitter.com">Twitter</a> is <strong>the</strong> internet <a href="http://en.wikipedia.org/wiki/Micro-blogging">Microblogging Service</a> - this is <a href="http://twitter.com/robert0muehsig">my acc BTW</a>. Twitter has an <a href="http://apiwiki.twitter.com/">API</a> since the beginning (and IMHO is this one big reason why twitter is so successful). The Twitter API is <a href="http://en.wikipedia.org/wiki/Representational_State_Transfer">REST</a> based and so you can easily create Twitter-Clients with .NET. If you don&#180;t want to create the HTTP basic stuff, check out existing libraries, like <a href="http://code.google.com/p/tweetsharp/">Tweetsharp</a>. </p> 
<!--more-->
  <p><strong>Twitter API      <br /></strong>You can find the Twitter API docs <a href="http://apiwiki.twitter.com/">here</a> and a <a href="http://apiwiki.twitter.com/Things-Every-Developer-Should-Know">good overview here</a>. </p>
<p><strong>Twittern via C# - &quot;low level&quot;</strong>     <br />You can use HttpRequest &amp; HttpResponse objects to use twitter: <a href="http://psantos-blog.zi-yu.com/?p=197">Sample here</a>.</p>
<p><strong>C# APIs for Twitter      <br /></strong>If you don&#180;t want do deal with the low level things, then you should look at these <a href="http://apiwiki.twitter.com/Libraries#C/NET">C# APIs</a></p>
<p><strong>One example: Tweetsharp      <br /></strong><a href="http://code.google.com/p/tweetsharp/">Tweetsharp</a> is a really cool, fluent interface for accessing Twitter, Url-Shorting-Services, Twitpic and so on. Here I create a simple update on twitter:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a14dbc2a-9b8a-4438-85a1-3829edb17bbb" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    class Program
    {
        static void Main(string[] args)
        {
            var twitter = FluentTwitter.CreateRequest()
            .AuthenticateAs("USERNAME", "PASSWORD")
            .Statuses().Update("testing, one, two, three!")
            .AsJson();

            var response = twitter.Request();
        }
    }</pre></div>

<p>Look at the <a href="http://code.google.com/p/tweetsharp/w/list">Google Code wiki</a> or on the <a href="http://tweetsharp.com/">homepage</a> for more information. </p>

<p><strong>Authorization</strong> 

  <br />If you use a 3rd Party Twitter Client (like <a href="http://www.tweetdeck.com/">Tweetdeck</a>) you have to type in your credentials to get access to your Twitter-Data. This is from a security point of view not very smart. That&#180;s why Twitter enabled <a href="http://oauth.net/">OAuth</a> authorization, which is also provided by <a href="http://apiwiki.twitter.com/OAuth-FAQ">Tweetsharp</a> (look <a href="http://tweetsharp.com/?p=68">here</a> &amp; <a href="http://tweetsharp.com/?p=60">here</a>).</p>

<p><strong>Sample</strong> 

  <br />You can find a nice WPF Twitter Client on <a href="http://digitweet.codeplex.com/">Codeplex</a>.</p>
