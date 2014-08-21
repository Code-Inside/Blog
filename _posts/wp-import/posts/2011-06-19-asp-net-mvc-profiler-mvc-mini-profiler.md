---
layout: post
title: "ASP.NET MVC Profiler “mvc-mini-profiler”"
date: 2011-06-19 23:20
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET MVC, Glimpse, NuGet, Stackoverflow]
---
{% include JB/setup %}
<p>Die Performance einer Webanwendung ist für den Benutzer ein entscheidendes Feature. Um Performance-Schwachstellen zu finden kann man verschiedene Varianten nutzen. So kann man zum Beispiel über Log-Messages vielleicht dahinter kommen oder man nutzt einen Profiler. Das Stackoverflow Team hat einen sehr “entwicklerlastigen” (aber auch sehr coolen) Profiler entwickelt und als <a href="http://code.google.com/p/mvc-mini-profiler/">Open Source zur Verfügung gestellt</a>.</p> <p><strong>Was kann dieser Profiler?</strong></p> <p>Anderes als z.B. der <a href="http://www.jetbrains.com/profiler/">Profiler “dotTrace”</a> von den Jetbrains Jungs muss man beim Mvc-Mini-Profiler Codefragmente einbauen. Diese sollten allerdings kein Problem für den Live-Betrieb darstellen. Man kann selbst bestimmen, was und in welchem Umfang gemessen werden soll.</p> <p><strong>Wie sieht der Mvc Mini Profiler aus:</strong></p> <p>Sobald man den Profiler aktiviert, wird im Standardfall nur die Zeit bis zum fertigen Rendering ausgegeben:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1278.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb460.png" width="244" height="109"></a></p> <p>Je nach “Einstellung” kann man die entsprechenden Schritte genauer nachverfolgen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1279.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb461.png" width="431" height="185"></a></p> <p><strong>Database-Profiling:</strong></p> <p>Der Mvc Mini Profiler kann sich auch an die DbConnection hängen, d.h. man kann genau rausbekommen wie lange welche SQL Abfrage braucht. Durch die Nutzung der DbConnection kann natürlich auch Linq2Sql oder Entity Framework Abfragen mitgeloggt werden.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1280.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb462.png" width="567" height="255"></a></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1281.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb463.png" width="577" height="281"></a></p> <p><strong>Welche Änderungen am Code muss ich durchführen?</strong></p> <p>Der volle <a href="http://code.google.com/p/mvc-mini-profiler/">Feature-Umfang ist hier gut</a> beschrieben, wobei nach der Installation des NuGet Package “MiniProfiler” muss man nur wenige Dinge tun, um es in Gang zu setzen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1282.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb464.png" width="436" height="242"></a></p> <p>In der Global.ascx:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1d5e098d-1dbc-483a-8bb7-a92259953b25" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        protected void Application_BeginRequest()
        {
            if (Request.IsLocal)
            {
                MiniProfiler.Start();
            }
        }

        protected void Application_EndRequest()
        {
            MiniProfiler.Stop();
        }</pre></div>
<p>&nbsp;</p>
<p>In der Masterpage die CSS/Scripts verlinken – allerdings wird jQuery vorausgesetzt – d.h. jQuery sollte vorher referenziert sein.:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b17cac14-8099-40ca-93ec-b434bf65ea12" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;head&gt;
    &lt;meta charset="utf-8" /&gt;
    &lt;title&gt;@ViewBag.Title&lt;/title&gt;
    ...
    @MvcMiniProfiler.MiniProfiler.RenderIncludes()
&lt;/head&gt;</pre></div>
<p>&nbsp;</p>
<p>Im Controller kann es dann so aussehen:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:beb97ef4-10b5-4436-8fe7-8646073b6ac5" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public ActionResult About()
        {
            var profiler = MiniProfiler.Current; // it's ok if this is null

            using (profiler.Step("Set page title"))
            {
                ViewBag.Title = "Home Page";
            }

            using (profiler.Step("Doing complex stuff"))
            {
                using (profiler.Step("Step A"))
                { // something more interesting here
                    Thread.Sleep(100);
                }
                using (profiler.Step("Step B"))
                { // and here
                    Thread.Sleep(250);
                }
            }</pre></div>
<p>&nbsp;</p>
<p>Ergebnis davon:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1283.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb465.png" width="402" height="137"></a></p>
<p>Nett, oder?</p>
<p><strong>Wie verträgt es sich z.B. mit Glimpse?</strong></p>
<p><a href="{{BASE_PATH}}/2011/04/14/glimpse-web-debugging-firebug-fr-die-serverseite/">Glimpse</a> hatte ich bereits an einer anderen Stelle vorgestellt – für die, die es nicht kennen: es ist wie <a href="{{BASE_PATH}}/2011/04/14/glimpse-web-debugging-firebug-fr-die-serverseite/">Firebug für die Serverseite</a>. </p>
<p>Sowohl Glimpse als auch der Mini Mvc Profiler vertragen sich auf den ersten Blick gut – beide Tools in Kombination sind vermutlich sehr elegant um wirklich genau zu wissen, was genau auf dem Server passiert.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1284.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb466.png" width="541" height="217"></a></p>
<p><strong>Ausprobieren…</strong></p>
<p>Am besten über das NuGet Package “MiniProfiler” beziehen und loslegen <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-smile.png"></p>
