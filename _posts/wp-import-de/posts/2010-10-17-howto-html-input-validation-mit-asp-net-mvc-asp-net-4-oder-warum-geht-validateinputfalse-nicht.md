---
layout: post
title: "HowTo: HTML Input Validation mit ASP.NET MVC & ASP.NET 4 (oder warum geht ValidateInput(false) nicht?)"
date: 2010-10-17 17:39
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET 4, HowTo, MVC, RequestValidation]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1077.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb259.png" width="184" height="88" /></a> </p>  <p>Das ASP.NET Framework validiert einkommende Requests ob diese &lt;html&gt; Elemente enthalten oder nicht. Dies soll Script-Injection vorbeugen. Ab und an braucht will man aber dieses verhalten nicht. Bis zu .NET 3.5 Zeiten brauchte man über ASP.NET MVC Actions einfach nur das Attribut "ValidateInput(false)” setzen. Unter ASP.NET 4 muss man noch eine Kleinigkeit beachten</p>  <p><strong>Szenario:</strong></p>  <p>Simples Input Feld:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:89bcf107-455e-4f75-83d2-8342886dd91d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        &lt;% using(Html.BeginForm()) { %&gt;
            &lt;%:Html.TextBox("HtmlInput", ViewData["HtmlInput"]) %&gt;                                  
        &lt;%}%&gt;</pre></div>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1078.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb260.png" width="244" height="76" /></a> </p>

<p>Nix besonderes im Controller, außer dass die Post - Index Methode mit ValidateInput (false) dekoriert wurde:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c4b4e3d9-a1bd-4421-9332-797fd94531ef" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MvcRequestValidation.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Index()
        {
            ViewData["Message"] = "Welcome to ASP.NET MVC!";

            return View();
        }

        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Index(string htmlInput)
        {
            ViewData["Message"] = "Welcome to ASP.NET MVC!";
            ViewData["HtmlInput"] = htmlInput;
            return View();
        }

        public ActionResult About()
        {
            return View();
        }
    }
}
</pre></div>

<p>Das ganze läuft unter .NET 4.0.</p>

<p><strong>Und nun? Trotzdem Fehlermeldung...</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1079.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb261.png" width="545" height="178" /></a> </p>

<p><strong>Lösung des Problems: (Steht sogar in der Description)</strong></p>

<p></p>

<p></p>

<p></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c3dbd2b2-50f1-4426-9d0c-29c9abe4b158" class="wlWriterEditableSmartContent"><pre name="code" class="c#">To allow pages to override application request validation settings, set the requestValidationMode attribute in the httpRuntime configuration section to requestValidationMode="2.0". Example: &lt;httpRuntime requestValidationMode="2.0" /&gt;. </pre></div>

<p>Wer liest schon Fehlermeldungen? ;) Zum Glück war ich <a href="http://stackoverflow.com/questions/1461330/validateinput-attribute-doesnt-seem-to-work-in-asp-net-mvc">nicht</a> <a href="http://stackoverflow.com/questions/807662/why-is-validateinputfalse-not-working">der</a> <a href="http://blogs.microsoft.co.il/blogs/pintyo/archive/2010/03/24/simple-rtfem-or-why-asp-net-mvc-validateinput_3D00_false-doesnt-disable-request-validation-on-asp-net-4.aspx">einzige</a> mit dem Problem ;)</p>

<p>Ist auch als <a href="http://www.asp.net/learn/whitepapers/aspnet4/breaking-changes">Breaking Change</a> in den Dokumentationen von Microsoft zu finden. Unter &lt;system.web&gt; noch "&lt;httpRuntime requestValidationMode=&quot;2.0&quot; /&gt;” einfügen und fertig :)</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1080.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb262.png" width="359" height="109" /></a> </p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcrequestvalidation/mvcrequestvalidation.zip">[Download Democode]</a></strong></p>
