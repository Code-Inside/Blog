---
layout: post
title: "HowTo: Full Qualified Type Name - Klassen/Typnamen richtig schreiben"
date: 2009-10-04 21:46
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET, HowTo, Names, web.config]
language: de
---
{% include JB/setup %}
<a href="{{BASE_PATH}}/assets/wp-images/image831.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="127" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb16.png" width="111" align="left" border="0"></a>  <p>Wer z.B. ein HttpModul in der Web.config registrieren möchte, muss immer den "Full Qualified Name" eines Types angeben. Wer mit SharePoint zutun hat, wird spätestens bei den SafeControls darauf stoßen. Da ich vor kurzem etwas gerätselt habe, wie dieser "Full Qualified Type Name" aufgebaut ist, hier die Lösung:</p><p><strong>Beispiel aus der web.config:</strong></p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2db2f2cf-16d1-44d1-bf1c-393004204787" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">		&lt;httpModules&gt;
			&lt;add name="ScriptModule" type="System.Web.Handlers.ScriptModule, System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/&gt;
			&lt;add name="UrlRoutingModule" type="System.Web.Routing.UrlRoutingModule, System.Web.Routing, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/&gt;
		&lt;/httpModules&gt;</pre></div>
<p>Dies sind die zwei Standard HttpModule in der Web.Config einer ASP.NET MVC Webanwendung.</p>
<p>Schauen wir uns genauer den ersten an.</p>
<p><strong>Namen sind Schall und Rauch...</strong></p>
<p>Der Name "ScriptModule" hat im Grunde erstmal nichts zu sagen. <strong>Wichtig ist die "type" Eigenschaft.</strong> Damit wird bestimmt, wo denn das HttpModule überhaupt liegt.</p>
<p><strong>5 Eigenschaften</strong></p>
<p>Hinter "type" stehen kommasepariert 5 Daten:</p>
<ul>
<li>"System.Web.Handlers.ScriptModule" = Namespace + Klassenname</li>
<li>"System.Web.Extensions" = ist die DLL/Assembly. In diesem Fall liegt diese im GAC (C:\Windows\assembly\System.Web.Extensions.dll)</li>
<li>Versionsinformation (default: 1.0.0.0)</li>
<li>Kultur (default: neutral)</li>
<li>PublicKeyToken = Wenn man seine Assembly signiert hat, kommt hier der "öffentliche" Teil des Schlüssels hin - dies ist Pflicht, wenn die Assembly in den GAC landen soll</li></ul>
<p><strong>Mehr Informationen</strong></p>
<p>Mehr Informationen findet man sicherlich auch <a href="http://msdn.microsoft.com/en-us/library/yfsftwz6.aspx">in der MSDN</a>. Jedoch sollte man mit diesen Informationen bereits seinen eigenen HttpHandler in der Web.config registrieren können.</p>
