---
layout: post
title: "HowTo: apply MVC2 & Html.DropDownListFor"
date: 2010-12-25 20:14
author: CI Team
comments: true
categories: [HowTo]
tags: [Html, MVC2]
language: en
---
{% include JB/setup %}


<p>First of all: Merry Christmas to all of you out there and to your family :)</p> <img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb263.png" width="200" height="104" /> 
<p>In an ASP.NET MVC framework you will find a lot of nice HTML Helper. Even one which will help you building a simple HTML &lt;select&gt;. But how does the DropDownListFor helper work?</p>  
  

<p><b>Mhh.. WTF?</b></p>  

<p>To say the true: It takes a while to understand this intellisense for me as well. Maybe it's because Im not such a smart-ace ;)</p>
<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb264.png" width="504" height="208" /></p>
<p>After spending some time on google queries I found this solution on <a href="http://stackoverflow.com/questions/2497417">Stackoverflow</a>.</p>
<p><b>The Model:</b></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b0ec809b-d47f-4359-8459-ab066f75b191" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class SettingsViewModel
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
}
</pre>
</div>


<p><b>Controller:</b></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9fd7dd50-fe6c-4d0a-a7c7-ed044b61006d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class HomeController : Controller
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
}
</pre>
</div>


<p>Noting special, isn't it?</p>

<p><b>The View:</b></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4787558c-c1b4-47c7-b744-fe292d6deed4" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;% using (Html.BeginForm()) { %&gt;
    &lt;%= Html.DropDownListFor(
        x =&gt; x.TimeZone,
        Model.TimeZones,
        new { @class = "SecureDropDown" }
    ) %&gt;
    &lt;input type="submit" value="Select timezone" /&gt;
&lt;% } %&gt;

&lt;div&gt;&lt;%= Html.Encode(Model.TimeZone) %&gt;&lt;/div&gt;
</pre>
</div>


<p>First we need to declare where the "selected" element should be mapped â†’ on TimeZone. Second we have the list with the probably results. In the last step you are able to pass some Html attributes.</p>

<p><b>Result:</b></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image110.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb19.png" width="487" height="146" /></a></p>

<p>Fascinating!</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/mvcdropdownlisthelper/mvcdropdownlisthelper.zip">[Download Democode]</a></p>
