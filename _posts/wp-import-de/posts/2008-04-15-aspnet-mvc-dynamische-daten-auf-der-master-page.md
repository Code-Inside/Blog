---
layout: post
title: "ASP.NET MVC: Dynamische Daten auf der Master Page"
date: 2008-04-15 13:14
author: Robert Muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET MVC, Components]
language: de
---
{% include JB/setup %}
<p>Wer mit der 2 MVC Preview rumspielt, wird sicherlich irgendwann zu der Frage kommen: Wie stell ich dynamische Daten auf meiner Master Page dar oder wenn ich irgendwelche Daten darstellen möchte, die nur indirekt mit dem View was zutun haben.</p> <p>Die Grundstruktur von einer MVC Applikation:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image384.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="280" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb363.png" width="180" border="0"></a> </p> <p>Die einzelnen Controller greifen jeweils auf die Views in den jeweiligen Ordnern zu (EntryController greift auf Views\Entry\VIEW) zu.</p> <p>Wenn man nun allerdings ein Control auf einer Master Page einbauen möchte, (z.B. ein Nachrichten-Ticker, eine Übersicht, ein Menü...&nbsp; etc.), welcher für sich keinen eigenen Controller hat, kann man dies sehr einfach mit dem "ComponentController" realisieren:</p> <p>In meiner Demoanwendung wird die Kategorieliste und die Tagcloud über solch einen ComponentController gebildet:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1954a126-78e4-4763-bb1f-029084c1bcee" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class EntrySidebarController : ComponentController
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
<p>Diese beiden extra Views müssen in einen neuen Ordner gespeichert werden:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image385.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="241" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb364.png" width="230" border="0"></a> </p>
<p>Der Aufruf ist am Ende ebenso simpel wie bei einem UserControl:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e3d7bcb9-5b32-4c74-a210-1c293e069830" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;%=Html.RenderComponent&lt;EntrySidebarController&gt;(component =&gt; component.CategoryList())%&gt;
    &lt;%=Html.RenderComponent&lt;EntrySidebarController&gt;(component =&gt; component.TagCloud())%&gt;</pre></div>
<p>Resultat:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image386.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb365.png" width="168" border="0"></a> </p>
<p>Ein anderes gute Tutorial, an dem ich mich auch gehalten habe: </p>
<h4><a href="http://weblogs.asp.net/mikebosch/archive/2008/03/10/using-the-componentcontroller-in-asp-net-mvc.aspx">Using the ComponentController in ASP.NET MVC CTP 2</a></h4>
