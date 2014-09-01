---
layout: post
title: "HowTo: Ein HttpModule zum Redirecten nutzen"
date: 2009-10-14 21:35
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Http, HttpModule, Module]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image846.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="57" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb31.png" width="207" align="left" border="0"></a>Folgende Aufgabe: Wenn eine bestimmte Seite im Portal aufgerufen wird, soll der Nutzer auf Seite X umgeleitet werden. Lösungsansatz: HttpModule.</p><p><strong>Eigentlich ganz einfach... das HttModule:</strong></p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f57bd7c2-b126-437f-a3dd-875711052742" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class Redirect : IHttpModule
{
    public void Dispose()
    {
    }

    public void Init(HttpApplication context)
    {
        context.BeginRequest += new System.EventHandler(context_BeginRequest);
    }

    void context_BeginRequest(object sender, System.EventArgs e)
    {
        if(HttpContext.Current.Request.Url.LocalPath.ToLower() == "/google")
        {
            HttpContext.Current.Response.Redirect("http://google.de");
        }
    }</pre></div>
<p>Wir machen ein HttpModule indem wir <a href="http://msdn.microsoft.com/de-de/library/system.web.ihttpmodule.aspx">IHttpModule</a> implementieren. </p>
<p><strong>Wichtig hierbei:</strong> "Init" wird beim initialisieren des HttpModules aufgerufen, z.B. wenn beim Applikationsstart. Damit wir ständig bescheid wissen, auf welcher Seite der Nutzer ist, müssen wir ein <strong>Eventhandler</strong> definieren! </p>
<p>Dieser springt bei mir bei jeden Request an.</p>
<p><strong>Und redirecten...</strong></p>
<p>Jetzt prüfe ich über den <a href="http://msdn.microsoft.com/en-us/library/system.web.httpcontext.aspx">HttpContext</a> wo wir uns befinden und wenn wir in der Url z.B. "localhost/google" eingeben, werden wir zu Google weitergeleitet. </p>
<p><strong>Das ganze noch registrieren</strong></p>
<p>Nun müssen wir das noch in der Web.config registrieren (unter httpmodule), z.B. so:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a41fd083-9795-4926-a2a9-1db1f70d016a" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">      &lt;add name="Redirect" type="Redirect, RedirectModul, Version=1.0.0.0, Culture=neutral"/&gt;
</pre></div>
<p>Beschreibung dazu <a href="{{BASE_PATH}}/2009/10/04/howto-full-qualified-type-name-klassentypnamen-richtig-schreiben/">hier</a>.</p>
<p>Eigentlich total easy. Die Geschichte mit dem Eventhandler muss man allerdings wissen ;)</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/redirectmodul/redirectmodul.zip">[ Download Democode ]</a></strong></p>
