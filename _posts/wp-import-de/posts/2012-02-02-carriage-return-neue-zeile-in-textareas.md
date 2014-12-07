---
layout: post
title: "Carriage Return / Neue Zeile in Textareas"
date: 2012-02-02 23:38
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo, Multiline]
language: de
---
{% include JB/setup %}
<p>Eine kleine Aufgabe: Jede neue Textzeile (Carriage Return/Wenn man Enter drückt ;) ) in einer Textarea soll ein Element in einer Auflistung sein – wie mach ich das jetzt am einfachsten?</p> <p>Eigentlich ein grundlegendes Element im Web und der Nutzer macht bewusst Absätze – daher wäre es nur gerecht, wenn man das auch entsprechend würdigt.</p> <p>Kleine MVC Demo App:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1456.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb630.png" width="244" height="171"></a></p> <p>Wir wollen die Eingaben in diesem Textfeld etwas näher analysieren. In meiner Variante geschieht das “splitten” auf der Server-Seite, allerdings wäre es über Javascript natürlich genauso möglich.</p> <p><strong>Nach dem OK Klick:</strong></p> <p>Der Controller nimmt den Eingabetext entgegen. Wenn der Nutzer [Enter] in der Textarea drückt, kommt als “Steuerzeichen” entweder ein \n oder \r\n mit (ich glaub das hängt mit den Betriebssystemen zusammen… lange Geschichte ;))</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1457.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb631.png" width="371" height="84"></a></p> <p>Damit müssen wir den String nur noch bei diesen Zeichen splitten und schon können wir die einzelnen Absätze besonders behandeln:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ed834bf0-5f17-484b-b301-a20cb570dd54" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        public ActionResult Multiline(string input)
        {
            ViewBag.MultilineRaw = input;

            List&lt;string&gt; eachLine = input.Split(new string[] { "\n", "\r\n" }, StringSplitOptions.RemoveEmptyEntries).ToList();
            ViewBag.MultilineSplitted = eachLine;

            return View("Index");
        }</pre></div>
<p>&nbsp;</p>
<p>View:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f85ec20b-214b-45da-af31-675d28759025" class="wlWriterEditableSmartContent"><pre name="code" class="c#">@using(Html.BeginForm("Multiline", "Home"))
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
<p>&nbsp;</p>

<p>Endergebnis:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1458.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb632.png" width="310" height="273"></a></p>
<p>Keine große Sache – aber vielleicht hilft es den einen oder anderen weiter.</p>
<p><a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2Fmvcmultiline">[ Download auf Google Code ]</a></p>
