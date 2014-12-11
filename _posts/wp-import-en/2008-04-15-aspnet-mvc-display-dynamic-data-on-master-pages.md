---
layout: post
title: "ASP.NET MVC: Display dynamic data on master pages"
date: 2008-04-15 14:32
author: robert.muehsig
comments: true
categories: [Uncategorized]
tags: [ASP.NET MVC, Components]
language: en
---
{% include JB/setup %}
<p>If you play with the MVC 2 bits for a while you will come to a very simple question: How can I display dynamic data on my master page?</p>  <p>The structur of an MVC App (this is my demo app) :</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image9.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="280" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb9.png" width="180" border="0" /></a> </p>  <p>Each controller has it&#180;s own View-Folder and render the specific view (EntryController route to Views\Entry\VIEW).</p>  <p>But if you try to add a dynamic control (a dynamic menu, news-ticker, overviews...) on a master page you have a problem: A master page has no real controller itself (maybe a master page could have a controller - but for this problem there is a very easy way to do this).</p>  <p><strong>The CTP 2 includes a special controller - the &quot;ComponentController&quot;:</strong></p>  <p>I use the &quot;ComponentController&quot; in my demo app to display the whole category list and the tagcloud.</p>  <p>My &quot;EntrySideBarController&quot; inherit from &quot;ComponentController&quot;</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2071a403-8ba7-4f19-86ac-ba9166e7676b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class EntrySidebarController : ComponentController
    {
        public void CategoryList()
        {
            ... viewdata = ...
            RenderView("CategoryList", viewData);
        }

        public void TagCloud()
        {
            ... viewdata = ...
            RenderView("TagCloud", viewData);
        }
    }</pre></div>

<p>The views &quot;CategoryList&quot; &amp; &quot;TagCloud&quot; are located in a special folder (root\Components\CONTROLLERNAME\Views\VIEWNAME):</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image10.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="241" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb10.png" width="230" border="0" /></a>&#160;</p>

<p>To render these components just use the &quot;Html.RenderComponent&quot; method (is similar to a usercontrol) :</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e3d7bcb9-5b32-4c74-a210-1c293e069830" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;%=Html.RenderComponent&lt;EntrySidebarController&gt;(component =&gt; component.CategoryList())%&gt;
    &lt;%=Html.RenderComponent&lt;EntrySidebarController&gt;(component =&gt; component.TagCloud())%&gt;</pre></div>

<p>Result:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image11.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb11.png" width="168" border="0" /></a>&#160;</p>

<p>For more information about the ComponentController, look at this post: </p>

<h4><a href="http://weblogs.asp.net/mikebosch/archive/2008/03/10/using-the-componentcontroller-in-asp-net-mvc.aspx">Using the ComponentController in ASP.NET MVC CTP 2</a></h4>
