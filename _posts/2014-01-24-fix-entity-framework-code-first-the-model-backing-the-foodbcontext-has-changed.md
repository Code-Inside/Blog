---
layout: post
title: "Fix: Entity Framework Code First: “The model backing the ‘FooDbContext’ has changed…”"
date: 2014-01-24 19:54
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Code First, Entity Framework, Fix]
---
<p>Das Entity Framework Code First Model ist recht praktisch um eine kleine Datenbank schnell zu designen. Allerdings steckt etwas Magic (naja – Untertreibung – da steckt<strong> </strong>viel dunkles Yuyu und Voodoo) darin. Das EF-Model überprüft ob die Datenbank noch dazu passt und falls nicht gibt es verschiedenen Strategien. Die einfachste <a href="http://weblogs.asp.net/scottgu/archive/2010/07/16/code-first-development-with-entity-framework-4.aspx">Strategie ist es immer die Datenbank</a> neu zu erstellen. Das mag in einem Demoprojekt gehen, ist aber irgendwie nicht so clever.</p> <h3>Herr über die eigene Datenbank trotz EF Code First</h3> <p>Falls das Model und die Datenbank nicht mehr kompatibel sind, kommt eine Fehlermeldung. Diese Fehlermeldung habe ich allerdings schon gesehen obwohl die Datenbank oder das Model <strong>nicht manipuliert</strong> wurde:</p> <p><em>The model backing the 'FooDbContext' context has changed since the database was created. Consider using Code First Migrations to update the database (</em><a href="http://go.microsoft.com/fwlink/?LinkId=238269"><em>http://go.microsoft.com/fwlink/?LinkId=238269</em></a><em>).</em></p> <p>Wenn man diese Prüfung übergehen, muss man beim Appikationsstart (z.B. in der Global.asax in ASP.NET) folgende Zeile einfügen:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">Database.SetInitializer&lt;FooDbContext&gt;(null);</pre>
<p><strong>Damit wird die Überprüfung umgangen – die Funktionalität ist nicht eingeschränkt solange die Datenbank kompatibel zum Modell (und umgekehrt) ist</strong>. Aktuell nutze ich diese Variante in verschiedenen Projekten und komme damit ganz gut klar und bin trotzdem Herr über die Datenbank.</p>
<p><strong>Wichtig:</strong> Das Entity Framework kann trotzdem wunderbar ohne diesen “<a href="http://msdn.microsoft.com/en-us/library/gg679461(v=vs.113).aspx">DbInitializer</a>” auskommen und man kann neue Entitäten und die Datenbank manuell ändern. </p>
<p>Über die Entity Framework API ist es auch möglich die <strong>Datenbank falls sie nicht vorhanden ist manuell zu erstellen</strong>. Dies geschieht über diesen Aufruf: <a href="http://msdn.microsoft.com/en-us/library/system.data.entity.database.createifnotexists(v=vs.113).aspx"><strong>Database.CreateIfNotExists</strong></a></p>
<p>Damit kam ich meist recht gut aus.</p>
