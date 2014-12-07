---
layout: post
title: "HowTo: MVC2 & Html.DropDownListFor einsetzen"
date: 2010-10-18 22:56
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Helper, HowTo, MVC]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1081.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb263.png" width="200" height="104" /></a>Im ASP.NET MVC Framework verbergen sich allerhand netter Html Helper. Darunter auch eins um eine simples HTML &lt;select&gt; zu basteln. Doch wie setz ich nun den DropDownListFor Helper ein?</p>  <p></p>  <p><strong>Mhh... WTF?</strong></p>  <p>Also so richtig &quot;klar” war mir die Intellisense hier nicht - wahrscheinlich bin ich nicht so ein Smart-Ass ;)</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1082.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb264.png" width="504" height="208" /></a> </p>  <p>Nach ein paar Google Queries hatte ich dann <a href="http://stackoverflow.com/questions/2497417">die Lösung auf Stackoverflow</a> gefunden. Ich blogg die mal hier, damit ich es nicht vergesse.</p>  <p><strong>Das Model:</strong></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5aad9643-8ce9-4010-af46-a704afd46a19" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class SettingsViewModel
{
    public string TimeZone { get; set; }

    public IEnumerable&lt;SelectListItem&gt; TimeZones 
    {
        get 
        {
            return TimeZoneInfo
                .GetSystemTimeZones()
                .Select(t =&gt; new SelectListItem 
                { 
                    Text = t.DisplayName, Value = t.Id 
                });
        }
    }
}</pre></div>

<p>Im "TimeZone” Property wird das eigentliche Ergebnis gespeichert. Die TimeZones Liste ist nur für das DropDown gedacht.</p>

<p><strong>Controller:</strong></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0435059a-ff76-4ac6-bbbc-586b773a101e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class HomeController : Controller
{
    public ActionResult Index()
    {
        return View(new SettingsViewModel());
    }

    [HttpPost]
    public ActionResult Index(SettingsViewModel model)
    {
        return View(model);
    }
}</pre></div>

<p></p>

<p>Nix besonders, oder?</p>

<p><strong>Der View:</strong></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0d72e4af-fabe-40f5-afdb-7ad84cb0ebe9" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;% using (Html.BeginForm()) { %&gt;
    &lt;%= Html.DropDownListFor(
        x =&gt; x.TimeZone, 
        Model.TimeZones, 
        new { @class = "SecureDropDown" }
    ) %&gt;
    &lt;input type="submit" value="Select timezone" /&gt;
&lt;% } %&gt;

&lt;div&gt;&lt;%= Html.Encode(Model.TimeZone) %&gt;&lt;/div&gt;</pre></div>

<p>Als erstes wird festgelegt, wohin das "selected” Element gemappt wird -&gt; auf TimeZone. Als zweites kommt die Liste an möglichen Werten. Als letztes können noch HtmlAttribute mitgegeben werden.</p>

<p><strong>Ergebnis:</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1083.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb265.png" width="445" height="133" /></a> </p>

<p>Fetzt, oder?</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/mvcdropdownlisthelper/mvcdropdownlisthelper.zip"><strong>[ Download Democode ]</strong></a></p>
