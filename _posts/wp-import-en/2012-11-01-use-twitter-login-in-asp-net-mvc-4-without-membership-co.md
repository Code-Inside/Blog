---
layout: post
title: "Use Twitter Login in ASP.NET MVC 4 without membership & co."
date: 2012-11-01 19:39
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

I’ve <a href="{{BASE_PATH}}/2012/04/25/sign-in-with-twitter-for-your-own-asp-net-webapp/">already blogged about the authentication with Twitter</a>. ASP.NET MVC 4 offers the DotNetOpenAuth NuGet package which makes the pure authentication process a lot easier.

<strong>ASP.NET MVC 4 – Membership &amp; co</strong>

<strong> </strong>

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb771.png" border="0" alt="image" width="290" height="330" align="left" />If you are going to create an ordinary MVC 4 WebApp you will find an “AccountController” and several classes in “AccountModels.cs”.

<strong>Save Twitter Login in RavenDB, MongoDB or what ever </strong>

<strong> </strong>

I have to admit that I was very disappointed with the whole Membership System some years ago and because of that I didn’t plan to invest more time into it. Indeed they offer SimpleMambership &amp; co ut to me it doesn’t seem “simple” and because I prefer to stay in charge of the information’s I sense this Membership System as a kind of paternalism.

Besides I refuse to save the Login-files into an SQL server but in RavenDB or my own formats.

<strong>Solution: use DotNetOpenAuth by yourself </strong>

<strong> </strong>

With ASP.NET MVC the DotNetOpenAuth NuGet package will be installed automatically and it offers several providers. It’s possible to contact this straight without the WebSecurity or Membership stuff from ASP.NET.
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6307f47c-ba6b-4344-8d3a-8dc5f615215e" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">public class TwitterLoginController : Controller
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
    }</pre>
</div>
I’ve mentioned how to find the Twitter Keys <a href="{{BASE_PATH}}/2012/04/25/sign-in-with-twitter-for-your-own-asp-net-webapp/">here</a>. Besides there are several helps on the <a href="https://dev.twitter.com/">Twitter Dev Site</a>.

After the successful login you will receive this “result”:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb772.png" border="0" alt="image" width="400" height="376" />

<strong>Publish on Twitter with the TwitterClient?</strong>

<strong> </strong>

Keep in mind: the only task of the TwitterClient in the DotNetOpenAuth project is the authentication. If you want to get the authentication and post Tweets you should take a look on the <a href="http://nuget.org/packages/DotNetOpenAuth.ApplicationBlock">DotNetOpenAuth ApplicationBlock</a> package on NuGet. Keyword is “TwitterConsumer” and the implementation of own Stores for the Keys.

<a href="https://github.com/Code-Inside/Samples/tree/master/2012/SimpleTwitterOAuth">[Source Code on GitHub]</a>
