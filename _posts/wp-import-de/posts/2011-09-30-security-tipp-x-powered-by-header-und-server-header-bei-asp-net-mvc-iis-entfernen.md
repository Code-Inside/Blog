---
layout: post
title: "Security-Tipp: X-Powered-By Header und Server Header bei ASP.NET MVC & IIS entfernen"
date: 2011-09-30 23:46
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, IIS, MVC3, Security]
language: de
---
{% include JB/setup %}
<p>Angreifern sollte man möglichst wenig Informationen an die Hand geben. Standardmäßig ist aber eine ASP.NET MVC Website auf einem IIS schon ein klein wenig gesprächig. </p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1359.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 5px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb541.png" width="244" height="136"></a></p> <p>In jeder Response wird (solange nichts anderes im IIS eingestellt wurde), die IIS Version mitgesendet. Auch die ASP.NET MVC und ASP.NET Version ist in der Response enthalten wenn die ASP.NET Pipeline berührt wurde.</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p><strong>Was ist an den Standard-Headern so schlecht?</strong></p> <p>Es gibt Szenarien, da macht das durchaus Sinn die Herkunft der Webantwort zu verschleiern, auch wenn die Default-Werte “recht grob” sind. Problematisch wird es, wenn direkt für die ASP.NET Version 4.0.30319 eine Sicherheitslücke auftaucht. Daher die Idee, alles nicht benötigte abzuschalten. Netter Nebeneffekt: Man spart noch ein paar Byte ein.</p> <p>Herangehensweise: Vermutlich kann man einige Optionen auch direkt im IIS setzen, ich habe allerdings gern diese “Einstellungen” in meiner Applikation, sodass ich keinem Admin noch ein Handbuch hinterher werfen muss.</p> <p><strong><u>ASP.NET MVC Header deaktivieren</u></strong></p> <p>Der ASP.NET MVC Header kann in der Global.asax mit “MvcHandler.DisableMvcResponseHeader” deaktiviert werden:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5197ea68-114a-4aca-bdb6-17efffe30c0e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        protected void Application_Start()
        {
            MvcHandler.DisableMvcResponseHeader = true;

            AreaRegistration.RegisterAllAreas();

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }</pre></div>
<p>&nbsp;</p>
<p><strong><u>ASP.NETA Version Header deaktivieren</u></strong></p>
<p>Wichtig hier ist, dass die Anwendung im IIS (unter den AppPools) als Integrated Pipeline bzw. während der Entwicklung mindestens auf IIS Express läuft:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1360.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb542.png" width="240" height="160"></a></p>
<p>Diese Einstellungen in der Web.config haben bei mir jeddenfalls das gewünschte Ergebnis erzielt:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ed2698b2-0d5b-4525-a0ae-b06a5f9b383c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0"?&gt;
&lt;configuration&gt;

  &lt;system.web&gt;
    &lt;httpRuntime enableVersionHeader="false" /&gt;
    ...
  &lt;/system.web&gt;

  &lt;system.webServer&gt;
    ...
    &lt;httpProtocol&gt;
      &lt;customHeaders&gt;
        &lt;remove name="X-Powered-By" /&gt;
      &lt;/customHeaders&gt;
    &lt;/httpProtocol&gt;
  &lt;/system.webServer&gt;

 ...
&lt;/configuration&gt;
</pre></div>

<p><strong><u>Server Response Header entfernen</u></strong></p>
<p>Dieses Flag ist am “schwierigsten” zu entfernen und benötigt ein HttpModule, welches diesen Header entweder entfernt oder manipuliert:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6002cdd0-3f12-40dd-89c9-e8e338e16c85" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public class RemoveServerHeaderModule : IHttpModule
    {
        public void Init(HttpApplication context)
        {
            context.PreSendRequestHeaders += OnPreSendRequestHeaders;
        }

        public void Dispose()
        { }

        void OnPreSendRequestHeaders(object sender, EventArgs e)
        {
            HttpContext.Current.Response.Headers.Remove("Server");
        }
    }</pre></div>
<p>&nbsp;</p>
<p>Registrierung in der Web.config:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ac507752-f641-40f7-8e58-00bb6f4823d4" class="wlWriterEditableSmartContent"><pre name="code" class="c">&lt;?xml version="1.0"?&gt;
&lt;configuration&gt;
  ...
  &lt;system.webServer&gt;
    &lt;validation validateIntegratedModeConfiguration="false"/&gt;
    &lt;modules runAllManagedModulesForAllRequests="true"&gt;
      &lt;add name="RemoveServerHeaderModule" type="SecurityTipp.RemoveServerHeaderModule"/&gt;
    &lt;/modules&gt;
	...
  &lt;/system.webServer&gt;

&lt;/configuration&gt;
</pre></div>
<p>&nbsp;</p>
<p><strong>Quellen</strong></p>
<p>Wie immer dank an <a href="http://serverfault.com/questions/24885/how-to-remove-iis-asp-net-response-headers">Stackoverflow</a> und diesem <a href="http://www.4guysfromrolla.com/articles/120209-1.aspx">Link</a>.</p>
<p><strong><a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2FSecurityTipp">[ Code auf Google Code ]</a></strong></p>
