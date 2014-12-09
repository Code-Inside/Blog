---
layout: post
title: "Wie und warum ändert sich das Forms Auth Cookie?"
date: 2011-08-17 00:13
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET, Auth, Authentication, Cookie, Forms]
language: de
---
{% include JB/setup %}
<p>Die Forms-Authentication ist die low-Level-Form der “Authentifizierung”. Ein Forms-Authentication Cookie zu setzen geht z.B. wie folgt:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cbecc054-3535-46f0-aee0-04e1160e28c2" class="wlWriterEditableSmartContent"><pre name="code" class="c#">
        public ActionResult SetAuthCookie()
        {
            FormsAuthentication.SetAuthCookie(Guid.NewGuid().ToString(), false);
            return RedirectToAction("Index");
        }</pre></div>
<p>&nbsp;</p>
<p>Kern der Sache ist die <a href="http://msdn.microsoft.com/en-us/library/k3fc21xw.aspx">FormsAuthentication Klasse</a>. Ein sehr guten Einblick darüber, wie Forms Auth funktioniert gibt es in diesem <a href="http://msdn.microsoft.com/en-us/library/ff647070.aspx">MSDN Artikel</a>. Der FormsAuthentication Mechanismus ist recht “tief” ins Framework integriert, jedenfalls sind die HttpModule in der Machine.config, daher muss man nur noch die Konfiguration in der Web.config vornehmen, z.B.:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7db1edd1-4568-4b53-bc0f-4721b11c7a7f" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    &lt;authentication mode="Forms"&gt;
      &lt;forms loginUrl="~/Account/LogOn" timeout="2" /&gt;
    &lt;/authentication&gt;</pre></div>
<p>&nbsp;</p>
<p>(Ich habe das Timeout auf 2 Minuten gesetzt um die Demo besser zu zeigen ;) ).</p>
<p>Beim “Verscripten” einer Webanwendung hatte ein Kollege von mir ein Problem bekomme, da ab einer bestimmten Zeit immer die Anmeldemaske ihm wieder zurückgeliefert wurde, obwohl das eingestellte Timeout noch nicht erreicht war und er die ganze Zeit (mit seinem Script) auf der Website aktiv war. Wie kommt das?</p>
<p><strong>Ausgangslage:</strong></p>
<p>Wir haben von der Loginseite das FormsAuth Cookie ausgestellt bekommen und senden dies natürlich auch immer wieder im Request mit, sodass das “Forms-Auth-Ticket” aktiv bleibt:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1337.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb519.png" width="542" height="107"></a></p>
<p>Die Komponente die dafür sorgt, dass das Forms-Auth-Ticket bei Aktivität verlängert wird, wird über das Property “<a href="http://msdn.microsoft.com/en-us/library/system.web.security.formsauthentication.slidingexpiration.aspx">SlidingExpiration</a>” (was per Default auf true ist) gesteuert.</p>
<p><strong>RTFM…</strong></p>
<p> Warum wurde nun das Script von dem Kollegen die Anmeldemaske wieder gezeigt? Die Antwort liefert auch die MSDN:</p>
<p><em>Sliding expiration resets the expiration time for a valid authentication cookie if a request is made and more than half of the timeout interval has elapsed. If the cookie expires, the user must re-authenticate. Setting theSlidingExpiration property to false can improve the security of an application by limiting the time for which an authentication cookie is valid, based on the configured timeout value.</em></p>
<p><strong>D.h.</strong></p>
<p>Nach rund der Hälfte der Timeout Zeit, wird ein neues Cookie generiert:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1338.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb520.png" width="556" height="255"></a></p>
<p>Sprich, wenn das Timeout 10 Minuten beträgt, dann wird in der 5-6 Minute (wenn ein neuer Request in der Zeit abgesetzt wird) ein neues Cookie erstellt.</p>
<p>Jetzt klappts auch mit dem Scripting ;)</p>
<p>PS: Natürlich passiert dieser Prozess nur, wenn Sliding Expiration auch auf den Standardwert bleibt.</p>
