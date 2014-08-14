---
layout: post
title: "“Sign in with Twitter” für die eigene ASP.NET WebApp"
date: 2012-04-02 23:46
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, OAuth, Twitter]
---
<p>“Sign in with Twitter” ist eine beliebte Methode um Benutzer auf der eigenen Seite zu authentifizieren. Der Vorteil gegenüber einer eigenen Registrierung ist natürlich, dass die “Hemmschwelle” wesentlich geringer für den Nutzer ist. Allerdings rückt Twitter auch nicht alle Daten raus und man ist in einer gewissen Abhängigkeit. Am Ende muss jeder selbst entscheiden, ob er das machen möchte oder nicht. <u>Die Frage hier allerdings lautet:</u> Wie kann ich den Twitter Login auf meiner Seite einbauen?</p>
<p>
<strong>Update (durch MVC4)</strong> <br/> In MVC4 wird das DotNetOpenAuth NuGet Package mit ausgeliefert. Das Package bietet eine einfache Möglichkeit sich bei Twitter anzumelden - natürlich kann das Package auch zu MVC3 Projekten hinzugefügt werden, allerdings ist es mir erst jetzt aufgefallen ;). Hier zum neuen <a href="http://code-inside.de/blog/2012/10/14/twitter-login-in-asp-net-mvc-4-ohne-membership-co-nutzen/">BlogPost</a>.
</p>
 <p><strong>Twitter Login – OAuth</strong></p> <p>Als Grundlage dient das <a href="http://oauth.net/">OAuth Protokoll</a> für die Authentifzierung. Hierbei erfährt die Applikation (unsere WebApp) nur bestimmte Daten, nicht aber z.B. das sensible Passwort. Mehr Hintergründe dazu gibt es <a href="http://oauth.net/">hier zum Nachlesen</a>.</p> <p><strong>TweetSharp – in 10 Minuten zum Twitter Login</strong></p> <p>Das OAuth Protokoll ist allerdings etwas “komplex”. Es gibt auch eine große Bibliothek im .NET Umfeld die sowohl OAuth als auch OpenID versteht: <a href="http://www.dotnetopenauth.net/">DotNetOpenAuth</a>. Allerdings ist diese Bibliothek recht komplex und mächtig. <u>Daher meine Empfehlung:</u> <a href="https://github.com/danielcrenna/tweetsharp"><strong>TweetSharp</strong></a>!</p>  <p><strong>Schritt 1: Per NuGet holen</strong></p> <p>Natürlich ist TweetSharp auch als <a href="http://nuget.org/packages/TweetSharp">NuGet Package</a> installierbar:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1490.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb661.png" width="489" height="337"></a></p> <p><strong>Schritt 2: Twitter App registrieren</strong></p> <p>Über die <a href="https://dev.twitter.com/apps/new"><strong>Developer Seite von Twitter</strong></a> kann man neue Apps einrichten. Für unsere Dev-Variante reichen die nachfolgenden Daten aus.</p> <p><strong>Wichtig:</strong> Im Feld WebSite und Callback URL dasselbe eintragen – ansonsten gab es bei mir immer Probleme. Wir nehmen einfach 127.0.0.1 – localhost. Bei der späteren Applikation das entsprechend auf die richtige URL anpassen.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1491.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb662.png" width="500" height="328"></a></p> <p>Wichtigste Daten folgen nun:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1492.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb663.png" width="508" height="500"></a></p> <p>Sowohl den Consumer Key als auch den Consumer Secret benötigen wir gleich.</p> <p><strong>Anmerkung:</strong> Über das Access level kann man verschiedene “Berechtigungen” setzen. So kann man momentan nur lesend die Tweets abgreifen, aber z.B. kann die Applikation selbst keine Tweets absetzen. Hierbei dient unsere Twitter App also nur zur “Authentifzierung” – nicht mehr, aber auch nicht weniger. Dies sieht der Nutzer auch bei der Login-Seite.</p> <p><strong>Schritt 3: Auth Controller</strong></p> <p>Der Code vom Auth Controller stammt aus der <a href="https://github.com/danielcrenna/tweetsharp"><strong>Doku von TweetSharp</strong></a>, welchen ich nur leicht modifziert habe.</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2b567739-876a-4adb-8fca-1f0c6dbcdad2" class="wlWriterEditableSmartContent"><pre name="code" class="js">using System;
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
}
</pre></div>
<p>&nbsp;</p>
<p>Zwischen Step 1 und Step 2 erstellen wir die eigentliche Callback-URL. In dem Callback nutzen wir die FormsAuthentication und setzen unser Cookie, sodass nun auch die ASP.NET Engine weiß, dass wir eingeloggt sind.</p>
<p><strong>Schritt 4: UI Anpassungen</strong></p>
<p>In der _Layout.cshtml</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:92d652f4-162f-4ef5-b462-ff2b9c9f78ee" class="wlWriterEditableSmartContent"><pre name="code" class="c#">            &lt;div id="title"&gt;
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
            &lt;/div&gt;</pre></div>
<p>&nbsp;</p>
<p>Entweder der Benutzer ist angemeldet über die FormsAuthentication, oder wir zeigen den Link zur Authorize Methode an.</p>
<p><strong>Ergebnis:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1493.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb664.png" width="244" height="145"></a></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1494.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb665.png" width="377" height="251"></a></p>









<p><a href="{{BASE_PATH}}/assets/wp-images/image1495.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb666.png" width="228" height="121"></a></p>
<p>Zusätzlich können wir noch auf diverse Twitter Eigenschaften des Nutzers zugreifen. Dies soweit zur Authentifzierung. Recht schnell gemacht eigentlich. Wer mehr machen möchte, z.B. Tweets verschicken, muss sich in dem Callback die AccessToken merken. </p>
<p>Bei meinem Projekt <a href="http://www.knowyourstack.com/">KnowYourStack.com</a> nutze ich eine “Bastelversion” über das DotNetOpenId Projekt – es funktioniert im Prinzip ähnlich. Ist aber komplexer und daher würde ich bei dieser einfachen Sache wirklich TweetSharp empfehlen.
</p>
