---
layout: post
title: "HowTo: Twittern mit C#"
date: 2009-04-20 01:34
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Tweetsharp, Twitter]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image713.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="111" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb691.png" width="164" align="left" border="0" /></a><a href="http://twitter.com">Twitter</a> ist eigentlich der <a href="http://de.wikipedia.org/wiki/Twitter">Mikroblogging Dienst</a> im Internet - ich selber bin ebenfalls auf der Plattform vertreten. Twitter hat seit beginn auch eine kostenlose <a href="http://apiwiki.twitter.com/">API</a>, wodurch sehr viele Twitter Applikationen entstanden sind. Auch mit .NET kann man sehr leicht die Twitter API nutzen bzw. gibt es bereits sehr interessante Bibliotheken, wie z.B. <a href="http://code.google.com/p/tweetsharp/">Tweetsharp</a>. </p> 
<!--more-->
  <p><strong>Twitter API      <br /></strong>Die Doku der Twitter API findet man <a href="http://apiwiki.twitter.com/">hier</a>. Eine gute Zusammenfassung findet sich auf <a href="http://apiwiki.twitter.com/Things-Every-Developer-Should-Know">dieser Seite</a>. Die gesamte <a href="http://en.wikipedia.org/wiki/Representational_State_Transfer">REST</a>-API ist &#252;ber HTTP zu erreichen und kann deshalb auch sehr einfach anprogrammiert werden.</p>  <p><strong>Twittern &#252;ber C# - &quot;low level&quot;</strong>     <br /><a href="http://blog.veloursnebel.de/">Kai Gloth</a> hat bereits einen <a href="http://blog.veloursnebel.de/2008/10/twitter-und-c/">sehr guten Blogpost</a> dar&#252;ber geschrieben. Im Grunde genommen ist es nur ein einfacher HTTP Call und die Response kommt als XML bzw. auch als JSON.</p>  <p><strong>C# APIs f&#252;r Twitter      <br /></strong>Wem das etwas zu sehr low level ist bzw. etwas mehr machen m&#246;chte mit Twitter (z.B. Suchanfragen setzen etc.), der kann sich einer der interessanten <a href="http://apiwiki.twitter.com/Libraries#C/NET">C# APIs</a> bedienen.</p>  <p><strong>Ein Beispiel: Tweetsharp      <br /></strong><a href="http://code.google.com/p/tweetsharp/">Tweetsharp</a> hat mir auf den ersten Blick ganz gut gefallen, daher nehme ich dies mal als ein Beispiel, wie man ein Statusupdate auf Twitter ver&#246;ffentlicht:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a14dbc2a-9b8a-4438-85a1-3829edb17bbb" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    class Program
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

<p>Auch die <a href="http://code.google.com/p/tweetsharp/w/list">Doku</a> ist recht umfangreich und auf der <a href="http://tweetsharp.com/">Homepage</a> gibt es auch noch ein paar nette Blogposts.</p>

<p><strong>Authentifizierung</strong> 

  <br />Wer eine der unz&#228;hligen Twitter Applikationen selber mal ausprobiert hat, wird meistens sein Passwort direkt in der Applikation eingegeben haben. Da das nat&#252;rlich doch ein recht gro&#223;es Sicherheitsrisiko ist, hat Twitter auch einen <a href="http://oauth.net/">OAuth</a> Authentifizierungsmechanismus <a href="http://apiwiki.twitter.com/OAuth-FAQ">bereitgestellt</a>. 

  <br />Tweetsharp bietet auch bereits daf&#252;r eine Unterst&#252;tzung an - wer also eine Twitteranwendung f&#252;r die breite Masse bauen m&#246;chte, der sollte mal ein Blick auf <a href="http://tweetsharp.com/?p=68">diesen</a> oder <a href="http://tweetsharp.com/?p=60">jenen</a> Blogpost werfen.</p>

<p><strong>Beispielanwendung</strong>

  <br />Auf <a href="http://codeplex.com/">Codeplex</a> gibt es einige Twitter Clients zum Ausprobieren, z.B. <a href="http://digitweet.codeplex.com/">digitweet</a>, ein WPF Twitter Client.</p>
