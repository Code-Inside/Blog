---
layout: post
title: "HowTo: Globalization/Localization mit ASP.NET MVC - streng typisiert"
date: 2009-12-09 02:11
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, ASP.NET MVC, Globalization, HowTo, Localization, MVC]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image879.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="144" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb64.png" width="92" align="left" border="0"></a>In einen meiner <a href="{{BASE_PATH}}/2009/11/05/howto-globalizationlocalization-mit-asp-net-mvc/">letzten HowTos ging</a> es um die Mehrsprachigkeit in ASP.NET MVC Anwendungen. Dort hatte ich ein System empfohlen, welche über bestimmte Expressions <a href="http://blog.eworldui.net/post/2008/10/ASPNET-MVC-Simplified-Localization-via-ViewEngines.aspx">die Resourcendatein auslesen</a>. Es geht natürlich viel einfacher und eleganter: Einfach über Resources zugreifen. </p> <p>&nbsp;</p><!--more--> <p><strong>Die erste Variante:</strong></p> <p>In der ersten Variante konnte ich so die Resourcendatein auslesen:</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9d8b70fb-0d44-49da-98ed-4f5a4b9b906f" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">Global resource : &lt;%=Html.Resource("Strings, GlobalResourceKey") %&gt;&lt;br /&gt;  
Local resource : &lt;%=Html.Resource("LocalKey")%&gt;&lt;br /&gt; </pre></div></p>
<p>Schön ist das allerdings nicht wirklich. </p>
<p><strong>Das Problem: Magic Strings.</strong></p>
<p>Man hat irgendwelche Strings in den Views stehen. Man vertippt sich äußerst schnell und Intellisense (wenn sie denn mal in den MVC Views gehen sollte ;) ) ist auch nicht vorhanden.</p>
<p><strong>Daher einfacher und eigentlich auch logisch: Zugriff direkt auf Resources</strong></p>
<p>Ich weiß nicht warum es erst bei mir nicht funktioniert hat, aber man kann z.B. einfach so auf GlobalResourcen zugreifen:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0d0943f1-e01b-4ff5-a8e6-5238af9368ea" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">Resources.Test.Foobar;</pre></div>
<p>Wobei "Test" die Ressourcendatei ist und Foobar mein Key. Aus den MVC Views heraus funktioniert das mit Ressourcen, die in den App_GlobalResources liegen auch. <strong>Lokale Ressourcen</strong> kann man allerdings <strong>nicht</strong> auslesen. Warum auch immer. </p>
<p>Manchmal ist es einfacher als Gedacht. Neben den besseren Zugriffsmöglichkeiten, spart man sich die Viewengine und die Resourceextensions.</p>
<p>Weitere Links zum Thema Localization &amp; ASP.NET MVC:</p>
<ul>
<li><a href="http://www.fairnet.com/post/2009/09/06/Localizing-ASPNET-MVC.aspx">Localizing ASP.NET MVC</a></li>
<li><a href="http://haacked.com/archive/2009/12/07/localizing-aspnetmvc-validation.aspx">Localizing ASP.NET MVC Validation</a></li></ul>
<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/mvclocal/mvclocal2.zip">[ Download Democode ]</a></strong></p>
