---
layout: post
title: "HowTo: AJAX Actionlink & ASP.NET MVC 3"
date: 2011-04-26 22:11
author: antje.kilian
comments: true
categories: [HowTo]
tags: [AJAX, ASP.NET, MVC3]
language: en
---
{% include JB/setup %}
<p>&#160;</p>  <p><b></b></p>  <p><a href="http://code-inside.de/blog-in/wp-content/uploads/image157.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="http://code-inside.de/blog-in/wp-content/uploads/image_thumb65.png" width="163" height="107" /></a>In MVC framework there are some little helpers existing I´ve already written about in <a href="http://code-inside.de/blog-in/2010/09/15/howto-cross-domain-ajax-with-jsonp-and-asp-net/">this blogpost</a> - but in fact the functionality changed a little bit so here is an update for you.</p>  <p>&#160;</p>  <!--more-->  <p><b>Problem: AJAX Actionlink delivers new sides back </b></p>  <p>We have a standard MVC 3 Web Project and the following lines should create a link which is able to reload a view via AJAX and put it into the "Result":</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e32c2996-41f4-4d3a-b9e5-25b5982c120d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    @Ajax.ActionLink("Foobar load", "Foobar", "Home", new AjaxOptions() { HttpMethod = "Get", UpdateTargetId = "Result" })</pre></div>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb422.png" width="350" height="105" /></p>

<p>After pressing the button normally the View has to be reloaded via AJAX but there is no request send by AJAX. Why?</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb423.png" width="220" height="103" /></p>

<p><b>Javascript libraries are missing </b></p>

<p><b></b></p>

<p>In the standard - masterpage jQuery is already linked but the AJAX library is still missing. In this case MVC3 offers the MS AJAX libraries but we don´t need them anymore. </p>

<p>For AJAX we need the jQuery.unobtrusive-ajax.js (or the min.js) file!</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb424.png" width="260" height="297" /></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:db79c66b-3278-4980-ae26-2d797ab112eb" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
    ...
    &lt;script src="@Url.Content("~/Scripts/jquery-1.4.4.min.js")" type="text/javascript"&gt;&lt;/script&gt;
    &lt;script src="@Url.Content("~/Scripts/jquery.unobtrusive-ajax.min.js")" type="text/javascript"&gt;&lt;/script&gt;
&lt;/head&gt;
...</pre></div>

<p>Take a look into the HTML and you will find a little surprise!</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb425.png" width="582" height="89" /></p>

<p>If this looks different by everyone else: Important are also the following adjustments in the web.config (these are standard on every new project).</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:86558738-46ee-4bfb-bba7-dc23a3bd0c6d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">  &lt;appSettings&gt;
    &lt;add key="ClientValidationEnabled" value="true"/&gt;
    &lt;add key="UnobtrusiveJavaScriptEnabled" value="true"/&gt;
  &lt;/appSettings&gt;</pre></div>

<p><b>Unobtrusive Javascript? What?</b></p>

<p><b></b></p>

<p>What is the whole "unobtrusive Javascript" about? In fact it´s about keeping the side operable and no JS Eventhandler for example is integrated at the a-Tag. It will be integrated via the data-attribute.</p>

<p>Here is a Screenshot from a <a href="http://simonwillison.net/static/2008/xtech/">great presentation</a> about the subject:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb426.png" width="329" height="248" /></p>

<p><a href="http://www.slideshare.net/simon/unobtrusive-javascript-with-jquery">Unobtrusive JavaScript with jQuery</a></p>

<p>View more <a href="http://www.slideshare.net/">presentations</a> from <a href="http://www.slideshare.net/simon">Simon Willison</a></p>

<p><b>Pure jQuery</b></p>

<p><b></b></p>

<p>Of course you don´t need to use AJAX helper it will also work with the jQuery Standard tools:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7038d8dd-7493-4f8d-84e8-3c1c2e813cad" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$(function() {
    $('#mylink').click(function() {
        $('#AjaxTestDiv').load(this.href);
        return false;
    });
});</pre></div>

<p>Like always a great help: <a href="http://stackoverflow.com/questions/4973605/ajax-actionlink-not-working-response-isajaxrequest-is-always-false">Stackoverflow</a> <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-smile11.png" /></p>

<p><a href="http://code-inside.de/files/democode/mvc3ajaxactionlink/mvc3ajaxactionlink.zip">[Download Sample Code]</a></p>
