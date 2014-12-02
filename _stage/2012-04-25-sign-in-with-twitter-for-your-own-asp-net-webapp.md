---
layout: post
title: "„Sign in with Twitter“ for your own ASP.NET WebApp"
date: 2012-04-25 22:35
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: [ASP.NET, Twitter]
---
{% include JB/setup %}
&nbsp;

“Sign in with Twitter” is a popular practice to authenticate the users on your website. One advantage compared to an own registration is the lower inhibition for the user. But on the other hand Twitter doesn’t fess up with all the information’s and you will get into a kind of addiction. At the end everyone has to decide it by them self. <span style="text-decoration: underline;">The question is: </span>How can I integrate the Twitter Login into my website?

<strong> </strong>

<strong>Twitter Login – Oauth</strong>

<strong> </strong>

The base is the OAuth protocol for the authentication. The application isn’t able to see secure information’s like keywords. More background information’s <a href="http://oauth.net/">here</a>.

<strong>TweetSharp – 10 minutes guide to Twitter Login </strong>

<strong> </strong>

At least the <a href="http://oauth.net/">OAuth protocol</a> is a little bit “difficult”. There is a big library in the .NET environment which is able to understand both OAuth and OpenID: <a href="http://www.dotnetopenauth.net/">DotNetOpenAuth</a>. But the library is very extensive and heavy. So here is my recommendation: <a href="https://github.com/danielcrenna/tweetsharp">TweetSharp!</a>

<strong>Step 1: Take it from NuGet</strong>

Of course TweetSharp is also a <a href="http://nuget.org/packages/TweetSharp">NuGet package</a>:

<a href="http://code-inside.de/blog-in/wp-content/uploads/image1490.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1490" src="http://code-inside.de/blog-in/wp-content/uploads/image1490_thumb.png" border="0" alt="image1490" width="563" height="387" /></a>

<strong>Step 2: register the Twitter App</strong>

On the <a href="https://dev.twitter.com/apps/new">Developer Side of Twitter</a> you are able to adjust new apps. For our Dev-version the following information’s are enough.

<span style="text-decoration: underline;">Important: </span>enter the same information’s into WebSite and Callback URL – otherwise there are going to be some problems. We choose 127.0.0.1 – localhost. You are able to fit it on the right URL later into the application.

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb662.png" border="0" alt="image" width="500" height="328" />

The most important information’s:<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb663.png" border="0" alt="image" width="508" height="500" />

We need the Consumer Key and the Consumer Secret soon.

Note: There are several “authorities” to be set on the Access level. At the moment it is only possible to read the Tweets but it is not possible to write them with the application. So the Twitter App is for registration only and the user is going to be informed about it on the login-page.

<strong>Step 3: Auth Controller</strong>

<strong> </strong>

The code from Auth Controller is from the <a href="https://github.com/danielcrenna/tweetsharp">Doku on TweetSharp</a> and I only changed a few things.
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ca5400ce-3125-4ee2-8b95-efe0c57d9989" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using TweetSharp;

namespace OAuthSignInWithTwitter.Controllers
{
    public class AuthController : Controller
    {
        private string _consumerKey = "BOgMSVFOOOBARRRRR7QOB9Yw";
        private string _consumerSecret = "lRCbswKMKxFOOOBARRRRR2eL20X5uWG1FOOOBARRRRRjl3MM323pE8";

        public ActionResult Authorize()
        {
            // Step 1 - Retrieve an OAuth Request Token
            TwitterService service = new TwitterService(_consumerKey, _consumerSecret);

            var url = Url.Action("AuthorizeCallback", "Auth", null, "http");
            // This is the registered callback URL
            OAuthRequestToken requestToken = service.GetRequestToken(url);

            // Step 2 - Redirect to the OAuth Authorization URL
            Uri uri = service.GetAuthorizationUri(requestToken);
            return new RedirectResult(uri.ToString(), false /*permanent*/);
        }

        // This URL is registered as the application's callback at http://dev.twitter.com
        public ActionResult AuthorizeCallback(string oauth_token, string oauth_verifier)
        {
            var requestToken = new OAuthRequestToken { Token = oauth_token };

            // Step 3 - Exchange the Request Token for an Access Token
            TwitterService service = new TwitterService(_consumerKey, _consumerSecret);
            OAuthAccessToken accessToken = service.GetAccessToken(requestToken, oauth_verifier);

            // Step 4 - User authenticates using the Access Token
            service.AuthenticateWith(accessToken.Token, accessToken.TokenSecret);
            TwitterUser user = service.VerifyCredentials();

            FormsAuthentication.SetAuthCookie(user.ScreenName, false);

            return RedirectToAction("Index", "Home");
        }
    }
}</pre>
</div>
Between Step 1 and 2 we create the main Callback-URL. In this Callback we use the FormsAuthentication and set the Cookie so also the ASP.NET engine will know that we are logged in.

<strong>Step 4: UI modification </strong>

<strong> </strong>

In the _Layout.cshtml
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d5b2b471-5189-41f2-aed6-770dc36bd33f" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">  &lt;div id="title"&gt;
                &lt;h1&gt;My MVC Application&lt;/h1&gt;
            &lt;/div&gt;
            &lt;div id="logindisplay"&gt;
                @if(this.Request.IsAuthenticated)
                {
                    &lt;span&gt;@@@HttpContext.Current.User.Identity.Name&lt;/span&gt;
                }
                else
                {
                    @Html.ActionLink("Sign in with Twitter", "Authorize", "Auth");
                }
            &lt;/div&gt;</pre>
</div>
Either the user is logged in via ForumsAuthentication or we show the Link to the Authorize Methode.

<strong>Result:</strong>

<img title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb664.png" border="0" alt="image" width="244" height="145" />

<img title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb665.png" border="0" alt="image" width="377" height="251" />

<img title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb666.png" border="0" alt="image" width="228" height="121" />

Additional we can access on several Twitter attributes of the user. That’s it about the authentication. Not that difficult at all. If you want to use more futures for example sending Tweets has to keep in mind the AccessToken from the Callback.

On my Project <a href="http://www.knowyourstack.com/">KnowYourStack.com</a> I use a “Tinkerversion” via the DotNetOpenID Project – it works almost equal but it is a little bit more complicated so I recommend TweetSharp for this easy business.
