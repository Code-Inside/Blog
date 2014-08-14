---
layout: post
title: "HowTo: Health Monitoring mit ASP.NET"
date: 2009-03-17 23:15
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, Health Monitoring, HowTo]
---
<p><a href="{{BASE_PATH}}/assets/wp-images/image677.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="125" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb655.png" width="164" align="left" border="0" /></a>Die Arbeit ist getan, die Website steht! Doch damit fangen die n&#228;chsten Probleme an. Kunden rufen an und sagen einem, dass sie eine Error-Page gesehen haben - also mal auf den Server schauen was da eigentlich los ist.    <br />Mit diversen Logging Tools kann man sich &#252;ber bestimmte Ereignisse informieren lassen - seit ASP.NET 2.0 gibt es auch einen eingebautes <a href="http://msdn.microsoft.com/en-us/library/2fwh2ss9.aspx">Health-Monitoring</a>, dass man sehr einfach nutzen kann. </p> 
<!--more-->
  <p><strong>Eine einfache Konfigurationseinstellung     <br /></strong>In meiner <a href="http://www.asp.net/mvc">ASP.NET MVC Anwendung</a> werfe ich einfach bei einer ActionMethode bewusst eine Exception:</p>  <p>   <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:bef2c343-dba5-4bd5-bae1-e581fae9ef86" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public ActionResult ThrowException()
        {
            throw new NotImplementedException("Message \\o/");
            return View();
        }</pre></div>
</p>

<p>Das Health-Monitoring l&#228;sst sich einfach in der Web.config einstellen. Wir wollen in unserem Beispiel per Email &#252;ber die Exception benachrichtigt werden.</p>

<p><strong>Als erstes Mailsettings:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:157670ae-5b04-4e2e-b9c9-b8c653317331" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;system.net&gt;
&lt;mailSettings&gt;
&lt;smtp deliveryMethod="Network" from="your.email@company"&gt;
      &lt;network host="your.smtp.host" port="25"/&gt;
&lt;/smtp&gt;
&lt;/mailSettings&gt;
&lt;/system.net&gt;</pre></div>

<p>Zum Testen kann man auch einen <a href="http://code-inside.de/blog/2009/03/16/howto-senden-von-emails-testen-ohne-mailserver/">anderen ASP.NET Trick anwenden</a> - damit braucht man keinen SMTP Server.</p>

<p><strong>Healthmonitoring:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:821dc70f-fad3-44a6-8344-d42a8fb368f3" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;healthMonitoringenabled="true"&gt;
                  &lt;eventMappings&gt;
                        &lt;clear/&gt;
                        &lt;add name="All Errors"
             type="System.Web.Management.WebBaseErrorEvent, System.Web,Version=2.0.0.0,Culture=neutral,PublicKeyToken=b03f5f7f11d50a3a"
             startEventCode="0"
             endEventCode="2147483647"/&gt;       
                  &lt;/eventMappings&gt;
                  &lt;providers&gt;
                        &lt;clear/&gt;
                        &lt;add name="EmailErrorProvider"
             type="System.Web.Management.SimpleMailWebEventProvider"
             to="malcolm.x.sheridan@nab.com.au"
             from="someone@contoso.com"
             buffer="false"
             subjectPrefix="An error has occured."
             bodyHeader="This email is generated from my application." /&gt;
                  &lt;/providers&gt;
                  &lt;rules&gt;
                        &lt;clear/&gt;                     
                        &lt;add name="Testing Mail Event Providers"
             eventName="All Errors"
             provider="EmailErrorProvider"
             profile="Default"
             minInstances="1"
             maxLimit="Infinite"
             minInterval="00:01:00"
             custom=""/&gt;       
                  &lt;/rules&gt;
            &lt;/healthMonitoring&gt; </pre></div>

<p><strong>Kurze Erkl&#228;rung:
    <br /></strong>Als wichtigster Part registrieren wir uns auf ein Event und nutzen den SimpleMailWebEventProvider -der einfach eine Mail verschickt. Eine genauere Erkl&#228;rung der einzelnen Teile findet sich in diesem <a href="http://blog.andreloker.de/post/2009/03/12/Re-Health-Monitoring-in-ASPNET-35.aspx">Blogpost</a> oder auf der <a href="http://msdn.microsoft.com/en-us/library/2fwh2ss9.aspx">MSDN</a> Seite.</p>

<p><strong>Ergebnis:</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image678.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="285" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb656.png" width="434" border="0" /></a> </p>

<p>Im Text-Editor kann man allerdings die Mail nicht &#246;ffnen, da der Inhalt Base64 kodiert ist.
  <br />Man kann auch eigene Provider schreiben und sich auf beliebig viele Events registrieren und die tollsten Sachen damit machen - wer allerdings nur kurz per Mail informiert werden m&#246;chte, f&#252;r den ist das eigentlich Ideal :)</p>

<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/asphealthmonitoring/asphealthmonitoring.zip">[Download Demoanwendung]</a></strong> 

  <br /><em>(Achtung, Web.config f&#252;r PickupDirectoryLocation anpassen)
    </em></p>
