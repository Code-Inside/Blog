---
layout: post
title: "HowTo: Senden von Emails testen mit Smtp4Dev"
date: 2010-07-18 14:07
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [Email, HowTo, SMTP, Smtp4Dev, Tools]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1003.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb187.png" width="193" height="142" /></a> </p>  <p>Vor einer ganzen Weile habe ich bereits <a href="{{BASE_PATH}}/2009/03/16/howto-senden-von-emails-testen-ohne-mailserver/">darüber gebloggt</a>, wie man das Email-Senden ohne einen richtigen SMTP Server auf seinem Entwickler PC testen kann. Über diverse Blogposts, z.B. dem <a href="http://blog.alexonasp.net/post/2010/07/14/smtp4dev-e28093-Dummy-Mailserver-fur-Entwickler.aspx">hier von Alex</a>, bin ich auf <a href="http://smtp4dev.codeplex.com/">Smtp4Dev</a> gestoßen. Fazit: Funktioniert gut &amp; ungemein praktisch.</p>  <p><strong>Smtp4Dev</strong></p>  <p>Smtp4Dev ist ein kleines Tool, welches in der System Tray läuft und auf Port 25 lauscht. Wenn eine Mail eingeht, kommt auch ein kleine Info-Box:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1004.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb188.png" width="220" height="114" /></a> </p>  <p>Es gibt auch eine Übersicht mit allen eingegangen Mails:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1005.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb189.png" width="383" height="280" /></a> </p>  <p>Über "View” wird das Standard-Email Programm gestartet. Über "Inspect” kann man Details der Mail anschauen:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1006.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb190.png" width="489" height="228" /></a> </p>  <p><strong>Was müsst ihr tun, damit es funktioniert?</strong></p>  <ul>   <li><a href="http://smtp4dev.codeplex.com/">Smtp4Dev</a> downloaden &amp; installieren</li>    <li>Sichergehen dass das Tool auch auf Port 25 lauscht:<a href="{{BASE_PATH}}/assets/wp-images-de/image1007.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb191.png" width="390" height="289" /></a> </li>    <li>In der web.config die Smtp Settings auf Network &amp; Localhost setzen:</li> </ul>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3b9511a3-ef1c-449c-9f89-58daafbd63cc" class="wlWriterEditableSmartContent"><pre name="code" class="c#">	&lt;system.net&gt;
    &lt;mailSettings&gt;
      &lt;smtp deliveryMethod="Network"&gt;
        &lt;network host="localhost"/&gt;
      &lt;/smtp&gt;
    &lt;/mailSettings&gt;
	&lt;/system.net&gt;</pre></div>

<p>Mein Beispielcode stammt noch <a href="{{BASE_PATH}}/2009/03/16/howto-senden-von-emails-testen-ohne-mailserver/">aus dem alten Blogpost</a>, nur mit der Änderung in der web.config (&amp; das ich es mit VS2010 bearbeitet habe)</p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/testingemailswithsmtp4dev/testingemailswithsmtp4dev.zip">[ Download Democode ]</a></strong></p>
