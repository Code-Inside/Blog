---
layout: post
title: "HowTo: OpenID Authentifizierung und ASP.NET MVC"
date: 2010-01-04 00:24
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Authentication, HowTo, MVC, OAuth, OpenID]
---
<p></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image884.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="111" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb69.png" width="119" align="left" border="0"></a> OpenID ist ein sehr praktisches Authentifizierungssystem, was sich auch immer weiter verbreitet. Google, Yahoo, AOL und vielleicht in naher Zukunft sogar Microsoft unterstützen es. Die ersten Gehversuche mit OpenID &amp; MVC sind dank der tollen <a href="http://www.ohloh.net/p/dotnetopenauth">dotnetopenauth</a> auch sehr schnell erledigt. </p><!--more--> <p><strong>OpenID?</strong></p> <p>Genaue OpenID Details findet ihr auf der <a href="http://openid.net/">offiziellen Webseite</a>. Es geht darum, dass man nicht auf jeder Seite sich neu registrieren muss, sondern z.B. sein AOL oder Google Konto als Authentifizierung nutzen kann. Mich als ehrlichen Seitenbetreiber interessiert eigentlich auch nicht das Passwort der Leute - im schlimmsten Fall könnte es bei einem Hack ausgelesen werden und ich (als Seitenbetreiber) sowie die Nutzer hätten ein ernstes Problem. Das sind nur ein paar Gedanken, warum es sich lohnt sich OpenID genauer anzuschauen.</p> <p><strong>Praxisbeispiel: </strong><a href="http://stackoverflow.com/">Stackoverflow.com</a></p> <p>Bei Stackoverflow kann man sich nur mit OpenID authentifizieren. Viele Leute besitzen bereits ein Yahoo oder Google Account, somit kann man sich mit wenigen Klicks einfach einloggen. </p> <p><strong>Auf gehts...</strong></p> <p>Wir benötigen eigentlich die <a href="http://www.ohloh.net/p/dotnetopenauth">DotNetOpenAuth</a> Bibliothek und dies in einem Controller:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:517569da-cdf2-4643-b7a4-4c85d64b939e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public ActionResult OpenID()
        {
            ViewData["message"] = "You are not logged in";
            var openid = new OpenIdRelyingParty();

            IAuthenticationResponse response = openid.GetResponse();
            if (response != null &amp;&amp; response.Status == AuthenticationStatus.Authenticated)
                ViewData["message"] = "Success! Identifier: " + response.ClaimedIdentifier;

            return View("OpenID");
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult OpenID(string openid_identifier)
        {
            var openid = new OpenIdRelyingParty();
            IAuthenticationRequest request = openid.CreateRequest(Identifier.Parse(openid_identifier));

            return request.RedirectingResponse.AsActionResult();
        }</pre></div>
<p>Mit einem <a href="http://jvance.com/pages/JQueryOpenIDPlugin.xhtml">jQuery Plugin</a> sieht der View so aus:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image885.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="195" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb70.png" width="513" border="0"></a> </p>
<p><strong>Funktionsweise:</strong></p>
<p>Der Nutzer klickt auf eien der Buttons (z.B. wenn er einen Google/Yahoo/Flickr/Blogger/AOL...) Account hat oder Tipp in das Feld seinen eigenen OpenID Anbieter ein (man kann einen eigenen OpenID Server stellen). Die Buttons sind also nur Shortcuts. </p>
<p>Man klickt z.B. auf Yahoo und es wird die POST "OpenID" Action ausgelöst. Diese liest den Identifier (im Fall von Yahoo: <a title="http://yahoo.com/" href="http://yahoo.com/">http://yahoo.com/</a>) aus und leitet dann an die entsprechende Loginseite weiter:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image886.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="290" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb71.png" width="332" border="0"></a> </p>
<p>Meldet man sich nun dort erfolgreich an oder man ist bereits angemeldet, so wird man automatisch wieder zurück auf die Ursprungsadresse umgeleitet - also geht es wieder in die andere "OpenID" Action wieder rein und dort sind die 3 Zeilen interessant:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:97cbd9e4-8ec3-481a-8f54-af04e3bee256" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            IAuthenticationResponse response = openid.GetResponse();
            if (response != null &amp;&amp; response.Status == AuthenticationStatus.Authenticated)
                ViewData["message"] = "Success! Identifier: " + response.ClaimedIdentifier;</pre></div>
<p>So einfach ist es. Der "ClaimedIdentifier" ist für jede Seite eine andere ID.</p>
<p>Den Code und wie es eigentlich funktioniert, habe ich mir von diesem <a href="http://codeharder.com/post/Aspnet-MVC-and-OpenID-Support.aspx">Blogpost</a> abgeschaut. Der Autor des Blogs probiert zudem gerade ein <a href="http://codeharder.com/category/stackoverclone.aspx">Clone von Stackoverflow</a> zu bauen :)</p>
<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/openid/openid.zip">[ Download Democode ]</a></strong></p>
