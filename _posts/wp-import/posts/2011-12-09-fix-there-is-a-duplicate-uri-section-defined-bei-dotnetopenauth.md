---
layout: post
title: "Fix: “There is a duplicate 'uri' section defined” bei DotNetOpenAuth"
date: 2011-12-09 02:08
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Cassini, DotNetOpenAuth, Fix, IIS]
language: de
---
{% include JB/setup %}
<p>Kleiner Hinweis, was zutun ist, wenn man diesen Fehler bekommt.</p> <p><strong>Folgendes Setup bei mir:</strong></p> <p>- ASP.NET MVC Projekt samt .NET Framework 4.0</p> <p>- <a href="http://www.dotnetopenauth.net/">DotNetOpenAuth</a> via <a href="http://nuget.org/">NuGet</a> installiert</p> <p>- Das Webprojekt hat noch “Cassini” genutzt</p> <p><strong>Beim Deployen auf einen richtigen IIS bekam ich diese Fehlermeldung:</strong></p> <p><em>“There is a duplicate 'uri' section defined” </em></p> <p>Oder zu deutsch:</p> <p><em>“Der "uri"-Abschnitt wurde doppelt definiert.”</em></p> <p>Rot markiert war diese Zeile:</p> <p><em>&lt;section name="uri" type="System.Configuration.UriSection, System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" /&gt;<br></em></p> <p>&nbsp;</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1423.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb601.png" width="553" height="263"></a></p>  <p><strong>Fehlerbeseitigung:</strong></p> <p>(recht einfach ;) ) Die Zeile aus der eigenen Web.config entfernen:</p> <p><em>&lt;section name="uri" type="System.Configuration.UriSection, System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" /&gt;</em></p> <p><strong>Grund:</strong> Dieser Eintrag ist bereits in der machine.config bei .NET 4.0 Applikationen mit dabei, daher wäre er doppelt.</p> <p>Das Problem tritt allerdings nur im IIS und IIS Express auf. “Cassini” stört sich (leider) nicht daran. </p> <p>Tipp (wie fast immer) von <a href="http://stackoverflow.com/questions/2475329/steps-to-investigate-cause-of-web-config-duplicate-section">Stackoverflow</a> (auch wenn dort die beste Antwort mir etwas kompliziert erscheint, daher auch der Blogpost ;) )</p>
