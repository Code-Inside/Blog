---
layout: post
title: "HowTo: LINQ to SQL debuggen"
date: 2008-03-19 19:35
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET 3.5, Debug, LINQ, LINQ to SQL]
language: de
---
{% include JB/setup %}
<p>Da ich in einem aktuellen Projekt LINQ to SQL einsetze, kam irgendwann der Punkt: Wie debuggt man das ordentlich? Wie sieht das SQL aus, was der zum Server schickt?</p>  <p><strong>1. Variante: Visual Studio</strong></p>  <p>Die einfachste (und nahliegendste) Variante: Das debuggen mit Visual Studio</p>  <p>Einfach schauen, wie die Objekte gef&#252;llt werden und schauen ob das &#252;berhaupt logisch passt.</p>  <p>F&#252;r ein Gro&#223;teil der Fehler reicht dies erstmal, allerdings fragt man sich doch machmal, was LINQ to SQL eigentlich f&#252;r einen SQL Statement produziert.</p>  <p><strong>2. Variante: LINQ to SQL Debug Visualizer</strong></p>  <p>Daf&#252;r gibts den <a href="http://weblogs.asp.net/scottgu/archive/2007/07/31/linq-to-sql-debug-visualizer.aspx">LINQ to SQL Debug Visualizer</a>. Es ist mir unbegreiflich, warum Microsoft so ein geniales Tool so versteckt.</p>  <p><strong>3. Variante: DataContext.Log</strong></p>  <p>Wer nicht immer den Debug Visualizer nutzen kann oder mag, hat Microsoft etwas in LINQ to SQL eingebaut: <a href="http://msdn2.microsoft.com/de-de/library/system.data.linq.datacontext.log.aspx">DataContext.Log</a>&#160;</p>  <p>In Konsolenanwendungen ist dies auch praktisch - allerdings ist dies in Klassenbibliotheken ist dies nicht so einfach m&#246;glich. Allerdings gibts hier eine kleine Klasse, welche erm&#246;glicht, dass das generierte SQL in dem Debug Output Fenster sichtbar ist: <a href="http://www.u2u.info/Blogs/Kris/Lists/Posts/Post.aspx?ID=11">Sending the LINQ To SQL log to the debugger output window</a></p>  <p>Ich werde sicherlich noch den einen oder anderen Post zum Thema LINQ to SQL schreiben - allerdings sind manche Probleme auch zum Teil vom Konzept so oder leicht &quot;trickreich&quot; ;)</p>  <p>Diese 3. Varianten machen aber das Leben schon etwas leichter.</p>
