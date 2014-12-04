---
layout: post
title: "Carriage Return / new line in Textareas"
date: 2012-02-15 19:45
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<p>&#160;</p>  <p>A little task: each new text line (Carriage Return/ if you press enter <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile33.png" />) in a Textarea should be an element on a list – so what’s the easiest way? Actual a basic element in the web and the user make aware distributions – so it would be fair to dignify it. </p>  <p><b>Little MVC Demo App:</b></p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb630.png" width="244" height="171" /></p>  <p>We are going to analyze the input in this text field a little bit closer. In my option the “split” happens on the Server-Side but it’s also possible on JavaScript. </p>  <p><b>After you’ve klicked on “ok”:</b></p>  <p>The controller receives the text you’ve entered. After the user pressed “enter” in the Textarea either an \n or a \r\n as “functional character”. ( I think it’s in connection with the operation system…. But that’s another story <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile33.png" />). </p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb631.png" width="402" height="91" /></p>  <p>After that all we have to is to split the string on this sign and then we are able to take care about the single distributions:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:30a3625a-780e-4c6b-9135-f29cf38236fd" class="wlWriterEditableSmartContent"><pre name="code" class="c#">  public ActionResult Multiline(string input)
        {
            ViewBag.MultilineRaw = input;

            List&lt;string&gt; eachLine = input.Split(new string[] { "\n", "\r\n" }, StringSplitOptions.RemoveEmptyEntries).ToList();
            ViewBag.MultilineSplitted = eachLine;

            return View("Index");
        }</pre></div>

<p>View:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d1f7456c-831b-4f33-a45d-c85b7e342997" class="wlWriterEditableSmartContent"><pre name="code" class="c#">@using(Html.BeginForm("Multiline", "Home"))
{
    @Html.TextArea("input")
    &lt;button&gt;OK&lt;/button&gt;
}
@if(string.IsNullOrWhiteSpace(ViewBag.MultilineRaw) == false)
{
&lt;h2&gt;Input&lt;/h2&gt;
&lt;p&gt;Raw: @ViewBag.MultilineRaw&lt;/p&gt;
&lt;h3&gt;Each Line&lt;/h3&gt;
    &lt;ul&gt;
        @foreach(var line in @ViewBag.MultilineSplitted)
        {
        &lt;li&gt;@line&lt;/li&gt;
        }
    &lt;/ul&gt;
}</pre></div>

<p>Result:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb632.png" width="310" height="273" /></p>

<p>Not a big deal but maybe a help for some of you. </p>

<p><a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2Fmvcmultiline">[Download on Google Code]</a></p>
