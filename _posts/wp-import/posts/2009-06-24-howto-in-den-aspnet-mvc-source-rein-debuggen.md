---
layout: post
title: "HowTo: In den ASP.NET MVC Source Code rein debuggen"
date: 2009-06-24 01:32
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo, MVC]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image767.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="104" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb745.png" width="177" align="left" border="0"></a>Wer Microsoft neustes <a href="http://asp.net/mvc">WebFramework</a> genauer unter die Lupe nehmen möchte oder wer genau wissen will, was sich hinter den verschiedenen Helpern verbirgt (um so z.B. bei einem Bug genauer bescheid zu wissen) sollte sich den <a href="http://aspnet.codeplex.com/Release/ProjectReleases.aspx?ReleaseId=24471">Source Code von ASP.NET MVC</a> direkt in seine Solution mit einbinden. Mit wenigen Handgriffen kann man bis in das MVC Framework debuggen.</p><p><strong>Wo gibt´s den Source Code?</strong></p> <p>Den Source Code findet man auf <a href="http://aspnet.codeplex.com/Release/ProjectReleases.aspx?ReleaseId=24471">Codeplex</a>. </p> <p><strong>Was bekommt man?</strong></p> <p>Man bekommt den Source Code für "System.Web.MVC" und den Futures. Auch die Unittests wurden mitausgeliefert. Wer mag kann sich auch sein eigenes MVC bauen und nutzen - die Lizenz lässt es jeden offen.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image768.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="130" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb746.png" width="211" border="0"></a> </p> <p><strong>Wie kann man nun die System.Web.Mvc Projekt für sich selbst nutzen?</strong></p> <p>Schritt 1: Den Source Code runterladen bei Codeplex.<br>Schritt 2: Das System.Web.Mvc Projekt in die eigene Solution mit einhängen</p> <p>Es sollte jetzt so aussehen: </p> <p><a href="{{BASE_PATH}}/assets/wp-images/image769.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="53" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb747.png" width="244" border="0"></a> <br>Schritt 3: Bestehende Referenzen von System.Web.Mvc löschen und die Mvc Assembly aus der Solution nutzen.</p> <p>Jetzt muss man noch die Web.config entsprechend anpassen, weil dort noch Referenzen auf die GAC Mvc DLL sind. Folgende Zeile die ich auskommentiert habe, muss auskommentiert werden:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:906278dc-2aac-4667-8c4c-9dc565ecec43" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;compilation debug="true"&gt;
			&lt;assemblies&gt;
				&lt;add assembly="System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/&gt;
				&lt;add assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/&gt;
				&lt;add assembly="System.Web.Abstractions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/&gt;
				&lt;add assembly="System.Web.Routing, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/&gt;
				&lt;!--&lt;add assembly="System.Web.Mvc, Version=1.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/&gt;--&gt;
				&lt;add assembly="System.Data.DataSetExtensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/&gt;
				&lt;add assembly="System.Xml.Linq, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/&gt;
				&lt;add assembly="System.Data.Linq, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/&gt;
			&lt;/assemblies&gt;
		&lt;/compilation&gt;</pre></div>
<p>Unter der web.config im View Ordner muss ebenfalls noch eine Änderung gemacht werden. Beim "pageParserFilterType" muss der PublicKeyToken null sein:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d944de80-423a-48d6-9386-975dcf0a067a" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">pageParserFilterType="System.Web.Mvc.ViewTypeParserFilter, System.Web.Mvc, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"</pre></div>
<p><strong>Geschafft!</strong></p>
<p>Nun kann man direkt bis ins Framework debuggen. Den Tipp habe ich auf <strong><a href="http://blog.codeville.net/2009/02/03/using-the-aspnet-mvc-source-code-to-debug-your-app/">Steve Sandersons Blog gefunden</a></strong>. Er hat die Schritte auch etwas mehr beschrieben.</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcdebugintosource/mvcdebugintosource.zip">[ Download Democode ]</a></strong></p>
