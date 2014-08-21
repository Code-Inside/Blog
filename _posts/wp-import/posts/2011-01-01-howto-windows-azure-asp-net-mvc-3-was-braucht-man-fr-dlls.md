---
layout: post
title: "HowTo: Windows Azure & ASP.NET MVC 3 – was braucht man für DLLs?"
date: 2011-01-01 17:46
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Azure, Cloud, Cloud Computing, HowTo, MVC, Windows Azure]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1145.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb327.png" width="133" height="125" /></a>In <a href="{{BASE_PATH}}/2010/11/30/howto-eine-bestehende-webapp-nach-azure-migrieren/">diesem Blogpost</a> beschrieb ich, wie man eine bestehende MVC2 WebApp nach Azure migriert. Mit MVC3 kommen aber einige neue Dlls hinzu. Da das Deployment auf Azure und die Suche nach fehlenden Dlls etwas nervig ist, hier mal eine Auflistung an Dlls die man für MVC3 + Razor Viewengine &amp; Azure braucht. </p> <!--more-->  <p></p>  <p><strong>WebPages Dlls</strong></p>  <p>Die Razor Viewengine nimmt Bestandteile vom <a href="http://www.asp.net/webmatrix">Microsofts WebMatrix</a>, daher benötigen wir folgende Dlls aus diesem Verzeichnis:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:235fcab0-814c-466a-9f32-bf1e8eacb799" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Program Files (x86)\Microsoft ASP.NET\ASP.NET Web Pages\v1.0\Assemblies</pre></div>

<p>Von dort:</p>

<ul>
  <li>Microsoft.Web.Infrastructure</li>

  <li>System.Web.Helpers</li>

  <li>System.Web.Razor</li>

  <li>System.Web.WebPages</li>

  <li>System.Web.WebPages.Razor</li>

  <li>System.Web.WebPages.Deployment</li>

  <li>WebMatrix.Data</li>

  <li>WebMatrix.WebData</li>
</ul>

<p><strong>Mvc Dll</strong></p>

<p>Die benötigen wir natürlich auch noch aus diesem Ordner:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8bac47c1-860a-4329-806b-35b9a7f226fa" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Program Files (x86)\Microsoft ASP.NET\ASP.NET MVC 3\Assemblies</pre></div>

<ul>
  <li>System.Web.Mvc</li>
</ul>

<p><strong>Was mach ich nun damit?</strong></p>

<p>Als Best-Practices würde ich diese Dlls irgendwo im Solution Ordner unter "SharedBinaries” speichern. Die Dlls müssen dann via "Add Reference” hinzufügen und anschließend auf <strong>"Copy Local=true”</strong> umgestellt werden!</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1146.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb328.png" width="244" height="200" /></a> </p>

<p><strong>Dies muss bei allen Assemblies gemacht werden!</strong></p>

<p>Warum man die ganzen Assemblies braucht, ist mir total schleierhaft und empfinde ich auch als ziemlich umständlich dutzende Dlls zu referenzieren. </p>

<p>In dem Web Pages Ordner gibt es noch mehr Dlls - evtl. benötigt man die zu einem späteren Zeitpunkt noch ;) </p>

<p>Der Post entstand auf Grundlage von MVC3 RC2.</p>

<p>Damit sollte es jetzt auch auf der Cloud klappen.</p>
