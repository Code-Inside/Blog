---
layout: post
title: "Twitter Login in ASP.NET MVC 4 ohne Membership & co. nutzen"
date: 2012-10-14 22:46
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, MVC4, OAuth, Twitter]
language: de
---
{% include JB/setup %}
<p>Ich hatte bereits <a href="{{BASE_PATH}}/2012/04/02/sign-in-with-twitter-fr-die-eigene-asp-net-webapp/">vor einiger Zeit über die Authentifizierung mit Twitter</a> gebloggt. Mit ASP.NET MVC 4 kommen das DotNetOpenAuth NuGet Packages mit, welches die reine Authentifzieren deutlich vereinfachen.</p> <p><strong>ASP.NET MVC 4 – Membership &amp; co.</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1612.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; margin: 0px; display: inline; border-top-width: 0px" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb771.png" width="290" height="330"></a> </p> <p>Wer eine ganz normale MVC 4 WebApp erstellen möchte findet danach direkt einen “AccountController” und mehrere Klassen in der “AccountModels.cs”.</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p><strong>Twitter Login in RavenDB, MongoDB oder sonstwas abspeichern</strong></p> <p>Ich muss zugeben: Das gesamte Membership System hat mich vor mehreren Jahren ziemlich enttäuscht, sodass ich gar keine Zeit mehr darin investieren möchte. Zwar gibt es jetzt SimpleMembership &amp; co., aber irgendwie sieht der AccountController schonmal nicht “simpel” aus und da ich meist selbst “Herr der Daten” sein möchte empfand ich das Membership System immer als Bevormundung.</p> <p>Dazu kommt, dass ich die Login-Daten nicht in ein SQL Server pumpen will, sondern in RavenDB oder in mein eigenes Format.</p> <p><strong>Lösung: Selbst DotNetOpenAuth verwenden</strong></p> <p>Mit ASP.NET MVC wird auch das DotNetOpenAuth NuGet Package installiert, welches diverse Provider mitbringt. Das kann man natürlich auch direkt ansprechen - ohne die WebSecurity oder Membership Sachen von ASP.NET.</p><pre>public class TwitterLoginController : Controller
    {
        // Callback after Twitter Login
        public ActionResult Callback()
        {
            DotNetOpenAuth.AspNet.Clients.TwitterClient client = new TwitterClient(ConfigurationManager.AppSettings["twitterConsumerKey"], ConfigurationManager.AppSettings["twitterConsumerSecret"]);

            var result = client.VerifyAuthentication(this.HttpContext);

            return RedirectToAction("Index", "Home");
        }

        // Point Login URL to this Action
        public ActionResult Login()
        {
            DotNetOpenAuth.AspNet.Clients.TwitterClient client = new TwitterClient(ConfigurationManager.AppSettings["twitterConsumerKey"], ConfigurationManager.AppSettings["twitterConsumerSecret"]);

            UrlHelper helper = new UrlHelper(this.ControllerContext.RequestContext);
            var result = helper.Action("Callback", "TwitterLogin", null, "http");

            client.RequestAuthentication(this.HttpContext, new Uri(result));

            return new EmptyResult();
        }
    }
</pre>
<p>Wie man die Twitter Keys beschafft habe ich <a href="{{BASE_PATH}}/2012/04/02/sign-in-with-twitter-fr-die-eigene-asp-net-webapp/">hier bereits beschrieben</a>. Ansonsten gibt es auch Hilfe direkt auf der <a href="https://dev.twitter.com/">Twitter Dev Seite</a>.</p>
<p>Nach dem erfolgreichen Login bekommt man dies als “result”:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1613.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb772.png" width="400" height="376"></a> </p>
<p><strong>Auf Twitter Posten über den TwitterClient?</strong></p>
<p>Wichtig hier anzumerken: Der TwitterClient in dem DotNetOpenAuth Projekt übernimmt nur die Authentifzierung. Wer eine Authroisierung und Tweets posten möchte der sollte sich das <a href="http://nuget.org/packages/DotNetOpenAuth.ApplicationBlock">DotNetOpenAuth ApplicationBlock</a> NuGet Package anschauen. Stichwort ist “TwitterConsumer” und die Implementierung eines eigenen Stores für die Keys.</p>
<p></p>
<p><a href="https://github.com/Code-Inside/Samples/tree/master/2012/SimpleTwitterOAuth"><strong>[ Source Code auf GitHub ]</strong></a></p>
