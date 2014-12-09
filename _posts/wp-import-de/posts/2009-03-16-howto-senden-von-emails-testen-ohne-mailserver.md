---
layout: post
title: "HowTo: Senden von Emails testen ohne Mailserver"
date: 2009-03-16 22:11
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Email, HowTo, SMTP, Tests]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image675.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="113" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb653.png" width="111" align="left" border="0" /></a>Emails mit .NET zu versenden ist recht einfach, wenn es allerdings darum geht, den generierten Emailtext zu testen, dann wird es manchmal etwas schwierig.     <br />Vor allem wenn das Entwicklungssystem keinen Zugriff auf den richtigen Email-Server hat, geht es meist nur auf &quot;gut Gl&#252;ck&quot;.    <br />Es gibt allerdings einen einfachen Web.Config Eintrag der es erheblich vereinfacht - die <a href="http://msdn.microsoft.com/en-us/library/system.net.mail.smtpclient.pickupdirectorylocation.aspx">PickupDirectoryLocation</a>.</p> 
<!--more-->
  <p><strong>Democode</strong></p>  <p>Der Code zum verschicken einer Mail (in einer ASP.NET MVC ActionMethod) :</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b3619f40-712e-4a45-9d61-cf439f127b51" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public ActionResult SendMail()
        {
            SmtpClient smtpClient = new SmtpClient();
            MailMessage mailMessage = new MailMessage("from@test.de", "to@test.de");
            mailMessage.Subject = "Test-Subject";
            mailMessage.Body = "Test-Body";
            smtpClient.Send(mailMessage);

            return View("Index");
        }</pre></div>

<p>In der web.config folgende Einstellung:
  <br /><strong>Produktivsystem</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6be1f35f-e9ad-4fb3-9ea0-0a84f63ccd5f" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">  &lt;system.net&gt;
    &lt;mailSettings&gt;
      &lt;smtp&gt;
        &lt;network host="mail.example.com"/&gt;
      &lt;/smtp&gt;
    &lt;/mailSettings&gt;
  &lt;/system.net&gt;</pre></div>

<p><strong>Entwicklungssystem</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2a307ade-d6ac-40f2-a31b-4cf697f1f915" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">  &lt;system.net&gt;
    &lt;mailSettings&gt;
      &lt;smtp deliveryMethod="SpecifiedPickupDirectory"&gt;
        &lt;specifiedPickupDirectory pickupDirectoryLocation="c:\temp\maildrop\"/&gt;
      &lt;/smtp&gt;
    &lt;/mailSettings&gt;
  &lt;/system.net&gt;</pre></div>

<p>Die &quot;PickupDirectoryLocation&quot; nimmt allerdings nur einen absoluten Pfad entgegen. Wenn man nun den Code aufruft, dann werden die Emails in den angegebenen Verzeichnis abgelegt:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image676.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="55" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb654.png" width="457" border="0" /></a> </p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3ec0c126-08a7-4ec2-9aa4-821f6c406b2b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">X-Sender: from@test.de
X-Receiver: to@test.de
MIME-Version: 1.0
From: from@test.de
To: to@test.de
Date: 16 Mar 2009 20:52:55 +0100
Subject: Test-Subject
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Test-Body
</pre></div>

<p>Damit l&#228;sst sich die Emailgenerierung auch ohne SMTP Server testen.
  <br />Den Tipp habe ich von <a href="http://blog.donnfelker.com/post/Sending-Email-in-a-Development-Environment-without-an-SMTP-Server.aspx">dieser Seite</a> - da ich ihn st&#228;ndig wieder Suche, habe ich ihn jetzt ebenfalls auch gebloggt ;)</p>

<p>Wichtig ist noch, dass ASP.NET Schreibrechte auf dem Verzeichnis hat.</p>

<p><strong>[<a href="{{BASE_PATH}}/assets/files/democode/testingemails/testingemails.zip">Download Democode</a>]</strong></p>
