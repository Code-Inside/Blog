---
layout: post
title: "OWIN Präsentation auf der WebNetConf"
date: 2012-11-04 23:40
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [OWIN]
---
{% include JB/setup %}
<p>Mitte Oktober war ich in Mailand auf der <a href="http://webnetconf.eu/">WebNetConf</a> mit einem Vortrag über <a href="http://owin.org">OWIN</a> vertreten. Viele von euch denken jetzt: <strong>Was zur Hölle ist OWIN? </strong></p> <p>Und genau darum ging es auch in dem Talk ;)</p> <p>Grundzüge lassen sich auch in diesem Post nachlesen: <a href="{{BASE_PATH}}/2012/06/06/owin-um-was-geht-es-da-und-warum-ist-es-cool/">OWIN- um was geht es da und warum ist es cool?</a></p> <p><strong>Präsentation:</strong></p><script async class="speakerdeck-embed" data-id="5096e6a02fd11800020499f6" data-ratio="1.3333333333333333" src="//speakerdeck.com/assets/embed.js"></script> <p><strong>Anmerkungen:</strong></p> <p>Die Präsentation funktioniert natürlich nicht für sich selbst. Die meisten Sachen lassen sich am besten nachvollziehen wenn man sich mal <a href="http://owin.org/">Owin.org</a> anschaut und das <a href="http://katanaproject.codeplex.com/">Katanaproject</a>.</p> <p>Ich hatte 3 “Samples” gezeigt:</p> <p>- Eine komplett neues OWIN Projekt wie auf der <a href="http://katanaproject.codeplex.com/documentation">Katanaproject Seite</a> beschrieben.</p> <p>- Samples aus dem Katanaproject. Hierbei musste ich zum Teil Anpassungen machen, welche zum Teil jetzt auch schon behoben sind. Andere Samples wurden gar entfernt, da sie eher verwirren ;)</p> <p>- Self-Hosted OWIN mit Nancy und SignalR von <a href="https://github.com/loudej/owin-samples/tree/master/src/ConsoleNancySignalR">hier</a></p> <p>Hier mal mein kleiner Spicker, den ich auch während des Talks genutzt hatte, vielleicht für den einen oder anderen nützlich (im Zusammenhang mit der Präsentation)</p><pre>==============1. Sample ======================

Empty WebApp

Install-Package Microsoft.AspNet.Owin 
Install-Package Gate.Middleware 

web.config:
&lt;appsettings&gt;
  &lt;add value="true" key="owin:HandleAllRequests" /&gt;
  &lt;add value="true" key="owin:SetCurrentDirectory" /&gt;
&lt;/appsettings&gt;
&lt;system.webserver&gt;
  &lt;modules runallmanagedmodulesforallrequests="true" /&gt;
&lt;/system.webserver&gt;

Startup.cs:
using Gate.Middleware;
using Owin;

namespace ThisShouldMatchYourAssemblyName
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.UseShowExceptions();
            app.Run(new Wilson());
        }
    }
}


==&gt; Visual Studio F5
==&gt; Katana.exe (inside C:\Users\Robert\Desktop\WebNetConf\Samples\1_EmptyWebApp\EmptyWebApp\EmptyWebApp)


======== 2. Katana Samples ===========

Download at http://katanaproject.codeplex.com/SourceControl/changeset/view/486788fd7c3b

build.cmd

Fix for:
Build started 18.10.2012 22:03:35.
Project "C:\Users\Robert\Desktop\WebNetConf\Samples\2_Katana\src\Katana.Server.
AspNet.WebApplication\Katana.Server.AspNet.WebApplication.csproj" on node 1 (de
fault targets).
C:\Users\Robert\Desktop\WebNetConf\Samples\2_Katana\src\Katana.Server.AspNet.We
bApplication\Katana.Server.AspNet.WebApplication.csproj(154,3): error MSB4019:
The imported project "C:\Program Files (x86)\MSBuild\Microsoft\VisualStudio\v10
.0\WebApplications\Microsoft.WebApplication.targets" was not found. Confirm tha
t the path in the  declaration is correct, and that the file exists on
disk.
===&gt; v11.0 

VS as Admin!!!!!!

-&gt; Katana.Sample.HelloWorld =&gt; self hosted =&gt; F5

-&gt; Katana.Sample.Mvc4.WebApplication (only in VS) :/

    public class Startup
    {
        public void Configuration(IAppBuilder builder)
        {
            var configuration = new HttpConfiguration(new HttpRouteCollection(HttpRuntime.AppDomainAppVirtualPath));
            configuration.Routes.MapHttpRoute("Default", "{controller}");

            builder.UsePassiveValidator();
            builder.UseShowExceptions();
            builder.UseHttpServer(configuration);

            // DOES NOTHING :(
            //builder.Map("/wilson", new Wilson());
            // Routing inside RouteConfig.cs

            // NEEDED FOR ASP.NET MVC STUFF
            builder.Run(this);

        }
    }

            RouteTable.Routes.MapOwinRoute("/wilson", builder =&gt; builder
                .UseShowExceptions()
                .Run(Wilson.App()));


Fix for AspNet not firing:
Install Microsoft.AspNet.Owin X

-&gt; Katana.Sample.SelfhostWebSockets :/

-&gt; Katana.Server.AspNet.WebApplication (only VS / Katana with probs )

http://localhost:1932/TheApp/Hello/ =&gt; WebAPI (in Global.asax)

C:\Users\Robert\Desktop\WebNetConf\Samples\2_Katana\src\Katana.Server.AspNet.Web
Application&gt;katana --boot aspnet
builder.Properties are invalid
builder.Properties should contain "server.Name"
builder.Properties should contain "{server-name}.Version" where {server-name} is
 "server.Name" value

--&gt; Katana.Server.AspNet.WebSocketsApp (only vs)

======== 3. Console Nancy SignalR ===========
VS (self hosted katana)
http://localhost:8080/ =&gt; NancyFX
http://localhost:8080/signalr/hubs =&gt; JS from SignalR

</pre>
