---
layout: post
title: "Routen / Urls von Mvc Controllern zu WebApi Controllern und umgekehrt"
date: 2013-07-02 22:59
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [MVC, Routing, WebApi]
language: de
---
{% include JB/setup %}
<p>Mit der WebApi hat Microsoft ein neuen Weg geschaffen wie man REST Apis entwickeln kann. Da man meist keine “reine”-API hat sondern meist noch eine Website betreibt kommt man recht schnell zu dem Punkt an dem man die beiden Sachen verlinken muss.</p> <p>Da die WebApi und das Mvc Framework grundsätzlich auf verschiedenen Bibliotheken beruht ist die herangehensweise zwar ähnlich, aber nicht immer identisch.</p> <h3>Ein Link von einem Mvc Controller zu einem WebApi Controller &amp; Co.</h3> <p>Code sagt wesentlich mehr als viele Worte:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    public class MvcWebsiteController : Controller
    {

        public ActionResult Index()
        {
            ViewBag.UrlToAnotherMvcWebsiteController = Url.Action("Foobar", "AnotherMvcWebsite");
            ViewBag.AbsoluteUrlToAnotherMvcWebsiteController = Url.Action("Foobar", "AnotherMvcWebsite", null, "http");
            ViewBag.WebApiController = Url.RouteUrl("DefaultApi", 
                                                new { httproute = "", controller = "Foobar" });

            ViewBag.AbsoluteUrlToWebApiController = Url.RouteUrl("DefaultApi",
                                                new { httproute = "", controller = "Foobar" }, "http");


            return View();
        }

    }</pre>
<p>Im View:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;h2&gt;Index&lt;/h2&gt;
&lt;table&gt;
    &lt;tr&gt;
        &lt;td&gt;
            UrlToAnotherMvcWebsiteController
        &lt;/td&gt;
        &lt;td&gt;
            @ViewBag.UrlToAnotherMvcWebsiteController
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td&gt;
            AbsoluteUrlToAnotherMvcWebsiteController
        &lt;/td&gt;
        &lt;td&gt;
            @ViewBag.AbsoluteUrlToAnotherMvcWebsiteController
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td&gt;
            WebApiController
        &lt;/td&gt;
        &lt;td&gt;
            @ViewBag.WebApiController
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td&gt;
            AbsoluteUrlToWebApiController
        &lt;/td&gt;
        &lt;td&gt;
            @ViewBag.AbsoluteUrlToWebApiController
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td&gt;
            From View to MVC Controller
        &lt;/td&gt;
        &lt;td&gt;
            @Url.Action("Foobar", "AnotherMvcWebsite", null, "http")
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td&gt;
            From View to WebApi Controller
        &lt;/td&gt;
        &lt;td&gt;
            @Url.RouteUrl("DefaultApi", new { httproute = "", controller = "Foobar" })
        &lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;
</pre>
<p>Ergebnis:</p>
<p>&nbsp;</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1869.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1013.png" width="574" height="197"></a></p>
<p> Wichtigste Klasse zum Generieren der Urls hier ist der <a href="http://msdn.microsoft.com/en-us/library/system.web.mvc.urlhelper(v=vs.108).aspx">UrlHelper</a> im Mvc Framework.</p>
<p></p>
<h3>&nbsp;</h3>
<h3>Ein Link von einem WebApi Controller zu einem Mvc Controller &amp; Co.</h3><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    public class FoobarController : ApiController
    {
        public string Get()
        {
            // Results in "http://localhost:9547/" (Default Controller Route)
            var urlForMvcController = Url.Link("Default", new {controller = "MvcWebsite", action = "Index"});

            // Results in "http://localhost:9547/AnotherMvcWebsite/Foobar"
            var urlForAnotherMvcController = Url.Link("Default",
                                                      new
                                                          {
                                                              controller = "AnotherMvcWebsite",
                                                              action = "Foobar"
                                                          });

            // Results in "http://localhost:9547/api/Foobarbuzz"
            var anotherWebApiController = Url.Link("DefaultApi", new {controller = "Foobarbuzz"});

            // Results in "/api/Foobarbuzz"
            var anotherWebApiControllerRoute = Url.Route("DefaultApi", new { controller = "Foobarbuzz" });

            return "Foobar";
        }
    }</pre>
<p>Auch hier ist ein <a href="http://msdn.microsoft.com/en-us/library/system.web.http.routing.urlhelper(v=vs.108).aspx">UrlHelper</a> am Werk – aber der aus dem WebApi Namespace. Interessant ist noch der Unterschied zwischen dem puren <a href="http://msdn.microsoft.com/en-us/library/hh944655(v=vs.108).aspx">Link</a> und der <a href="http://msdn.microsoft.com/en-us/library/hh835560(v=vs.108).aspx">Route</a>. Trotz des anderen Namespaces kennt auch der WebApi UrlHelper die Route Config der Mvc-Welt und umgekehrt.</p>
<p>Damit sollte es eigentlich klappen.</p>
<p>Auf GitHub gibt es den <a href="https://github.com/Code-Inside/Samples/tree/master/2013/MvcAndWebApiRouting"><strong>kompletten Source-Code</strong></a>.</p>
