---
layout: page
title: "HowTo: eBay API (Aktuelle Suchbegriffe...)"
date: 2007-04-13 09:29
author: robert.muehsig
comments: true
categories: []
tags: []
---
Auf shoppingmap.de sieht man gleich auf der Startseite die eBay - Top 10 Suchbegriffe.

Diese Suchbegriffe sind nicht von mir zusammengestellt, sondern stammen von eBay selber. Da diese Suchbegriffe Trends erkennen lassen, ist es eine nette Spielerei.
Dieses HowTo baut auf dem erstern auf, weil man die InterfaceService Klasse braucht.

Der nachfolgende Code zeigt, wie man ganz einfach die Topsuchbegriffe bei eBay findet. Es ist (glaub ich) auch möglich, die Topsuchbegriffe aus den einzelnen eBay Kategorien zu finden. Allerdings ist das jetzt die einfachste Form des aufrufs (natürlich in einem Konsolenprogramm) :
<pre style="font-size: 8pt">
InterfaceService MyeBay = new InterfaceService("GetPopularKeywords"); 
GetPopularKeywordsRequestType Request = new GetPopularKeywordsRequestType(); 
Request.Version = "495"; 
try 
{ 
GetPopularKeywordsResponseType Response = new GetPopularKeywordsResponseType(); 
Response = MyeBay.EBayService.GetPopularKeywords(Request);      

System.Console.WriteLine(Response.CategoryArray[0].Keywords); 
System.Console.Read(); 
} 
catch (Exception e) 
{ 
System.Console.WriteLine(e.Message); 
System.Console.Read(); 
}</pre>
Wie man Sieht... sehr einfach - nur ein Requestobjekt mit der Versionsinformation und dem InterfaceService übergeben.

Zukunftsaussichten: Wenn alle eBay Sachen, welche auch auf <a href="http://www.shoppingmap.de">www.shoppingmap.de</a> zur Anwendung kommen, hier kurz vorgestellt sind, werd ich auch zu GoogleMaps und anderen APIs (z.B. die Amazon API, welche ebenfalls sehr interessant ist).

Grüße,

Robert
